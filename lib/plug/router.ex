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
    {:ok, inserted_person} = StudyElixir.Repo.insert(person)

    if inserted_person do
      send_resp(conn, 200, "create\n
                id: #{inserted_person.id}
                name: #{inserted_person.name}")
    else
      send_resp(conn, 500, "
                create\n
                name: #{person.name}
                failed")
    end
  end

  get "/read/:id" do
    person = StudyElixir.Person
             |> StudyElixir.Repo.get(id)

    if person do
      send_resp(conn, 200, "
                read\n
                id: #{person.id}
                name: #{person.name}")
    else
      send_resp(conn, 500, "
                read\n
                id: #{id}
                not found")
    end
  end

  post "/update/:id/:name" do
    person = StudyElixir.Person
             |> StudyElixir.Repo.get(id)

    unless person do
      send_resp(conn, 500, "
                update\n
                id: #{id}
                not found")
    end

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

    unless person do
      send_resp(conn, 500, "
                delete\n
                id: #{id}
                not found")
    end

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
