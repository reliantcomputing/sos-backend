defmodule SosWeb.MenuController do
  use SosWeb, :controller

  alias Sos.Menus
  alias Sos.Menus.Menu

  action_fallback SosWeb.FallbackController

  def index(conn, _params) do
    menus = Menus.list_menus()
    render(conn, "index.json", menus: menus)
  end

  def create(conn, %{"menu" => menu_params}) do
    with {:ok, %Menu{} = menu} <- Menus.create_menu(menu_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.menu_path(conn, :show, menu))
      |> render("show.json", menu: menu)
    end
  end

  def show(conn, %{"id" => id}) do
    menu = Menus.get_menu!(id)
    render(conn, "show.json", menu: menu)
  end

  def update(conn, %{"id" => id, "menu" => menu_params}) do
    menu = Menus.get_menu!(id)

    with {:ok, %Menu{} = menu} <- Menus.update_menu(menu, menu_params) do
      render(conn, "show.json", menu: menu)
    end
  end

  def delete(conn, %{"id" => id}) do
    menu = Menus.get_menu!(id)

    with {:ok, %Menu{}} <- Menus.delete_menu(menu) do
      send_resp(conn, :no_content, "")
    end
  end
end
