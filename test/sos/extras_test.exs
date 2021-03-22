defmodule Sos.ExtrasTest do
  use Sos.DataCase

  alias Sos.Extras

  describe "extras" do
    alias Sos.Extras.Extra

    @valid_attrs %{description: "some description", image: "some image", price: "120.5", title: "some title"}
    @update_attrs %{description: "some updated description", image: "some updated image", price: "456.7", title: "some updated title"}
    @invalid_attrs %{description: nil, image: nil, price: nil, title: nil}

    def extra_fixture(attrs \\ %{}) do
      {:ok, extra} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Extras.create_extra()

      extra
    end

    test "list_extras/0 returns all extras" do
      extra = extra_fixture()
      assert Extras.list_extras() == [extra]
    end

    test "get_extra!/1 returns the extra with given id" do
      extra = extra_fixture()
      assert Extras.get_extra!(extra.id) == extra
    end

    test "create_extra/1 with valid data creates a extra" do
      assert {:ok, %Extra{} = extra} = Extras.create_extra(@valid_attrs)
      assert extra.description == "some description"
      assert extra.image == "some image"
      assert extra.price == Decimal.new("120.5")
      assert extra.title == "some title"
    end

    test "create_extra/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Extras.create_extra(@invalid_attrs)
    end

    test "update_extra/2 with valid data updates the extra" do
      extra = extra_fixture()
      assert {:ok, %Extra{} = extra} = Extras.update_extra(extra, @update_attrs)
      assert extra.description == "some updated description"
      assert extra.image == "some updated image"
      assert extra.price == Decimal.new("456.7")
      assert extra.title == "some updated title"
    end

    test "update_extra/2 with invalid data returns error changeset" do
      extra = extra_fixture()
      assert {:error, %Ecto.Changeset{}} = Extras.update_extra(extra, @invalid_attrs)
      assert extra == Extras.get_extra!(extra.id)
    end

    test "delete_extra/1 deletes the extra" do
      extra = extra_fixture()
      assert {:ok, %Extra{}} = Extras.delete_extra(extra)
      assert_raise Ecto.NoResultsError, fn -> Extras.get_extra!(extra.id) end
    end

    test "change_extra/1 returns a extra changeset" do
      extra = extra_fixture()
      assert %Ecto.Changeset{} = Extras.change_extra(extra)
    end
  end
end
