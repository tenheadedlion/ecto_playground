defmodule EctoPlayground.Repo.Migrations.M2M do
  use Ecto.Migration

  def change do
    create table(:xs) do
      add(:name, :string)
    end

    create(unique_index(:xs, [:name]))

    create table(:ys) do
      add(:name, :string)
    end

    create(unique_index(:ys, [:name]))

    create table(:xs_ys, primary_key: false) do
      add(:x_id, references(:xs))
      add(:y_id, references(:ys))
    end
  end
end
