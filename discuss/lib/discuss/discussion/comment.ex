defmodule Discuss.Discussion.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "topics" do
    field :content, :string

    belongs_to :user, Discuss.Accounts.User
    belongs_to :topic, Discuss.Discussion.Topic

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
