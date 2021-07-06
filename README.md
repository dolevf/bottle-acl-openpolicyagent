# Bottle Authorization with Open Policy Agent
Add Authorization to Python's Bottle Framework with Open Policy Agent

# About
This small example app demonstrates how to implement Access Control / Authorization in Python's Bottle Framework, using Open Policy Agent.

You can get a list of movies, delete or add movies to the list, depending on the requesting user's permissions.

The application has 2 built in users and roles:
* John (read)
* David (read-write)

The app comes with a simple Open Policy Agent policy.

By default, the App will query OPA locally on http://localhost:8181, you can change this by setting an environment variable:
`export OPA_SERVER="http://opa.server:8181"`

# Usage
## Download OPA
Download OPA from: https://www.openpolicyagent.org/docs/latest/#running-opa

## Run OPA
`./opa run -s policy.rego`
This will start the OPA server on the localhost on port 8080

## Install requirements
`pip3 install -r requirements`

## Run Bottle App
`python3 main.py`

## Query App using various users
### get movies using an authorized user (GET)

Listing Movies with John's user should be successful, since John has read permissions.
```
requests.get('http://localhost:8080/movies', headers={'X-Requesting-User':'john'}).text

'{"data": ["despicable me", "borat"]}'
```
### Add movies using an unauthorized user (POST)
Adding a movie with John's user should fail, since John does not have write permissions.
```
requests.post('http://localhost:8080/movies/Matrix', headers={'X-Requesting-User':'john'}).text
'{"Error": "Unauthorized"}'
```
### Delete movies using an unauthorized user (DELETE)
Deleting a movie with John's user should fail, since John does not have write permissions.
```
requests.delete('http://localhost:8080/movies/Matrix', headers={'X-Requesting-User':'john'}).text
'{"Error": "Unauthorized"}'
```

### Add movies using an authorized user (POST)
Adding a movie with David's user should be successful, since David has read-write permissions.
```
requests.post('http://localhost:8080/movies/Matrix', headers={'X-Requesting-User':'john'}).text
'{"data": ["despicable me", "borat", "Matrix"]}'
```

### Delete movies using an authorized user (DELETE)
Deleting a movie with David's user should be successful, since David has read-write permissions.
```
requests.delete('http://localhost:8080/movies/Matrix', headers={'X-Requesting-User':'john'}).text
'{"data": ["despicable me", "borat"]}'
```


