defmodule SosWeb.OrderExtraController do
  use SosWeb, :controller

  alias Sos.OrderExtras
  alias Sos.OrderExtras.OrderExtra

  action_fallback SosWeb.FallbackController

  def index(conn, _params) do
    order_extras = OrderExtras.list_order_extras()
    render(conn, "index.json", order_extras: order_extras)
  end

  def create(conn, %{"order_extra" => order_extra_params}) do
    with {:ok, %OrderExtra{} = order_extra} <- OrderExtras.create_order_extra(%{}, %{}, order_extra_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_extra_path(conn, :show, order_extra))
      |> render("show.json", order_extra: order_extra)
    end
  end

  def show(conn, %{"id" => id}) do
    order_extra = OrderExtras.get_order_extra!(id)
    render(conn, "show.json", order_extra: order_extra)
  end

  def update(conn, %{"id" => id, "order_extra" => order_extra_params}) do
    order_extra = OrderExtras.get_order_extra!(id)

    with {:ok, %OrderExtra{} = order_extra} <- OrderExtras.update_order_extra(order_extra, order_extra_params) do
      render(conn, "show.json", order_extra: order_extra)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_extra = OrderExtras.get_order_extra!(id)

    with {:ok, %OrderExtra{}} <- OrderExtras.delete_order_extra(order_extra) do
      send_resp(conn, :no_content, "")
    end
  end
end
