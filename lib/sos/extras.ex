defmodule Sos.Extras do
  @moduledoc """
  The Extras context.
  """

  import Ecto.Query, warn: false
  alias Sos.Repo

  alias Sos.Extras.Extra

  @doc """
  Returns the list of extras.

  ## Examples

      iex> list_extras()
      [%Extra{}, ...]

  """
  def list_extras do
    Repo.all(Extra)
  end

  @doc """
  Gets a single extra.

  Raises `Ecto.NoResultsError` if the Extra does not exist.

  ## Examples

      iex> get_extra!(123)
      %Extra{}

      iex> get_extra!(456)
      ** (Ecto.NoResultsError)

  """
  def get_extra!(id), do: Repo.get!(Extra, id)

  @doc """
  Creates a extra.

  ## Examples

      iex> create_extra(%{field: value})
      {:ok, %Extra{}}

      iex> create_extra(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_extra(attrs \\ %{}) do
    %Extra{}
    |> Extra.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a extra.

  ## Examples

      iex> update_extra(extra, %{field: new_value})
      {:ok, %Extra{}}

      iex> update_extra(extra, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_extra(%Extra{} = extra, attrs) do
    extra
    |> Extra.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a extra.

  ## Examples

      iex> delete_extra(extra)
      {:ok, %Extra{}}

      iex> delete_extra(extra)
      {:error, %Ecto.Changeset{}}

  """
  def delete_extra(%Extra{} = extra) do
    Repo.delete(extra)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking extra changes.

  ## Examples

      iex> change_extra(extra)
      %Ecto.Changeset{data: %Extra{}}

  """
  def change_extra(%Extra{} = extra, attrs \\ %{}) do
    Extra.changeset(extra, attrs)
  end
end
