defmodule XyozysTest do
  use ExUnit.Case
  doctest Xyozys

  test "new should return a new game" do
    assert Xyozys.new() == [:_, :_, :_, :_, :_, :_, :_, :_, :_]
  end

  test "status of new board should be X's turn" do
    assert Xyozys.new() |> Xyozys.status() == {:turn, :X}
  end

  test "after X plays a turn the cell should be set to X" do
    assert Xyozys.new()
           |> Xyozys.turn(0, :X) == {:ok, [:X, :_, :_, :_, :_, :_, :_, :_, :_]}
  end

  test "after X plays a turn and O tries to set same cell should return error" do
    assert {:ok, game} = Xyozys.new() |> Xyozys.turn(0, :X)
    assert Xyozys.turn(game, 0, :O) == {:error, :cell_already_set}
  end

  test "after X plays a turn it should be O's turn" do
    assert {:ok, game} =
             Xyozys.new()
             |> Xyozys.turn(0, :X)

    assert {:turn, :O} = Xyozys.status(game)
  end

  @win_scenarios [
    :win_hori_top,
    :win_hori_mid,
    :win_hori_bot,
    :win_vert_l,
    :win_vert_mid,
    :win_vert_r,
    :win_diag_lr,
    :win_diag_rl
  ]

  @tie_scenarios [
    :tie
  ]

  test "when X wins X should be the winner" do
    for win_scenario <- @win_scenarios do
      game = apply(__MODULE__, win_scenario, [:X])
      assert Xyozys.status(game) == {:over, :X}
    end
  end

  test "when O wins O should be the winner" do
    for win_scenario <- @win_scenarios do
      game = apply(__MODULE__, win_scenario, [:O])
      assert Xyozys.status(game) == {:over, :O}
    end
  end

  test "when tie should say so" do
    for scenario <- @tie_scenarios do
      game = apply(__MODULE__, scenario, [])
      assert Xyozys.status(game) == {:over, :tie}
    end
  end

  def tie() do
    [:X, :O, :X,
     :O, :X, :O,
     :O, :X, :O]
  end

  def win_hori_top(pl) do
    [pl, pl, pl,
     :_, :_, :_,
     :_, :_, :_]
  end

  def win_hori_mid(pl) do
    [:_, :_, :_,
      pl, pl, pl,
     :_, :_, :_]
  end

  def win_hori_bot(pl) do
    [:_, :_, :_,
     :_, :_, :_,
     pl, pl, pl]
  end

  def win_vert_l(pl) do
    [pl, :_, :_,
     pl, :_, :_,
     pl, :_, :_]
  end

  def win_vert_mid(pl) do
    [:_, pl, :_,
     :_, pl, :_,
     :_, pl, :_]
  end

  def win_vert_r(pl) do
    [:_, :_, pl,
     :_, :_, pl,
     :_, :_, pl]
  end

  def win_diag_lr(pl) do
    [pl, :_, :_,
     :_, pl, :_,
     :_, :_, pl]
  end

  def win_diag_rl(pl) do
    [:_, :_, pl,
     :_, pl, :_,
     pl, :_, :_]
  end

end
