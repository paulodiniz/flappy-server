defmodule GameServer do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def join() do
    GenServer.call(__MODULE__, :join)
  end

  def leave(player) do
    GenServer.cast(__MODULE__, {:leave, player})
  end

  def all() do
    GenServer.call(__MODULE__, :all)
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

  def handle_call(:all, _from, players) do
    {:reply, players, players}
  end

  def handle_call(:join, _from, players) do
    player = %Player{name: FlappyServer.NameGenerator.build, uid: UUID.uuid1()}

    {:reply, player, [player | players]}
  end

  def handle_cast({:leave, uid}, players) do
    updated_players = Enum.reject players, fn(p) -> p.uid == uid end
    {:noreply, updated_players}
  end
end
