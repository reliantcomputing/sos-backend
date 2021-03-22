defmodule SosWeb.OrderExtraControllerTest do
  use SosWeb.ConnCase

  alias Sos.OrderExtras
  alias Sos.OrderExtras.OrderExtra

  @create_attrs %{
    qty: 42
  }
  @update_attrs %{
    qty: 43
  }
  @invalid_attrs %{qty: nil}

  def fixture(:order_extra) do
    {:ok, order_extra} = OrderExtras.create_order_extra(@create_attrs)
    order_extra
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order_extras", %{conn: conn} do
      conn = get(conn, Routes.order_extra_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order_extra" do
    test "renders order_extra when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_extra_path(conn, :create), order_extra: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_extra_path(conn, :show, id))

      assert %{
               "id" => id,
               "qty" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_extra_path(conn, :create), order_extra: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order_extra" do
    setup [:create_order_extra]

    test "renders order_extra when data is valid", %{conn: conn, order_extra: %OrderExtra{id: id} = order_extra} do
      conn = put(conn, Routes.order_extra_path(conn, :update, order_extra), order_extra: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_extra_path(conn, :show, id))

      assert %{
               "id" => id,
               "qty" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order_extra: order_extra} do
      conn = put(conn, Routes.order_extra_path(conn, :update, order_extra), order_extra: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order_extra" do
    setup [:create_order_extra]

    test "deletes chosen order_extra", %{conn: conn, order_extra: order_extra} do
      conn = delete(conn, Routes.order_extra_path(conn, :delete, order_extra))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_extra_path(conn, :show, order_extra))
      end
    end
  end

  defp create_order_extra(_) do
    order_extra = fixture(:order_extra)
    %{order_extra: order_extra}
  end
end
