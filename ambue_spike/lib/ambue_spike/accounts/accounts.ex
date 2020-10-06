defmodule AmbueSpike.Accounts do
  alias AmbueSpike.Accounts.User
  alias AmbueSpike.Repo

  def new_user_changeset(params \\ %{}) do
    User.changeset(%User{}, params)
  end

  def create_user(params) do
    User.changeset(%User{}, params)
    |> Repo.insert()
  end
end
