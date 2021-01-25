package bottle

default allow = false

allow {
  roles[input.user] == "read"
  input.method == "GET"
}

allow {
  roles[input.user] == "read-write"
  input.method == "GET"
}

allow {
  roles[input.user] == "read-write"
  input.method == "POST"
}

allow {
  roles[input.user] == "read-write"
  input.method == "DELETE"
}


roles = {
  "john":"read",
  "david":"read-write",
}