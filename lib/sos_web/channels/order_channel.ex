defmodule SosWeb.OrderChannel do
  use SosWeb, :channel

  @impl true
  def join("order", _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("place:order", payload, socket) do
    # Access data from payload
    sit_number = payload["sit_number"]
    new_order = payload["order"]
    extras = payload["extras"]
    menus = payload["menus"]

    # get a sit
    sit = Sos.Sits.get_by_sit_number(sit_number)

    with {:ok, order} <- Sos.Orders.create_order(sit, new_order) do
      extras |> Enum.each(fn extra ->
        %{"id" => id, "qty" => qty} = extra
        ex = Sos.Extras.get_extra!(id)
        if ex do
          new_extra = %{
            qty: qty
          }
          Sos.OrderExtras.create_order_extra(order, ex, new_extra)
        end
      end)
      menus |> Enum.each(fn menu ->
        %{"id" => id, "qty" => qty} = menu
        me = Sos.Menus.get_menu!(id)
        if me do
          new_menu = %{
            qty: qty
          }
          IO.inspect(Sos.OrderMenus.create_order_menu(order, me, new_menu))
        end
      end)
      broadcast(socket, "place:order", %{
        id: order.id,
        status: "ORDER_PLACED"
      })
      {:reply, :ok, socket}
    end
  end

  @impl true
  def handle_in("reject:order:"<>order_id, payload, socket) do
    order = Sos.Orders.get_order!(order_id)
    IO.inspect(Sos.Orders.update_order(order, payload))
    with {:ok, order} <- Sos.Orders.update_order(order, payload) do
      broadcast(socket, "reject:order:"<>order_id, %{
        id: order.id,
        status: "ORDER_REJECTED"
      })
    end
  end

  @impl true
  def handle_in("pay:order:"<>order_id, payload, socket) do
    order = Sos.Orders.get_order!(order_id)
    IO.inspect(Sos.Orders.update_order(order, payload))
    with {:ok, order} <- Sos.Orders.update_order(order, payload) do
      broadcast(socket, "pay:order:"<>order_id, %{
        id: order.id,
        status: "ORDER_PAID"
      })
    end
  end

  @impl true
  def handle_in("approve:order:"<>order_id, payload, socket) do
    IO.inspect("Updating order............................")
    order = Sos.Orders.get_order!(order_id)
    IO.inspect(Sos.Orders.update_order(order, payload))
    with {:ok, order} <- Sos.Orders.update_order(order, payload) do
      broadcast(socket, "approve:order:"<>order_id, %{
        id: order.id,
        status: "ORDER_APPROVED"
      })
    end
  end

  @impl true
  def handle_in("add:more:items", _payload, socket) do
    # extras = payload["extras"]
    # menus = payload["menus"]
    # order_id = payload["order_id"]
    # order = Sos.Orders.get_order!(order_id)
    broadcast(socket, "", %{})
  end
end
