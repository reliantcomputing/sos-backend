defmodule SosWeb.SitControllerTest do
  use SosWeb.ConnCase

  alias Sos.Sits
  alias Sos.Sits.Sit

  @create_attrs %{
    sit_number: "some sit_number"
  }
  @update_attrs %{
    sit_number: "some updated sit_number"
  }
  @invalid_attrs %{sit_number: nil}

  def fixture(:sit) do
    {:ok, sit} = Sits.create_sit(@create_attrs)
    sit
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sits", %{conn: conn} do
      conn = get(conn, Routes.sit_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sit" do
    test "renders sit when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sit_path(conn, :create), sit: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.sit_path(conn, :show, id))

      assert %{
               "id" => id,
               "sit_number" => "some sit_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sit_path(conn, :create), sit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sit" do
    setup [:create_sit]

    test "renders sit when data is valid", %{conn: conn, sit: %Sit{id: id} = sit} do
      conn = put(conn, Routes.sit_path(conn, :update, sit), sit: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.sit_path(conn, :show, id))

      assert %{
               "id" => id,
               "sit_number" => "some updated sit_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, sit: sit} do
      conn = put(conn, Routes.sit_path(conn, :update, sit), sit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sit" do
    setup [:create_sit]

    test "deletes chosen sit", %{conn: conn, sit: sit} do
      conn = delete(conn, Routes.sit_path(conn, :delete, sit))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.sit_path(conn, :show, sit))
      end
    end
  end

  defp create_sit(_) do
    sit = fixture(:sit)
    %{sit: sit}
  end
end
