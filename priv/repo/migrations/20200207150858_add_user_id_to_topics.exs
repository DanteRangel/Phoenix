defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table("topics") do
      add :user_ud, references(:users)
    end
  end
end
