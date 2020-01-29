defmodule Discuss.TopicController do
    use Discuss.Web, :controller
    
    alias Discuss.Topic

    def index(conn, _params) do
        topics = Repo.all(Topic)

        render conn, "index.html", topics: topics
    end

    def new(conn, _params) do
        changeset =  Topic.changeset(%Topic{}, %{})
        render conn, "new.html", changeset: changeset
    end

    # def create2(conn, %{"topic" => topic}) do
    #     IO.inspect topic
    # end

    def create(conn, %{"topic" => topic}) do
        changeset = Topic.changeset(%Topic{}, topic)
        IO.inspect changeset
        case Repo.insert(changeset) do
            {:ok, _topic} -> 
                conn
                |> put_flash(:info, "Topic created")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => topic_id}) do
        topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(topic)
        render conn, "edit.html", changeset: changeset, topic_id: topic_id
    end

    def update(conn, %{ "id" => topic_id, "topic" => topic}) do
        changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)

        case Repo.update(changeset) do
            {:ok, _topic } ->
                conn
                |> put_flash(:info, "Topic updated")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> 
                render(conn, "edit.html", changeset: changeset, topic_id: topic_id)
        end
    end


    def delete(conn, %{"id" => topic_id}) do
        IO.inspect Repo.get(Topic, topic_id)
        Repo.get!(Topic, topic_id) |> Repo.delete!

        conn
        |> put_flash(:info, "Topic Deleted")
        |> redirect to: topic_path(conn, :index)
    end
  end
  