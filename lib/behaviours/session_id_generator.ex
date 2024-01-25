defmodule Behaviours.SessionIDGenerator do
  @callback generate() :: String.t()
  @callback generate_with_prefix(String.t()) :: String.t()
end
