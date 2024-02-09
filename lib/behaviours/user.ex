defmodule Behaviours.User do
  @moduledoc """
  User operations. Including parsing and database operations
  """

  # User operations calls
  @callback create_user(user_params :: Structs.User.parsed_input_user_params()) ::
              {:ok, Types.User.user()} | {:error, Ecto.Changeset.t()}

  @callback update_user(uid :: String.t(), user_params :: Structs.User.parsed_input_user_params()) ::
              {:ok, Types.User.user()} | {:error, Ecto.Changeset.t()}

  @callback delete_user(uid :: String.t(), country_code :: :SWE | :FIN) ::
              {:ok, Types.User.user()} | {:error, Ecto.Changeset.t()}

  # User database calls
  @callback fetch_all(Types.User.user_query()) :: [Types.User.user()] | Scrivener.Page.t()

  @callback fetch(Types.User.user_query()) :: {:ok, Types.User.user()} | {:error, :not_found}

  # parse user calls
  @callback to_database_user_params(Types.User.user_input_params()) ::
              {:ok, Structs.User.parsed_user_data()} | {:error, term()}

  @callback to_update_database_user_params(Types.User.user_input_params()) ::
              {:ok, Structs.User.parsed_user_data()} | {:error, term()}

  @callback from_database_user(Types.User.user()) ::
              {:ok, Structs.User.parsed_user_data()} | {:error, term()}
end
