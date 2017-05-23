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

  post "/create/:name" do
    person = %StudyElixir.Person{name: name}
    StudyElixir.Repo.insert(person)

    send_resp(conn, 200, "create\n
              #{person.name}")
  end

  get "/read/:id" do
    person = StudyElixir.Person
             |> StudyElixir.Repo.get(id)

    send_resp(conn, 200, "
              read\n
              id: #{person.id}
              name: #{person.name}")
  end

  post "/update/:id/:name" do
    person = StudyElixir.Person
             |> StudyElixir.Repo.get(id)
    changeset = StudyElixir.Person.changeset(person, %{name: name})
    StudyElixir.Repo.update(changeset)

    send_resp(conn, 200, "
              update\n
              id: #{id}
              name: #{name}")
  end

  post "/delete/:id/" do
    person = StudyElixir.Person
             |> StudyElixir.Repo.get(id)
    StudyElixir.Repo.delete(person)

    send_resp(conn, 200, "
              delete\n
              id: #{person.id}")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end

Plug.Adapters.Cowboy.http StudyElixir.Plug.Router, []
