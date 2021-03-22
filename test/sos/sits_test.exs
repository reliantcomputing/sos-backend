defmodule Sos.SitsTest do
  use Sos.DataCase

  alias Sos.Sits

  describe "sits" do
    alias Sos.Sits.Sit

    @valid_attrs %{sit_number: "some sit_number"}
    @update_attrs %{sit_number: "some updated sit_number"}
    @invalid_attrs %{sit_number: nil}

    def sit_fixture(attrs \\ %{}) do
      {:ok, sit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sits.create_sit()

      sit
    end

    test "list_sits/0 returns all sits" do
      sit = sit_fixture()
      assert Sits.list_sits() == [sit]
    end

    test "get_sit!/1 returns the sit with given id" do
      sit = sit_fixture()
      assert Sits.get_sit!(sit.id) == sit
    end

    test "create_sit/1 with valid data creates a sit" do
      assert {:ok, %Sit{} = sit} = Sits.create_sit(@valid_attrs)
      assert sit.sit_number == "some sit_number"
    end

    test "create_sit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sits.create_sit(@invalid_attrs)
    end

    test "update_sit/2 with valid data updates the sit" do
      sit = sit_fixture()
      assert {:ok, %Sit{} = sit} = Sits.update_sit(sit, @update_attrs)
      assert sit.sit_number == "some updated sit_number"
    end

    test "update_sit/2 with invalid data returns error changeset" do
      sit = sit_fixture()
      assert {:error, %Ecto.Changeset{}} = Sits.update_sit(sit, @invalid_attrs)
      assert sit == Sits.get_sit!(sit.id)
    end

    test "delete_sit/1 deletes the sit" do
      sit = sit_fixture()
      assert {:ok, %Sit{}} = Sits.delete_sit(sit)
      assert_raise Ecto.NoResultsError, fn -> Sits.get_sit!(sit.id) end
    end

    test "change_sit/1 returns a sit changeset" do
      sit = sit_fixture()
      assert %Ecto.Changeset{} = Sits.change_sit(sit)
    end
  end
end
