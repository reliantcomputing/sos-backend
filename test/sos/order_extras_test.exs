defmodule Sos.OrderExtrasTest do
  use Sos.DataCase

  alias Sos.OrderExtras

  describe "order_extras" do
    alias Sos.OrderExtras.OrderExtra

    @valid_attrs %{qty: 42}
    @update_attrs %{qty: 43}
    @invalid_attrs %{qty: nil}

    def order_extra_fixture(attrs \\ %{}) do
      {:ok, order_extra} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OrderExtras.create_order_extra()

      order_extra
    end

    test "list_order_extras/0 returns all order_extras" do
      order_extra = order_extra_fixture()
      assert OrderExtras.list_order_extras() == [order_extra]
    end

    test "get_order_extra!/1 returns the order_extra with given id" do
      order_extra = order_extra_fixture()
      assert OrderExtras.get_order_extra!(order_extra.id) == order_extra
    end

    test "create_order_extra/1 with valid data creates a order_extra" do
      assert {:ok, %OrderExtra{} = order_extra} = OrderExtras.create_order_extra(@valid_attrs)
      assert order_extra.qty == 42
    end

    test "create_order_extra/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderExtras.create_order_extra(@invalid_attrs)
    end

    test "update_order_extra/2 with valid data updates the order_extra" do
      order_extra = order_extra_fixture()
      assert {:ok, %OrderExtra{} = order_extra} = OrderExtras.update_order_extra(order_extra, @update_attrs)
      assert order_extra.qty == 43
    end

    test "update_order_extra/2 with invalid data returns error changeset" do
      order_extra = order_extra_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderExtras.update_order_extra(order_extra, @invalid_attrs)
      assert order_extra == OrderExtras.get_order_extra!(order_extra.id)
    end

    test "delete_order_extra/1 deletes the order_extra" do
      order_extra = order_extra_fixture()
      assert {:ok, %OrderExtra{}} = OrderExtras.delete_order_extra(order_extra)
      assert_raise Ecto.NoResultsError, fn -> OrderExtras.get_order_extra!(order_extra.id) end
    end

    test "change_order_extra/1 returns a order_extra changeset" do
      order_extra = order_extra_fixture()
      assert %Ecto.Changeset{} = OrderExtras.change_order_extra(order_extra)
    end
  end
end
