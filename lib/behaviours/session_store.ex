defmodule Behaviours.SessionStore do
  alias Structs.Session
  @callback all(user_id :: String.t()) :: map() | no_return
  @callback delete(user_id :: String.t(), session_id :: String.t()) ::
              :ok | :error
  @callback delete_all(user_id :: String.t()) :: [Session.t()]

  @callback delete_other(user_id :: String.t(), session_id :: String.t()) ::
              [Session.t()]

  @callback get(session_id :: String.t()) ::
              %Session{} | nil | {:error, any()}

  @callback store(session :: Session.t()) ::
              String.t() | :error

  @callback update_session_id(
              user_id :: String.t(),
              session_id :: String.t()
            ) ::
              {:ok, String.t()} | :error

  @callback session_ids_for_user(user_id :: String.t()) :: list()
  @callback max_ttl(user_id :: String.t()) :: String.t() | nil
end
