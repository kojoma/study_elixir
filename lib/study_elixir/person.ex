defmodule StudyElixir.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :name, :string
  end

  @all_fields ~w(name)

  def changeset(person, params \\ %{}) do
    person
    |> cast(params, @all_fields)
  end
end
