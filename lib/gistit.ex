defmodule GistIt do
  @moduledoc """
  The public APIs for calling GitHub Gist API endpoints.
  """

  defdelegate list_user_gists, to: GistIt.Api
  defdelegate list_user_gists(date), to: GistIt.Api
  defdelegate list_user_gists(user, date), to: GistIt.Api
  defdelegate list_all_public_gists, to: GistIt.Api
  defdelegate list_all_public_gists(date), to: GistIt.Api
  defdelegate list_starred_gists, to: GistIt.Api
  defdelegate list_starred_gists(date), to: GistIt.Api
  defdelegate list_gist_forks(gist_id), to: GistIt.Api
  defdelegate list_gist_commits(gist_id), to: GistIt.Api
  defdelegate get_gist(gist_id), to: GistIt.Api
  defdelegate get_gist_revision(gist_id, revision_sha), to: GistIt.Api
  defdelegate star_gist(gist_id), to: GistIt.Api
  defdelegate unstar_gist(gist_id), to: GistIt.Api
  defdelegate check_gist_star(gist_id), to: GistIt.Api
  defdelegate create_gist(body), to: GistIt.Api
  defdelegate edit_gist(gist_id, body), to: GistIt.Api
  defdelegate fork_gist(gist_id), to: GistIt.Api
  defdelegate delete_gist(gist_id), to: GistIt.Api
end
