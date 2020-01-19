defmodule GistIt.Api do
  @moduledoc """
  Implementations of GitHub Gist API endpoints calls.
  For a list of endpoints, visit https://developer.github.com/v3/gists/
  """

  import GistIt.Request

  def list_user_gists, do: get("/gists")
  def list_user_gists(user), do: get("/users/#{URI.encode(user)}/gists")
  def list_user_gists(nil, date), do: get("/gists?since=#{URI.encode(date)}")

  def list_user_gists(user, date),
    do: get("users/#{URI.encode(user)}/gists?since=#{URI.encode(date)}")

  def list_all_public_gists, do: get("/gists/public")
  def list_all_public_gists(date), do: get("/gists/public?since=#{URI.encode(date)}")
  def get_gist(gist_id), do: get("/gists/#{URI.encode(gist_id)}")

  def get_gist_revision(gist_id, gist_sha),
    do: get("/gists/#{URI.encode(gist_id)}/#{URI.encode(gist_sha)}")

  def list_starred_gists, do: get("/gists/starred")
  def list_starred_gists(date), do: get("/gists/starred?since=#{URI.encode(date)}")
  def create_gist(body), do: post("/gists", body)
  def edit_gist(gist_id, body), do: patch("/gists/#{URI.encode(gist_id)}", body)
  def list_gist_commits(gist_id), do: get("/gists/#{URI.encode(gist_id)}/commits")

  def star_gist(gist_id),
    do: put("/gists/#{URI.encode(gist_id)}/star", "", [{"Content-Length", 0}])

  def unstar_gist(gist_id), do: delete("/gists/#{URI.encode(gist_id)}/star")
  def check_gist_star(gist_id), do: get("/gists/#{URI.encode(gist_id)}/star")
  def fork_gist(gist_id), do: post("/gists/#{URI.encode(gist_id)}/forks", "")
  def list_gist_forks(gist_id), do: get("/gists/#{URI.encode(gist_id)}/forks")
  def delete_gist(gist_id), do: delete("/gists/#{URI.encode(gist_id)}")
end
