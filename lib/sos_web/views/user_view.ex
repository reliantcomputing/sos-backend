defmodule SosWeb.UserView do
  use SosWeb, :view
  alias SosWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        emp_id: user.emp_id,
        phone_number: user.phone_number,
        role: user.role.name,
        street_name: user.street_name,
        house: user.house,
    }
  end

  def render("login.json", %{user: user, token: token}) do
    orders = Sos.Orders.list_orders()
    chats = user.chats
    %{
      user: %{
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        emp_id: user.emp_id,
        phone_number: user.phone_number,
        role: %{
          name: user.role.name,
          description: user.role.description
        },
        street_name: user.street_name,
        house: user.house,
        token: token
      },
      chats: render_many(chats, SosWeb.ChatView , "chat.json"),
      orders: render_many(orders, SosWeb.OrderView , "order.json"),
    }
  end

  def render("error.json", %{error: error}) do
    %{
      error: error
    }
  end
end
