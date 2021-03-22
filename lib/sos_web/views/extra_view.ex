defmodule SosWeb.ExtraView do
  use SosWeb, :view
  alias SosWeb.ExtraView

  def render("index.json", %{extras: extras}) do
    %{data: render_many(extras, ExtraView, "extra.json")}
  end

  def render("show.json", %{extra: extra}) do
    %{data: render_one(extra, ExtraView, "extra.json")}
  end

  def render("extra.json", %{extra: extra}) do
    %{id: extra.id,
      title: extra.title,
      description: extra.description,
      image: extra.image,
      price: extra.price}
  end
end
