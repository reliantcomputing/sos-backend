defmodule Sos.Sits do
  @moduledoc """
  The Sits context.
  """

  import Ecto.Query, warn: false
  alias Sos.Repo

  alias Sos.Sits.Sit

  @doc """
  Returns the list of sits.

  ## Examples

      iex> list_sits()
      [%Sit{}, ...]

  """
  def list_sits do
    Repo.all(Sit)
  end

  @doc """
  Gets a single sit.

  Raises `Ecto.NoResultsError` if the Sit does not exist.

  ## Examples

      iex> get_sit!(123)
      %Sit{}

      iex> get_sit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sit!(id), do: Repo.get!(Sit, id)

  def get_by_sit_number(sit_number) do
    Repo.get_by(Sit, sit_number: sit_number)
  end

  @doc """
  Creates a sit.

  ## Examples

      iex> create_sit(%{field: value})
      {:ok, %Sit{}}

      iex> create_sit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sit(attrs \\ %{}) do
    %Sit{}
    |> Sit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sit.

  ## Examples

      iex> update_sit(sit, %{field: new_value})
      {:ok, %Sit{}}

      iex> update_sit(sit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sit(%Sit{} = sit, attrs) do
    sit
    |> Sit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sit.

  ## Examples

      iex> delete_sit(sit)
      {:ok, %Sit{}}

      iex> delete_sit(sit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sit(%Sit{} = sit) do
    Repo.delete(sit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sit changes.

  ## Examples

      iex> change_sit(sit)
      %Ecto.Changeset{data: %Sit{}}

  """
  def change_sit(%Sit{} = sit, attrs \\ %{}) do
    Sit.changeset(sit, attrs)
  end
end
