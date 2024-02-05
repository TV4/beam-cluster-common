defmodule NodePickerTest do
  use ExUnit.Case
  doctest NodePicker

  test "get one node" do
    assert NodePicker.get_node("session_store", NodeStub) == {:ok, :"session_store@127.0.0.2"}
  end

  test "fetching non existant node" do
    assert NodePicker.get_node("non_existant", NodeStub) == {:error, :no_alive_node}
  end
end
