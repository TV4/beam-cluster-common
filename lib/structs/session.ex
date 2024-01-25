defmodule Structs.Session do
  @derive Jason.Encoder
  defstruct ~w(expires session_id user_id)a

  @type t :: %__MODULE__{}

  @session_id_prefix "avod"
  @ttl 60 * 60 * 24 * 365

  def new(user_id, expires \\ nil) do
    %__MODULE__{
      expires: expires || :os.system_time(:second) + @ttl,
      session_id: generate_session_id(),
      user_id: user_id
    }
  end

  def generate_session_id, do: session_id_generator().generate_with_prefix(@session_id_prefix)

  defp session_id_generator,
    do:
      Application.get_env(:session_store, :session_id_generator, SessionStore.SessionIDGenerator)
end
