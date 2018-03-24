defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Discussion
  alias Discuss.Discussion.Topic

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    topics = Discussion.list_topics()

    conn
    |> render("index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    conn
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Discussion.create_topic(topic, conn.assigns.user) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    topic = Discussion.get_topic!(id)
    changeset = Topic.changeset(topic, %{})

    conn
    |> render("edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic}) do
    old_topic = Discussion.get_topic!(id)

    case Discussion.update_topic(old_topic, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    Discussion.get_topic!(id)
    |> Discussion.delete_topic!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Discussion.get_topic!(topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that topic")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Discussion.get_topic!(id)

    conn
    |> render("show.html", topic: topic)
  end
end
