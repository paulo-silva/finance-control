defmodule FinanceControl.Auth do
  @moduledoc "Auth context"

  alias FinanceControl.Auth.User
  alias FinanceControl.Repo

  @spec find_user_by_email(String.t()) :: {:ok, User.t()} | {:error, :not_found}
  def find_user_by_email(email), do: Repo.find_by(User, email: email)

  @spec create_user(String.t()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(email), do: %{email: email} |> User.create_changeset() |> Repo.insert()
end
