defmodule FlappyServer.GameChannel do
  use FlappyServer.Web, :channel
  require IEx
  require Logger

  def join("game:lobby", payload, socket) do
    {:ok, socket}
  end

  def terminate(reason, socket) do
    GameServer.leave(socket.id)
  end

  def handle_in("join_game", %{}, socket) do
    player = GameServer.join(socket.id)
    push socket, "joined_game", player
    {:reply, :ok, socket}
  end

  def handle_in("top_players", %{}, socket) do
    top_players = GameServer.top
      |> Enum.map(fn(player) -> %{name: player.name, score: player.score, uid: player.uid} end)
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({player, index}, acc) ->
        Map.merge(acc, %{"uid_#{index}": player.uid, "score_#{index}": player.score, "name_#{index}": player.name})
      end)
    push socket, "top_players", top_players
    {:reply, {:ok, %{}}, socket}
  end

  def handle_in("update_score", %{"uid" => uid, "score" => score}, socket) do
    :ok = GameServer.update_score(uid, score)
    {:noreply, socket}
  end
end
