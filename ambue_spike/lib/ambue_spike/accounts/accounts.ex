defmodule AmbueSpike.Accounts do
  @moduledoc """
  Accounts context is used to manage users
  """

  alias AmbueSpike.Accounts.User
  alias AmbueSpike.Repo

  def new_user_changeset(params \\ %{}) do
    User.changeset(%User{}, params)
  end

  def user_changeset(user, params) do
    User.changeset(user, params)
  end

  def create_user(params) do
    User.changeset(%User{}, params)
    |> Repo.insert()
  end
end
