defmodule SosWeb.SitController do
  use SosWeb, :controller

  alias Sos.Sits
  alias Sos.Sits.Sit

  action_fallback SosWeb.FallbackController

  def index(conn, _params) do
    sits = Sits.list_sits()
    render(conn, "index.json", sits: sits)
  end

  def create(conn, %{"sit" => sit_params}) do
    with {:ok, %Sit{} = sit} <- Sits.create_sit(sit_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.sit_path(conn, :show, sit))
      |> render("show.json", sit: sit)
    end
  end

  def show(conn, %{"id" => id}) do
    sit = Sits.get_sit!(id)
    render(conn, "show.json", sit: sit)
  end

  def update(conn, %{"id" => id, "sit" => sit_params}) do
    sit = Sits.get_sit!(id)

    with {:ok, %Sit{} = sit} <- Sits.update_sit(sit, sit_params) do
      render(conn, "show.json", sit: sit)
    end
  end

  def delete(conn, %{"id" => id}) do
    sit = Sits.get_sit!(id)

    with {:ok, %Sit{}} <- Sits.delete_sit(sit) do
      send_resp(conn, :no_content, "")
    end
  end
end
