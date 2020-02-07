defmodule Discuss.Topic do
    use Discuss.Web, :model

    schema "topics" do
       field :title, :string 
       field :user_id, :integer

       belongs_to :user, Discuss.User
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title])
        |> validate_required([:title])
    end
end