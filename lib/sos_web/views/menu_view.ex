defmodule SosWeb.MenuView do
  use SosWeb, :view
  alias SosWeb.MenuView

  def render("index.json", %{menus: menus}) do
    %{data: render_many(menus, MenuView, "menu.json")}
  end

  def render("show.json", %{menu: menu}) do
    %{data: render_one(menu, MenuView, "menu.json")}
  end

  def render("menu.json", %{menu: menu}) do
    %{id: menu.id,
      title: menu.title,
      description: menu.description,
      image: menu.image,
      price: menu.price}
  end
end
