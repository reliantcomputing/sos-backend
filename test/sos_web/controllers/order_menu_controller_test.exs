defmodule SosWeb.OrderMenuControllerTest do
  use SosWeb.ConnCase

  alias Sos.OrderMenus
  alias Sos.OrderMenus.OrderMenu

  @create_attrs %{
    qty: 42
  }
  @update_attrs %{
    qty: 43
  }
  @invalid_attrs %{qty: nil}

  def fixture(:order_menu) do
    {:ok, order_menu} = OrderMenus.create_order_menu(@create_attrs)
    order_menu
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order_menus", %{conn: conn} do
      conn = get(conn, Routes.order_menu_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order_menu" do
    test "renders order_menu when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_menu_path(conn, :create), order_menu: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_menu_path(conn, :show, id))

      assert %{
               "id" => id,
               "qty" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_menu_path(conn, :create), order_menu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order_menu" do
    setup [:create_order_menu]

    test "renders order_menu when data is valid", %{conn: conn, order_menu: %OrderMenu{id: id} = order_menu} do
      conn = put(conn, Routes.order_menu_path(conn, :update, order_menu), order_menu: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_menu_path(conn, :show, id))

      assert %{
               "id" => id,
               "qty" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order_menu: order_menu} do
      conn = put(conn, Routes.order_menu_path(conn, :update, order_menu), order_menu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order_menu" do
    setup [:create_order_menu]

    test "deletes chosen order_menu", %{conn: conn, order_menu: order_menu} do
      conn = delete(conn, Routes.order_menu_path(conn, :delete, order_menu))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_menu_path(conn, :show, order_menu))
      end
    end
  end

  defp create_order_menu(_) do
    order_menu = fixture(:order_menu)
    %{order_menu: order_menu}
  end
end
