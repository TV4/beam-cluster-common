defmodule Behaviours.SessionUpdater do
  @callback cleanup(atom(), String.t()) :: :ok
end
