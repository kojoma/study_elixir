defmodule StudyElixir.Plug.Router do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "
              usage\n
              create/:name : create name
              read/:id : read name
              upate/:id/:name : update xxx
              delete/:id : delete xxx
              ")
  end

  get "/create/:name" do
    send_resp(conn, 200, "create #{name}")
  end

  get "/read/:id" do
    send_resp(conn, 200, "read #{id}")
  end

  get "/update/:id/:name" do
    send_resp(conn, 200, "update #{id} #{name}")
  end

  get "/delete/:id/" do
    send_resp(conn, 200, "delete #{id}")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end

Plug.Adapters.Cowboy.http StudyElixir.Plug.Router, []
