defmodule Sos.MTCAuth do

  @secret "lDCETPTKjyAbJLQjYKbZBU5KKPD9OjmLxBFPFmoBXak2In6bzAiUTXZUe1A4TvQi"
  @seeds "user token"


  def authenticate(email, password) do
    user = Sos.Accounts.get_user_by_email_and_password(email, password)
    if user do
      create_token(user)
    else
      {:error, "Invalid username or password"}
    end
  end

  def validate(token, _uuid) do

    {:ok, id} = verify_token(token)
    user = Sos.Accounts.get_user!(id)

    if user do
      create_token(user)
    else
      {:error, "Invalid username or password"}
    end
  end

  def get_auth_token(conn) do
    case extract_token(conn) do
      {:ok, token} -> verify_token(token)
      error -> error
    end
  end

  def verify_token(token) do
    Phoenix.Token.verify(@secret, @seeds, token, max_age: 86400)
  end

  defp extract_token(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [auth_header] -> get_token_from_header(auth_header)
      _ -> {:error, :missing_auth_header}
    end
  end

  defp get_token_from_header(auth_header) do
    case String.split(auth_header, " ") do
      [_, token] -> {:ok, String.trim(token)}
      _ -> {:error, "token not found"}
    end
  end

  defp create_token(user) do
    token = Phoenix.Token.sign(@secret, @seeds, user.id, max_age: 86400)
    {:ok, user, token}
  end
end
