defmodule GameServerTest do
  use ExUnit.Case
  require IEx
  doctest GameServer

  setup do
    {:ok, pid} = GameServer.start_link([])
    %{server: pid}
  end

  test "join player", %{server: pid} do
    assert GameServer.join(%Player{}) == :ok
    assert GameServer.all() == [%Player{}]
  end

  test "exit player", %{server: pid} do
    assert GameServer.join(%Player{}) == :ok
    assert GameServer.exit(%Player{}) == :ok
    assert GameServer.all() == []
  end
end
