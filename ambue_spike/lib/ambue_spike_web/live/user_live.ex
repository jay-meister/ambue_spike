defmodule AmbueSpikeWeb.UserLive do
  use AmbueSpikeWeb, :live_view

  alias AmbueSpike.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, changeset: Accounts.new_user_changeset())}
  end

  @impl true
  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      Accounts.new_user_changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        {:noreply,
         socket
         |> assign(user: user)
         |> put_flash(:info, "user created")}

      {:error, changeset} ->
        # ensure error flash is removed
        {:noreply,
         socket
         |> assign(changeset: changeset)
         |> put_flash(:error, "there was an error")}
    end
  end
end
