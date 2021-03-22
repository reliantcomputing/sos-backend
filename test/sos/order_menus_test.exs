defmodule Sos.OrderMenusTest do
  use Sos.DataCase

  alias Sos.OrderMenus

  describe "order_menus" do
    alias Sos.OrderMenus.OrderMenu

    @valid_attrs %{qty: 42}
    @update_attrs %{qty: 43}
    @invalid_attrs %{qty: nil}

    def order_menu_fixture(attrs \\ %{}) do
      {:ok, order_menu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OrderMenus.create_order_menu()

      order_menu
    end

    test "list_order_menus/0 returns all order_menus" do
      order_menu = order_menu_fixture()
      assert OrderMenus.list_order_menus() == [order_menu]
    end

    test "get_order_menu!/1 returns the order_menu with given id" do
      order_menu = order_menu_fixture()
      assert OrderMenus.get_order_menu!(order_menu.id) == order_menu
    end

    test "create_order_menu/1 with valid data creates a order_menu" do
      assert {:ok, %OrderMenu{} = order_menu} = OrderMenus.create_order_menu(@valid_attrs)
      assert order_menu.qty == 42
    end

    test "create_order_menu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderMenus.create_order_menu(@invalid_attrs)
    end

    test "update_order_menu/2 with valid data updates the order_menu" do
      order_menu = order_menu_fixture()
      assert {:ok, %OrderMenu{} = order_menu} = OrderMenus.update_order_menu(order_menu, @update_attrs)
      assert order_menu.qty == 43
    end

    test "update_order_menu/2 with invalid data returns error changeset" do
      order_menu = order_menu_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderMenus.update_order_menu(order_menu, @invalid_attrs)
      assert order_menu == OrderMenus.get_order_menu!(order_menu.id)
    end

    test "delete_order_menu/1 deletes the order_menu" do
      order_menu = order_menu_fixture()
      assert {:ok, %OrderMenu{}} = OrderMenus.delete_order_menu(order_menu)
      assert_raise Ecto.NoResultsError, fn -> OrderMenus.get_order_menu!(order_menu.id) end
    end

    test "change_order_menu/1 returns a order_menu changeset" do
      order_menu = order_menu_fixture()
      assert %Ecto.Changeset{} = OrderMenus.change_order_menu(order_menu)
    end
  end
end
