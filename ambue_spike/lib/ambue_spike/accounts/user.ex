defmodule AmbueSpike.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset

  @placeholder_email_check ~r/@/

  schema "users" do
    field :name, :string
    field :email, :string
  end

  def changeset(user, params) do
    required_fields = [:name, :email]

    user
    |> cast(params, required_fields)
    |> validate_format(:email, @placeholder_email_check)
    |> validate_required(required_fields)
  end
end
