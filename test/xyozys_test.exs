defmodule XyozysTest do
  use ExUnit.Case
  doctest Xyozys

  test "new should return a new game" do
    assert Xyozys.new() == ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
  end
end
