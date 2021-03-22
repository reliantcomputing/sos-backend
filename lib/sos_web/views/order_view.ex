defmodule SosWeb.OrderView do
  use SosWeb, :view
  alias SosWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      inserted_at: order.inserted_at,
      status: order.status,
      rejected: order.rejected,
      rejected_reason: order.rejected_reason,
      extras: render_many(order.order_extras, SosWeb.OrderExtraView, "order_extra.json"),
      menus: render_many(order.order_menus, SosWeb.OrderMenuView, "order_menu.json")
    }
  end
end
