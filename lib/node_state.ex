defmodule BeamClusterCommon.NodeState do
  use GenServer
  require Logger

  def get_state() do
    GenServer.call(__MODULE__, :get_state)
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :net_kernel.monitor_nodes(true)
    {:ok, %{}}
  end

  def handle_call(:get_state, _, state) do
    {:reply, state, state}
  end

  def handle_info({:nodeup, node_name}, state) do
    service_name = get_service_name(node_name)

    nodes = Map.get(state, service_name, [])

    {:noreply, Map.put(state, service_name, [node_name | nodes])}
  end

  def handle_info({:nodedown, node_name}, state) do
    service_name = get_service_name(node_name)
    nodes = Map.get(state, service_name, []) |> List.delete(node_name)

    {:noreply, Map.put(state, service_name, nodes)}
  end

  defp get_service_name(node_name) do
    [service, _ip] = node_name |> Atom.to_string() |> String.split("@")
    service
  end
end
