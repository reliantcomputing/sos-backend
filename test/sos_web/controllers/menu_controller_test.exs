defmodule SosWeb.MenuControllerTest do
  use SosWeb.ConnCase

  alias Sos.Menus
  alias Sos.Menus.Menu

  @create_attrs %{
    description: "some description",
    image: "some image",
    price: "120.5",
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    image: "some updated image",
    price: "456.7",
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, image: nil, price: nil, title: nil}

  def fixture(:menu) do
    {:ok, menu} = Menus.create_menu(@create_attrs)
    menu
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all menus", %{conn: conn} do
      conn = get(conn, Routes.menu_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create menu" do
    test "renders menu when data is valid", %{conn: conn} do
      conn = post(conn, Routes.menu_path(conn, :create), menu: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.menu_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "image" => "some image",
               "price" => "120.5",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.menu_path(conn, :create), menu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update menu" do
    setup [:create_menu]

    test "renders menu when data is valid", %{conn: conn, menu: %Menu{id: id} = menu} do
      conn = put(conn, Routes.menu_path(conn, :update, menu), menu: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.menu_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "image" => "some updated image",
               "price" => "456.7",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, menu: menu} do
      conn = put(conn, Routes.menu_path(conn, :update, menu), menu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete menu" do
    setup [:create_menu]

    test "deletes chosen menu", %{conn: conn, menu: menu} do
      conn = delete(conn, Routes.menu_path(conn, :delete, menu))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.menu_path(conn, :show, menu))
      end
    end
  end

  defp create_menu(_) do
    menu = fixture(:menu)
    %{menu: menu}
  end
end
