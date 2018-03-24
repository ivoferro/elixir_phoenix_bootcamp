defmodule DiscussWeb.CommentChannel do
  use DiscussWeb, :channel
  alias Discuss.Discussion

  def join("comment:" <> topic_id, payload, socket) do
    if authorized?(payload) do
      topic = Discussion.get_topic!(topic_id)
      IO.inspect(topic, label: "TOPICZINHO")
      {:ok, socket}
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

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
