defmodule BeamClusterCommonTest do
  use ExUnit.Case
  doctest BeamClusterCommon

  test "greets the world" do
    assert BeamClusterCommon.hello() == :world
  end
end
