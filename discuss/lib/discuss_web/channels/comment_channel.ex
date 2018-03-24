defmodule DiscussWeb.CommentChannel do
  use DiscussWeb, :channel
  alias Discuss.Discussion

  def join("comment:" <> topic_id, payload, socket) do
    if authorized?(payload) do
      topic = Discussion.get_topic!(topic_id)
      {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (comment:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("comment:add", comment_attrs, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id
    case Discuss.Discussion.create_comment(comment_attrs, topic, user_id) do
      {:ok, comment} ->
        broadcast!(socket, "comment:#{topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
