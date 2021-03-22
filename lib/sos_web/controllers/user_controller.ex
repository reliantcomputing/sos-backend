defmodule SosWeb.UserController do
  use SosWeb, :controller

  alias Sos.Accounts
  alias Sos.Accounts.User

  action_fallback SosWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    case Sos.MTCAuth.authenticate(email, password) do
      {:ok, user, token}->
        conn
        |> put_status(:created)
        |> render("login.json", %{user: user, token: token})
      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", %{error: message})
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    IO.inspect("Hello World")
    role_name = user_params["role_name"]
    role = Sos.Roles.get_role_by_name(role_name)
    with {:ok, %User{} = user} <- Accounts.register_user(role, user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = _user} <- Accounts.update_user(user, user_params) do
      user = Accounts.get_user!(id)
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = _user} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
