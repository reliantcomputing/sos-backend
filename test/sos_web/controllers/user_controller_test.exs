defmodule SosWeb.UserControllerTest do
  use SosWeb.ConnCase

  alias Sos.Users
  alias Sos.Users.User

  @create_attrs %{
    email: "some email",
    emp_id: "some emp_id",
    first_name: "some first_name",
    house: "some house",
    id_number: "some id_number",
    last_name: "some last_name",
    phone_number: "some phone_number",
    street_name: "some street_name"
  }
  @update_attrs %{
    email: "some updated email",
    emp_id: "some updated emp_id",
    first_name: "some updated first_name",
    house: "some updated house",
    id_number: "some updated id_number",
    last_name: "some updated last_name",
    phone_number: "some updated phone_number",
    street_name: "some updated street_name"
  }
  @invalid_attrs %{email: nil, emp_id: nil, first_name: nil, house: nil, id_number: nil, last_name: nil, phone_number: nil, street_name: nil}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "emp_id" => "some emp_id",
               "first_name" => "some first_name",
               "house" => "some house",
               "id_number" => "some id_number",
               "last_name" => "some last_name",
               "phone_number" => "some phone_number",
               "street_name" => "some street_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "emp_id" => "some updated emp_id",
               "first_name" => "some updated first_name",
               "house" => "some updated house",
               "id_number" => "some updated id_number",
               "last_name" => "some updated last_name",
               "phone_number" => "some updated phone_number",
               "street_name" => "some updated street_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
