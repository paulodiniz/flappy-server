defmodule GameServerTest do
  use ExUnit.Case
  doctest GameServer

  setup do
    {:ok, pid} = GameServer.start_link([])
    %{server: pid}
  end

  test "join player", %{server: _} do
    player = GameServer.join
    players = GameServer.all
    assert players == [player]
  end

  test "leave player", %{server: _} do
    player = GameServer.join
    assert GameServer.leave(player.uid) == :ok
    assert GameServer.all() == []
  end

  test "update score", %{server: _} do
    player = GameServer.join
    GameServer.update_score(player.uid, 37)
    assert GameServer.all == [%Player{uid: player.uid, name: player.name, score: 37}]
  end
end
