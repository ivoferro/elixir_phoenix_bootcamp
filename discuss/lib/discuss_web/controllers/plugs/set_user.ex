defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn

  alias Discuss.Accounts

  def init(_params) do
  end

  def call(conn, _params) do
    user_id =
      conn
      |> get_session(:user_id)

    cond do
      user = user_id && Accounts.get_user!(user_id) ->
        conn
        |> assign(:user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end
