defmodule Types.User do
  @moduledoc """
  Typespec for user schema from user DB
  """
  @type user :: %{
          __struct__: atom(),
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer(),
          email: String.t(),
          username: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          country_code: :SWE | :FIN | :TEST,
          uid: String.t(),
          email_verified: boolean() | nil,
          activity_status: :active | :deleted | :forgotten,
          authentication: authentication() | nil | Ecto.Association.NotLoaded.t(),
          configuration: configuration() | nil | Ecto.Association.NotLoaded.t(),
          segmentation: segmentation() | nil | Ecto.Association.NotLoaded.t(),
          terms: [accepted_term()] | Ecto.Association.NotLoaded.t(),
          user_terms: [user_term()] | Ecto.Association.NotLoaded.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @type authentication :: %{
          __struct__: atom(),
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer(),
          password: String.t(),
          legacy_password: String.t() | nil,
          user_id: integer(),
          user: user() | Ecto.Association.NotLoaded.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @type configuration :: %{
          __struct__: atom(),
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer(),
          portability: boolean(),
          generic_ads: boolean(),
          no_ads: boolean(),
          pin_code: String.t() | nil,
          user_id: String.t() | nil,
          user: user() | Ecto.Association.NotLoaded.t(),
          additional_data: [additional_data()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @type additional_data :: %{
          __struct__: atom(),
          application: String.t(),
          claims: String.t(),
          value: any()
        }

  @type segmentation :: %{
          __struct__: atom(),
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer(),
          year_of_birth: String.t() | nil,
          zip_code: String.t() | nil,
          postal_address: String.t() | nil,
          mobile_number: String.t() | nil,
          gender: String.t() | nil,
          digital_customership_communications: boolean() | nil,
          research: boolean() | nil,
          online_account_data_marketing: boolean() | nil,
          marketing: boolean() | nil,
          mobile_number_verified: boolean(),
          user_id: String.t() | nil,
          user: user() | Ecto.Association.NotLoaded.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @type accepted_term :: %{
          __struct__: atom(),
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer(),
          site: :tv4play | :fotbollskanalen | :mtv | :mtv_uutiset,
          issue_date: Date.t(),
          users: [user()] | Ecto.Association.NotLoaded.t(),
          user_terms: [user_term()] | Ecto.Association.NotLoaded.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @type user_term :: %{
          __struct__: atom(),
          __meta__: Ecto.Schema.Metadata.t(),
          user_id: integer(),
          user: user() | Ecto.Association.NotLoaded.t(),
          term_id: integer(),
          term: accepted_term() | Ecto.Association.NotLoaded.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @type user_query :: %{
          optional(:email) => String.t(),
          optional(:email_ilike) => String.t(),
          optional(:email_or_uid_like) => String.t(),
          optional(:id) => integer(),
          optional(:uid) => String.t(),
          optional(:first_name) => String.t(),
          optional(:last_name) => String.t(),
          optional(:first_name_ilike) => String.t(),
          optional(:last_name_ilike) => String.t(),
          optional(:activity_status) => :active | :deleted | :forgotten,
          optional(:country_code) => :SWE | :FIN,
          optional(:year_of_birth) => String.t(),
          optional(:zip_code) => String.t(),
          optional(:generic_ads) => boolean(),
          optional(:portability) => boolean(),
          optional(:preload) => atom() | [atom()],
          optional(:limit) => atom() | [atom()]
        }

  @type user_input_params :: %{
          optional(String.t()) => any()
        }
end
