defmodule GameServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def join() do
    GenServer.call(__MODULE__, :join)
  end

  def leave(uid) do
    GenServer.cast(__MODULE__, {:leave, uid})
  end

  def all() do
    GenServer.call(__MODULE__, :all)
  end

  def update_score(uid, new_score) do
    GenServer.cast(__MODULE__, {:update_score, uid, new_score})
  end

  def top() do
    GenServer.call(__MODULE__, :top)
  end

  def clear() do
    GenServer.cast(__MODULE__, :clear)
  end

  # Server callbacks

  def init(_) do
    {:ok, []}
  end

  def handle_call(:join, _from, players) do
    player = %Player{name: FlappyServer.NameGenerator.build, uid: UUID.uuid1(), score: 0}

    {:reply, player, [player | players]}
  end

  def handle_call(:all, _from, players) do
    {:reply, players, players}
  end

  def handle_call(:top, _from, players) do
    top_players =
      players
        |> Enum.sort(fn(p1, p2) -> p1.score > p2.score end)
        |> Enum.take(5)

    {:reply, top_players, players}
  end

  def handle_cast({:leave, uid}, players) do
    updated_players = Enum.reject players, fn(p) -> p.uid == uid end
    {:noreply, updated_players}
  end

  def handle_cast({:update_score, uid, new_score}, players) do
    index = players |> Enum.find_index(fn(p) -> p.uid == uid end)

    player = players
    |> Enum.at(index)
    |> Map.put(:score, new_score)

    updated_players = players |> List.delete_at(index)

    {:noreply, [player | updated_players] }
  end

  def handle_cast(:clear, players) do
    {:noreply, []}
  end
end
