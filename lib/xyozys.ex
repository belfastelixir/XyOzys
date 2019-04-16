defmodule Xyozys do
  @type game :: any()
  @type cell :: any()
  @type player :: :x | :y
  @type status :: :tie | :x_wins | :o_wins | :x_turn | :o_turn
  @type reason :: :game_over | :not_x_turn | :not_y_turn

  @empty ["_", "_", "_", "_", "_", "_", "_", "_", "_"]

  @spec new() :: game()
  def new() do
    @empty
  end

  @spec turn(game, cell, player) :: {:ok, game} | {:error, reason}
  def turn(game, cell, player) do
    :not_implemented
  end

  @spec status(game) :: status
  def status(game) do
    :not_implemented
  end
end
