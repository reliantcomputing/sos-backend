defmodule Sos.OrderMenus do
  @moduledoc """
  The OrderMenus context.
  """

  import Ecto.Query, warn: false
  alias Sos.Repo

  alias Sos.OrderMenus.OrderMenu

  @doc """
  Returns the list of order_menus.

  ## Examples

      iex> list_order_menus()
      [%OrderMenu{}, ...]

  """
  def list_order_menus do
    Repo.all(OrderMenu)
  end

  @doc """
  Gets a single order_menu.

  Raises `Ecto.NoResultsError` if the Order menu does not exist.

  ## Examples

      iex> get_order_menu!(123)
      %OrderMenu{}

      iex> get_order_menu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_menu!(id), do: Repo.get!(OrderMenu, id)

  @doc """
  Creates a order_menu.

  ## Examples

      iex> create_order_menu(%{field: value})
      {:ok, %OrderMenu{}}

      iex> create_order_menu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_menu(order, menu, attrs \\ %{}) do
    %OrderMenu{}
    |> OrderMenu.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:order, order)
    |> Ecto.Changeset.put_assoc(:menu, menu)
    |> Repo.insert()
  end

  @doc """
  Updates a order_menu.

  ## Examples

      iex> update_order_menu(order_menu, %{field: new_value})
      {:ok, %OrderMenu{}}

      iex> update_order_menu(order_menu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_menu(%OrderMenu{} = order_menu, attrs) do
    order_menu
    |> OrderMenu.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_menu.

  ## Examples

      iex> delete_order_menu(order_menu)
      {:ok, %OrderMenu{}}

      iex> delete_order_menu(order_menu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_menu(%OrderMenu{} = order_menu) do
    Repo.delete(order_menu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_menu changes.

  ## Examples

      iex> change_order_menu(order_menu)
      %Ecto.Changeset{data: %OrderMenu{}}

  """
  def change_order_menu(%OrderMenu{} = order_menu, attrs \\ %{}) do
    OrderMenu.changeset(order_menu, attrs)
  end
end
