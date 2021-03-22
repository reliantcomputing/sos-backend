defmodule SosWeb.OrderExtraView do
  use SosWeb, :view
  alias SosWeb.OrderExtraView

  def render("index.json", %{order_extras: order_extras}) do
    %{data: render_many(order_extras, OrderExtraView, "order_extra.json")}
  end

  def render("show.json", %{order_extra: order_extra}) do
    %{data: render_one(order_extra, OrderExtraView, "order_extra.json")}
  end

  def render("order_extra.json", %{order_extra: order_extra}) do
    %{
      id: order_extra.id,
      qty: order_extra.qty,
      extra: render_one(order_extra.extra, SosWeb.ExtraView, "extra.json"),
    }
  end
end
