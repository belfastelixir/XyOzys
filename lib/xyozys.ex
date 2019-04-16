defmodule Xyozys do
  @type game :: list(cell_value)
  @type cell_value :: :_ | player
  @type cell :: 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  @type player :: :X | :O
  @type winner :: :tie | player
  @type status :: {:over, winner} | {:turn, player}
  @type reason :: :game_over | :not_players_turn | :cell_already_set

  @empty [:_, :_, :_, :_, :_, :_, :_, :_, :_]

  @spec new() :: game()
  def new() do
    @empty
  end

  @spec turn(game, cell, player) :: {:ok, game} | {:error, reason}
  def turn(game, cell, player) do
    case status(game) do
      {:over, _} ->
        {:error, :game_over}

      {:turn, ^player} ->
        case value_at(game, cell) do
          :_ ->
            {:ok, set_cell(game, cell, player)}

          _ ->
            {:error, :cell_already_set}
        end

      {:turn, _} ->
        {:error, :not_players_turn}
    end
  end

  @spec status(game) :: status
  def status(game) do
    with :not_finished <- who_won(game),
         turn <- whose_turn(game) do
      turn
    else
      {:over, _} = result ->
        result
    end
  end

  @def false
  @spec who_won(game) :: {:over, :tie | player}
  def who_won(game) do
    over(game)
  end

  @doc false
  @spec whose_turn(game) :: {:turn, player} | :neither
  def whose_turn(game)

  def whose_turn(@empty) do
    {:turn, :X}
  end

  def whose_turn(game) do
    xs = Enum.count(game, &(&1 == :X))
    os = Enum.count(game, &(&1 == :O))

    cond do
      xs > os -> {:turn, :O}
      true -> {:turn, :X}
    end
  end

  @doc false
  @spec value_at(game, cell) :: cell_value
  def value_at(game, cell) do
    Enum.at(game, cell)
  end

  @doc false
  @spec set_cell(game, cell, player) :: game
  def set_cell(game, cell, player) do
    List.replace_at(game, cell, player)
  end

  @doc false
  @spec over(game) :: {:over, :tie | :player} | :not_finished
  def over([
    p, p, p,
    _, _, _,
    _, _, _
  ]) when p !== :_, do: {:over, p}

  def over([
    _, _, _,
    p, p, p,
    _, _, _
  ]) when p !== :_, do: {:over, p}

  def over([
    _, _, _,
    _, _, _,
    p, p, p
  ]) when p !== :_, do: {:over, p}

  def over([
    p, _, _,
    _, p, _,
    _, _, p
  ]) when p !== :_, do: {:over, p}

  def over([
    _, _, p,
    _, p, _,
    p, _, _
  ]) when p !== :_, do: {:over, p}

  def over([
    p, _, _,
    p, _, _,
    p, _, _
  ]) when p !== :_, do: {:over, p}

  def over([
    _, p, _,
    _, p, _,
    _, p, _
  ]) when p !== :_, do: {:over, p}

  def over([
    _, _, p,
    _, _, p,
    _, _, p
  ]) when p !== :_, do: {:over, p}

  def over(game) do
    blanks = Enum.count(game, &(&1 == :_))
    case blanks do
      0 -> {:over, :tie}
      _ -> :not_finished
    end
  end
end
