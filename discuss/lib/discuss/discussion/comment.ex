defmodule Discuss.Discussion.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:content, :user]}
  schema "comments" do
    field :content, :string

    belongs_to :user, Discuss.Accounts.User
    belongs_to :topic, Discuss.Discussion.Topic

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
