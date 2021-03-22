defmodule SosWeb.OrderMenuController do
  use SosWeb, :controller

  alias Sos.OrderMenus
  alias Sos.OrderMenus.OrderMenu

  action_fallback SosWeb.FallbackController

  def index(conn, _params) do
    order_menus = OrderMenus.list_order_menus()
    render(conn, "index.json", order_menus: order_menus)
  end

  def create(conn, %{"order_menu" => order_menu_params}) do
    with {:ok, %OrderMenu{} = order_menu} <- OrderMenus.create_order_menu(%{}, %{}, order_menu_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_menu_path(conn, :show, order_menu))
      |> render("show.json", order_menu: order_menu)
    end
  end

  def show(conn, %{"id" => id}) do
    order_menu = OrderMenus.get_order_menu!(id)
    render(conn, "show.json", order_menu: order_menu)
  end

  def update(conn, %{"id" => id, "order_menu" => order_menu_params}) do
    order_menu = OrderMenus.get_order_menu!(id)

    with {:ok, %OrderMenu{} = order_menu} <- OrderMenus.update_order_menu(order_menu, order_menu_params) do
      render(conn, "show.json", order_menu: order_menu)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_menu = OrderMenus.get_order_menu!(id)

    with {:ok, %OrderMenu{}} <- OrderMenus.delete_order_menu(order_menu) do
      send_resp(conn, :no_content, "")
    end
  end
end
