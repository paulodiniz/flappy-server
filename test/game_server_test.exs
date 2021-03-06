defmodule GameServerTest do
  use ExUnit.Case
  doctest GameServer

  setup do
    GameServer.clear
  end

  test "join player", %{} do
    player = GameServer.join
    players = GameServer.all
    assert players == [player]
  end

  test "leave player", %{} do
    player = GameServer.join
    assert GameServer.leave(player.uid) == :ok
    assert GameServer.all() == []
  end

  test "update score", %{} do
    player = GameServer.join
    GameServer.update_score(player.uid, 37)
    assert GameServer.all == [%Player{uid: player.uid, name: player.name, score: 37}]
  end
end
