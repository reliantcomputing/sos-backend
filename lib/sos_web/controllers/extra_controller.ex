defmodule SosWeb.ExtraController do
  use SosWeb, :controller

  alias Sos.Extras
  alias Sos.Extras.Extra

  action_fallback SosWeb.FallbackController

  def index(conn, _params) do
    extras = Extras.list_extras()
    render(conn, "index.json", extras: extras)
  end

  def create(conn, %{"extra" => extra_params}) do
    with {:ok, %Extra{} = extra} <- Extras.create_extra(extra_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.extra_path(conn, :show, extra))
      |> render("show.json", extra: extra)
    end
  end

  def show(conn, %{"id" => id}) do
    extra = Extras.get_extra!(id)
    render(conn, "show.json", extra: extra)
  end

  def update(conn, %{"id" => id, "extra" => extra_params}) do
    extra = Extras.get_extra!(id)

    with {:ok, %Extra{} = extra} <- Extras.update_extra(extra, extra_params) do
      render(conn, "show.json", extra: extra)
    end
  end

  def delete(conn, %{"id" => id}) do
    extra = Extras.get_extra!(id)

    with {:ok, %Extra{}} <- Extras.delete_extra(extra) do
      send_resp(conn, :no_content, "")
    end
  end
end
