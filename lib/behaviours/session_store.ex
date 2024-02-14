defmodule Behaviours.SessionStore do
  alias Structs.Session

  # Subject to change: Since we call session store in account, auth,.., with RPC call, add RPC error as one of the possible return type spec
  # May remove, update if we use different strategy
  @type badrpc_error :: {:badrpc, term()}

  @callback all(user_id :: String.t()) :: map() | badrpc_error()
  @callback delete(user_id :: String.t(), session_id :: String.t()) ::
              :ok | :error | badrpc_error()
  @callback delete_all(user_id :: String.t()) :: [Session.t()] | badrpc_error()

  @callback delete_other(user_id :: String.t(), session_id :: String.t()) ::
              [Session.t()] | badrpc_error()

  @callback get(session_id :: String.t()) ::
              %Session{} | nil | {:error, any()} | badrpc_error()

  @callback store(session :: Session.t()) ::
              String.t() | :error | badrpc_error()

  @callback update_session_id(
              user_id :: String.t(),
              session_id :: String.t()
            ) ::
              {:ok, String.t()} | :error | badrpc_error()

  @callback session_ids_for_user(user_id :: String.t()) :: list() | badrpc_error()
end
