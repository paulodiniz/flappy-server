defmodule FlappyServer.NameGenerator do

  @adjectives Application.get_env(:flappy_server, :adjectives)
  @nouns Application.get_env(:flappy_server, :nouns)

  def build() do
    :rand.seed(:exsplus)
    [@adjectives, @nouns]
    |> Enum.map(&Enum.random/1)
    |> Enum.join(" ")
  end
end
