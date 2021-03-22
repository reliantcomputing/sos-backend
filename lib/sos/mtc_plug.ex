defmodule Sos.MTCPlug do
  import Plug.Conn

  def init(default), do: default
  def call(conn, _default) do
    case Sos.MTCAuth.get_auth_token(conn) do
      {:ok, _token} ->
        conn
        |> authorized()
      _ -> conn |> unauthorized()
    end
  end
  defp authorized(conn) do
    # If you want, add new values to `conn`
    conn
  end
  defp unauthorized(conn) do
    conn |> send_resp(:unauthorized, "Unauthorized") |> halt()
  end
end
