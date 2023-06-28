import run_app/web
import gleam/http.{Get, Post}
import gleam/http/request
import gleam/http/response

pub fn not_found_test() {
  let resp =
    request.new()
    |> request.set_method(Get)
    |> request.set_path("/")
    |> request.set_body(<<>>)
    |> web.service()

  let assert 404 = resp.status
  let assert <<"There's nothing here. Try POSTing to /echo":utf8>> = resp.body
}

pub fn hello_nubi_test() {
  let resp =
    request.new()
    |> request.set_method(Get)
    |> request.set_path("/hello/Nubi")
    |> request.set_body(<<>>)
    |> web.service()

  let assert 200 = resp.status
  let assert <<"Hello, Nubi!":utf8>> = resp.body
}

pub fn hello_joe_test() {
  let resp =
    request.new()
    |> request.set_method(Get)
    |> request.set_path("/hello/Mike")
    |> request.set_body(<<>>)
    |> web.service()

  let assert 200 = resp.status
  let assert <<"Hello, Joe!":utf8>> = resp.body
}

pub fn echo_1_test() {
  let resp =
    request.new()
    |> request.set_method(Post)
    |> request.set_path("/echo")
    |> request.set_body(<<1, 2, 3, 4>>)
    |> request.prepend_header("content-type", "application/octet-stream")
    |> web.service()

  let assert 200 = resp.status
  let assert <<1, 2, 3, 4>> = resp.body
  let assert Ok("application/octet-stream") =
    response.get_header(resp, "content-type")
}

pub fn echo_2_test() {
  let resp =
    request.new()
    |> request.set_method(Post)
    |> request.set_path("/echo")
    |> request.set_body(<<"Hello, Gleam!":utf8>>)
    |> request.prepend_header("content-type", "text/plain")
    |> web.service()

  let assert 200 = resp.status
  let assert <<"Hello, Gleam!":utf8>> = resp.body
  let assert Ok("text/plain") = response.get_header(resp, "content-type")
}

pub fn echo_3_test() {
  let resp =
    request.new()
    |> request.set_method(Post)
    |> request.set_path("/echo")
    |> request.set_body(<<"Hello, Gleam!":utf8>>)
    |> web.service()

  let assert 200 = resp.status
  let assert <<"Hello, Gleam!":utf8>> = resp.body
  let assert Ok("application/octet-stream") =
    response.get_header(resp, "content-type")
}
