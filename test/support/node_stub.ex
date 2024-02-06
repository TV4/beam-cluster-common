defmodule NodeStub do
  def get_node("session_store") do
    :"session_store@127.0.0.2"
  end

  def get_node("non_existant") do
    {:error, :no_alive_node}
  end
end
