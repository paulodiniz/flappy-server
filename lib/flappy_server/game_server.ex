defmodule GameServer do
  use GenServer
  require IEx

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def join(player) do
    GenServer.cast(__MODULE__, {:join, player})
  end

  def exit(player) do
    GenServer.cast(__MODULE__, {:exit, player})
  end

  def update_score(player) do
  end

  def top() do
    GenServer.call(__MODULE__, :top)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(:top, _from, players) do
    top_players =
      players
        |> Enum.sort(fn(p1, p2) -> p1.score > p2.score end)
        |> Enum.take(5)

    {:reply, top_players, players}
  end

  def handle_cast({:join, player}, players) do
    {:noreply, [player | players]}
  end

  def handle_cast({:exit, player}, players) do
    updated_players = Enum.reject players, fn(p) -> p == player end
    {:noreply, updated_players}
  end
end
