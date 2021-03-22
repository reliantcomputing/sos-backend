defmodule Sos.MenusTest do
  use Sos.DataCase

  alias Sos.Menus

  describe "menus" do
    alias Sos.Menus.Menu

    @valid_attrs %{description: "some description", image: "some image", price: "120.5", title: "some title"}
    @update_attrs %{description: "some updated description", image: "some updated image", price: "456.7", title: "some updated title"}
    @invalid_attrs %{description: nil, image: nil, price: nil, title: nil}

    def menu_fixture(attrs \\ %{}) do
      {:ok, menu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Menus.create_menu()

      menu
    end

    test "list_menus/0 returns all menus" do
      menu = menu_fixture()
      assert Menus.list_menus() == [menu]
    end

    test "get_menu!/1 returns the menu with given id" do
      menu = menu_fixture()
      assert Menus.get_menu!(menu.id) == menu
    end

    test "create_menu/1 with valid data creates a menu" do
      assert {:ok, %Menu{} = menu} = Menus.create_menu(@valid_attrs)
      assert menu.description == "some description"
      assert menu.image == "some image"
      assert menu.price == Decimal.new("120.5")
      assert menu.title == "some title"
    end

    test "create_menu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menus.create_menu(@invalid_attrs)
    end

    test "update_menu/2 with valid data updates the menu" do
      menu = menu_fixture()
      assert {:ok, %Menu{} = menu} = Menus.update_menu(menu, @update_attrs)
      assert menu.description == "some updated description"
      assert menu.image == "some updated image"
      assert menu.price == Decimal.new("456.7")
      assert menu.title == "some updated title"
    end

    test "update_menu/2 with invalid data returns error changeset" do
      menu = menu_fixture()
      assert {:error, %Ecto.Changeset{}} = Menus.update_menu(menu, @invalid_attrs)
      assert menu == Menus.get_menu!(menu.id)
    end

    test "delete_menu/1 deletes the menu" do
      menu = menu_fixture()
      assert {:ok, %Menu{}} = Menus.delete_menu(menu)
      assert_raise Ecto.NoResultsError, fn -> Menus.get_menu!(menu.id) end
    end

    test "change_menu/1 returns a menu changeset" do
      menu = menu_fixture()
      assert %Ecto.Changeset{} = Menus.change_menu(menu)
    end
  end
end
