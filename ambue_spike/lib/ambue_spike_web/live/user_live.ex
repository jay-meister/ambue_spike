defmodule AmbueSpikeWeb.UserLive do
  use AmbueSpikeWeb, :live_view

  alias AmbueSpike.Accounts

  @impl true
  def mount(_params, %{"session_id" => session_id}, socket) do
    changeset =
      case :ets.lookup(:session_register, session_id) do
        [{_session_id, user_id}] ->
          Accounts.get_user(user_id)
          |> Accounts.user_changeset(%{})

        [] ->
          Accounts.new_user_changeset()
      end

    {:ok, assign(socket, session_id: session_id, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"user" => user_params} = params, socket) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        session_id = Map.fetch!(params, "session_id")
        :ets.insert(:session_register, {session_id, user.id})

        {:noreply,
         socket
         |> put_flash(:info, "saved")
         |> assign(changeset: Accounts.user_changeset(user, %{}))}

      {:error, changeset} ->
        {:noreply, socket |> assign(changeset: changeset)}
    end
  end
end
