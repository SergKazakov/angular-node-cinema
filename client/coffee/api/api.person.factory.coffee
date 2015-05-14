Person = ($http) ->
  getPersons : ->
    $http.get '/api/v1/persons'
  createPerson : (person) ->
    $http.post '/api/v1/persons', person
  getPerson : (personId) ->
    $http.get "/api/v1/person/#{personId}"
  editPerson : (person) ->
    $http.put "/api/v1/person/#{person._id}", person
  deletePerson : (personId) ->
    $http.delete "/api/v1/person/#{personId}"

module.exports = Person