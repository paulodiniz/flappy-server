defmodule GameServerTest do
  use ExUnit.Case
  doctest GameServer

  setup do
    {:ok, pid} = GameServer.start_link([])
    %{server: pid}
  end

  test "join player", %{server: _} do
    player = GameServer.join
    assert player.score == 0
    assert player.name
    assert player.uid
    assert GameServer.all() == [%Player{score: 0, name: player.name, uid: player.uid}]
  end

  test "leave player", %{server: _} do
    player = GameServer.join
    assert GameServer.leave(player.uid) == :ok
    assert GameServer.all() == []
  end
end
