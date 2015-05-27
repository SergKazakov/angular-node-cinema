gulp         = require 'gulp'
$            = require('gulp-load-plugins')()
wiredep      = require('wiredep').stream
runSequence  = require 'run-sequence'
childProcess = require 'child_process'

gulp.task 'webpack', ->
  gulp.src './client/coffee/main/main.coffee'
    .pipe $.webpack require './webpack.config.coffee'
    .pipe gulp.dest './client/js'

gulp.task 'wiredep', ->
  gulp.src 'client/stylus/main.styl'
    .pipe wiredep()
    .pipe gulp.dest 'client/stylus'

gulp.task 'nodemon', ->
  $.nodemon
    ext : 'coffee'
    script : 'server.coffee'

gulp.task 'coffeelint', ->
  gulp.src [
      './*.coffee'
      './server/**/*.coffee'
      '!./client'
    ]
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()

gulp.task 'watch', ->
  $.livereload.listen()
  gulp
    .watch [
      'client/js/bundle.js'
    ]
    .on 'change', $.livereload.changed
  gulp.watch ['./*.coffee', './server/**/*.coffee', '!./client'], ['coffeelint']


gulp.task 'default', ->
  childProcess.exec '"C:/Program Files/MongoDB 2.6 Standard/bin/mongod.exe" --dbpath C:/mongodb' , (err, stdout, stderr) ->
    console.log stdout
  runSequence 'nodemon', 'coffeelint', 'watch', 'webpack'
