defmodule Behaviours.Redis do
  @callback pipeline([[atom() | binary() | integer()]]) ::
              {:ok, [Redix.Protocol.redis_value()]}
              | {:error, atom() | Redix.Error.t() | Redix.ConnectionError.t()}

  @callback pipeline([[atom() | binary() | integer()]], pool_name :: atom()) ::
              {:ok, [Redix.Protocol.redis_value()]}
              | {:error, atom() | Redix.Error.t() | Redix.ConnectionError.t()}

  @callback command([atom() | binary() | integer()]) ::
              {:ok, Redix.Protocol.redis_value()}
              | {:error, atom() | Redix.Error.t() | Redix.ConnectionError.t()}

  @callback command([atom() | binary() | integer()], pool_name :: atom()) ::
              {:ok, Redix.Protocol.redis_value()}
              | {:error, atom() | Redix.Error.t() | Redix.ConnectionError.t()}

  @callback transaction_pipeline([[binary() | integer()]]) ::
              {:ok, Redix.Protocol.redis_value()}
              | {:error, atom() | Redix.Error.t() | Redix.ConnectionError.t()}

  @callback transaction_pipeline([[binary() | integer()]], pool_name :: atom()) ::
              {:ok, Redix.Protocol.redis_value()}
              | {:error, atom() | Redix.Error.t() | Redix.ConnectionError.t()}
end
