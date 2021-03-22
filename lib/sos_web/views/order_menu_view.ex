defmodule SosWeb.OrderMenuView do
  use SosWeb, :view
  alias SosWeb.OrderMenuView

  def render("index.json", %{order_menus: order_menus}) do
    %{data: render_many(order_menus, OrderMenuView, "order_menu.json")}
  end

  def render("show.json", %{order_menu: order_menu}) do
    %{data: render_one(order_menu, OrderMenuView, "order_menu.json")}
  end

  def render("order_menu.json", %{order_menu: order_menu}) do
    %{
      id: order_menu.id,
      qty: order_menu.qty,
      menu: render_one(order_menu.menu, SosWeb.MenuView, "menu.json")
    }
  end
end
