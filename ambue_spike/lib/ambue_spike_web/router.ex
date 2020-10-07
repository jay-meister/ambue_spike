defmodule AmbueSpikeWeb.Router do
  use AmbueSpikeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AmbueSpikeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_random_session_id
  end

  @doc """
  assign a session_id if one does not exist so we can locate returning users
  """
  def put_random_session_id(conn, _opts) do
    case get_session(conn, :session_id) do
      nil ->
        session_id =
          10
          |> :crypto.strong_rand_bytes()
          |> Base.url_encode64(padding: false)

        conn
        |> put_session(:session_id, session_id)

      _id ->
        conn
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AmbueSpikeWeb do
    pipe_through :browser

    live "/", UserLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", AmbueSpikeWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AmbueSpikeWeb.Telemetry
    end
  end
end
