defmodule FlappyServer.GameChannel do
  use FlappyServer.Web, :channel

  def join("game:lobby", payload, socket) do
    {:ok, socket}
  end

  def handle_in("join_game", %{}, socket) do
    player = GameServer.join()
    push socket, "join_game", player
    {:reply, :ok, socket}
  end

  def handle_in("top_players", %{}, socket) do
    top_players = GameServer.top
    filtered_top_players = Enum.map top_players, fn(player) ->
      %{name: player.name, uid: player.uid, score: player.score}
    end
    push socket, "top_players", %{score: filtered_top_players}
    {:reply, :ok, socket}
  end


  def handle_in("update_score", %{"uid" => uid, "score" => score}, socket) do
    :ok = GameServer.update_score(uid, score)
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (game:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

end
