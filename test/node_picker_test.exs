defmodule NodePickerTest do
  use ExUnit.Case
  doctest NodePicker

  test "get one node" do
    assert NodePicker.get_node("session_store", NodeStub) in [
             :"session_store@127.0.0.2",
             :"session_store@127.0.0.3"
           ]
  end

  test "fetching non existant node" do
    refute NodePicker.get_node("non_existant", NodeStub)
  end
end
