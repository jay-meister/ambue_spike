defmodule AmbueSpike.Repo do
  use Ecto.Repo,
    otp_app: :ambue_spike,
    adapter: Ecto.Adapters.Postgres
end
