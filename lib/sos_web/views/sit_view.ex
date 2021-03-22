defmodule SosWeb.SitView do
  use SosWeb, :view
  alias SosWeb.SitView

  def render("index.json", %{sits: sits}) do
    %{data: render_many(sits, SitView, "sit.json")}
  end

  def render("show.json", %{sit: sit}) do
    %{data: render_one(sit, SitView, "sit.json")}
  end

  def render("sit.json", %{sit: sit}) do
    %{id: sit.id,
      sit_number: sit.sit_number}
  end
end
