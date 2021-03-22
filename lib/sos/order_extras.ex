defmodule Sos.OrderExtras do
  @moduledoc """
  The OrderExtras context.
  """

  import Ecto.Query, warn: false
  alias Sos.Repo

  alias Sos.OrderExtras.OrderExtra

  @doc """
  Returns the list of order_extras.

  ## Examples

      iex> list_order_extras()
      [%OrderExtra{}, ...]

  """
  def list_order_extras do
    Repo.all(OrderExtra)
  end

  @doc """
  Gets a single order_extra.

  Raises `Ecto.NoResultsError` if the Order extra does not exist.

  ## Examples

      iex> get_order_extra!(123)
      %OrderExtra{}

      iex> get_order_extra!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_extra!(id), do: Repo.get!(OrderExtra, id)

  @doc """
  Creates a order_extra.

  ## Examples

      iex> create_order_extra(%{field: value})
      {:ok, %OrderExtra{}}

      iex> create_order_extra(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_extra(order, extra, attrs \\ %{}) do
    %OrderExtra{}
    |> OrderExtra.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:order, order)
    |> Ecto.Changeset.put_assoc(:extra, extra)
    |> Repo.insert()
  end

  @doc """
  Updates a order_extra.

  ## Examples

      iex> update_order_extra(order_extra, %{field: new_value})
      {:ok, %OrderExtra{}}

      iex> update_order_extra(order_extra, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_extra(%OrderExtra{} = order_extra, attrs) do
    order_extra
    |> OrderExtra.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_extra.

  ## Examples

      iex> delete_order_extra(order_extra)
      {:ok, %OrderExtra{}}

      iex> delete_order_extra(order_extra)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_extra(%OrderExtra{} = order_extra) do
    Repo.delete(order_extra)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_extra changes.

  ## Examples

      iex> change_order_extra(order_extra)
      %Ecto.Changeset{data: %OrderExtra{}}

  """
  def change_order_extra(%OrderExtra{} = order_extra, attrs \\ %{}) do
    OrderExtra.changeset(order_extra, attrs)
  end
end
