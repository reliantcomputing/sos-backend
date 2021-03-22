defmodule SosWeb.Router do
  use SosWeb, :router

  import SosWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SosWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", SosWeb do
    pipe_through :api
    resources "/roles", RoleController, except: [:new, :edit]
    resources "/users", UserController
    post "/auth/login", UserController, :login
    resources "/sits", SitController, except: [:new, :edit]
    resources "/chats", ChatController, except: [:new, :edit]
    resources "/menus", MenuController, except: [:new, :edit]
    resources "/extras", ExtraController, except: [:new, :edit]
    resources "/messages", MessageController, except: [:new, :edit]
    resources "/orders", OrderController, except: [:new, :edit]
    resources "/order_extras", OrderExtraController, except: [:new, :edit]
    resources "/order_menus", OrderMenuController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SosWeb do
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
      live_dashboard "/dashboard", metrics: SosWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", SosWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", SosWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", SosWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end