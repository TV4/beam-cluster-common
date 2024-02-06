defmodule BeamClusterCommon.NodeState do
  use GenServer
  require Logger

  def get_state() do
    GenServer.call(__MODULE__, :get_state)
  end

  def get_node(service) do
    GenServer.call(__MODULE__, {:get_node, service})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :net_kernel.monitor_nodes(true)
    service_name = get_service_name(Node.self())

    {:ok, Map.put(%{}, service_name, [Node.self()])}
  end

  def handle_call(:get_state, _, state) do
    {:reply, state, state}
  end

  def handle_call({:get_node, service}, _, state) do
    result =
      state
      |> Map.get(service, [])
      |> pick_and_validate_random_node()

    {:reply, result, state}
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

  defp pick_and_validate_random_node(nodes) do
    Enum.shuffle(nodes)
    |> pick_node()
  end

  defp pick_node([]), do: {:error, :no_alive_node}

  defp pick_node([node | rest]) do
    case :net_adm.ping(node) do
      :pong ->
        node

      :pang ->
        # deregister node if ping is unsuccessful
        send(self(), {:nodedown, node})
        pick_and_validate_random_node(rest)
    end
  end
end
