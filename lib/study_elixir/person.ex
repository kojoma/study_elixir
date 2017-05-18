defmodule StudyElixir.Person do
  use Ecto.Schema

  schema "people" do
    field :name, :string
  end
end
