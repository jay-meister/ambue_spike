defmodule AmbueSpikeWeb.UserLive do
  use AmbueSpikeWeb, :live_view

  alias AmbueSpike.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, changeset: Accounts.new_user_changeset())}
  end

  @impl true
  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        {:noreply,
         socket
         |> put_flash(:info, "saved")
         |> assign(changeset: Accounts.user_changeset(user, %{}))}

      {:error, changeset} ->
        {:noreply, socket |> assign(changeset: changeset)}
    end
  end
end
