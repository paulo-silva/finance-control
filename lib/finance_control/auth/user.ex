defmodule FinanceControl.Auth.User do
  @moduledoc false

  use FinanceControl.Schema

  alias FinanceControl.Auth.User

  schema "users" do
    field :email, :string
  end

  defdelegate update_changeset(attrs), to: User, as: :create_changeset

  @spec create_changeset(map()) :: Ecto.Changeset.t()
  def create_changeset(attrs) do
    %User{}
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
