defmodule SosWeb.ChatControllerTest do
  use SosWeb.ConnCase

  alias Sos.Chats
  alias Sos.Chats.Chat

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:chat) do
    {:ok, chat} = Chats.create_chat(@create_attrs)
    chat
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all chats", %{conn: conn} do
      conn = get(conn, Routes.chat_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create chat" do
    test "renders chat when data is valid", %{conn: conn} do
      conn = post(conn, Routes.chat_path(conn, :create), chat: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.chat_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.chat_path(conn, :create), chat: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update chat" do
    setup [:create_chat]

    test "renders chat when data is valid", %{conn: conn, chat: %Chat{id: id} = chat} do
      conn = put(conn, Routes.chat_path(conn, :update, chat), chat: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.chat_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, chat: chat} do
      conn = put(conn, Routes.chat_path(conn, :update, chat), chat: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete chat" do
    setup [:create_chat]

    test "deletes chosen chat", %{conn: conn, chat: chat} do
      conn = delete(conn, Routes.chat_path(conn, :delete, chat))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.chat_path(conn, :show, chat))
      end
    end
  end

  defp create_chat(_) do
    chat = fixture(:chat)
    %{chat: chat}
  end
end
