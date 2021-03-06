defmodule Discuss.Discussion do
  @moduledoc """
  The Discussion context.
  """

  import Ecto.Query, warn: false
  alias Discuss.Repo

  alias Discuss.Discussion.{Topic, Comment}

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id) do
    Topic
    |> Repo.get!(id)
    |> Repo.preload(comments: [:user])
  end

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}, user) do
    user
    |> Ecto.build_assoc(:topics)
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      %Topic{}

      iex> delete_topic(topic)
      ** (Ecto.NoResultsError)

  """
  def delete_topic!(%Topic{} = topic) do
    Repo.delete!(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end


  # Comments

  @doc """
  Returns the list of comments.

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Creates a comment.
  """
  def create_comment(attrs \\ %{}, topic, user_id) do
    topic
    |> Ecto.build_assoc(:comments, user_id: user_id)
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

end
