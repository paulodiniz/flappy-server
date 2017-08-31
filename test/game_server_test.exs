defmodule GameServerTest do
  use ExUnit.Case
  doctest GameServer

  setup do
    {:ok, pid} = GameServer.start_link([])
    %{server: pid}
  end

  test "join player", %{server: _} do
    {uid, name} = GameServer.join
    players = GameServer.all
    assert players == [%Player{uid: uid, name: name, score: 0}]
  end

  test "leave player", %{server: _} do
    {uid, _} = GameServer.join
    assert GameServer.leave(uid) == :ok
    assert GameServer.all() == []
  end

  test "update score", %{server: _} do
    {uid, name} = GameServer.join
    GameServer.update_score(uid, 37)
    assert GameServer.all == [%Player{uid: uid, name: name, score: 37}]
  end
end
