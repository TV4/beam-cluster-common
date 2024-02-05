defmodule BeamClusterCommon.NodeState do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :net_kernel.monitor_nodes(true)
    {:ok, :ok}
  end

  def handle_info({:nodeup, node_name}, state) do
    Logger.info("Node up #{inspect(node_name)}")

    {:noreply, state}
  end

  def handle_info({:nodedown, node_name}, state) do
    Logger.info("Node down #{inspect(node_name)}")

    {:noreply, state}
  end
end
