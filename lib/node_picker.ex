defmodule NodePicker do
  def get_node(application_name, node_lib \\ Node) do
    node_lib.list()
    |> Enum.reduce([], fn node, acc ->
      [node_name, _ip] = node |> Atom.to_string() |> String.split("@")

      if node_name == application_name do
        [node | acc]
      else
        acc
      end
    end)
    |> case do
      [] ->
        nil

      list_of_nodes ->
        Enum.random(list_of_nodes)
    end
  end
end
