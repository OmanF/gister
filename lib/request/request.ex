defmodule GistIt.Request do
  @moduledoc """
  Create a well formatted API request and, optionally, pretty-print the response.
  """

  require Logger

  @default_headers Application.get_env(:gistit, :default_headers)
  @default_options Application.get_env(:gistit, :default_options)
  @base_url Application.get_env(:gistit, :base_url)
  @user_agent Application.get_env(:gistit, :user_agent)

  @user_name Application.get_env(:gistit, :user_name)
  @password Application.get_env(:gistit, :password)
  @userpass :base64.encode("#{@user_name}:#{@password}")
  @token Application.get_env(:gistit, :token)
  @auth_method Application.get_env(:gistit, :auth_method)

  defp authorization_headers(prev_headers, auth_method) do
    case auth_method do
      :basic ->
        prev_headers ++ [{"Authorization", "Basic #{@userpass}"}]

      :token ->
        prev_headers ++ [{"Authorization", "token #{@token}"}]

      _ ->
        prev_headers
    end
  end

  defp user_agentize(prev_headers) do
    prev_headers ++ @user_agent
  end

  # Parses and pretty-prints the response.
  # Raw responses are saved to the log file.
  defp parse_response(res = %HTTPoison.Response{}) do
    log_response = fn ->
      Logger.debug(
        "Start parsing the response:\nURL: #{res.request_url}\nStatus Code: #{res.status_code}\nHeaders: #{
          inspect(res.headers)
        }\n\nBody: #{inspect(res.body)}\n"
      )
    end

    log_error = fn ->
      Logger.error(
        "Request on #{res.request_url} returned with non-2XX response: #{res.status_code}!\nHeaders: #{
          inspect(res.headers)
        }\nBody: #{inspect(res.body)}"
      )

      raise("Request on #{res.request_url} returned with non-2XX response: #{res.status_code}!")
    end

    case @default_options[:parse_response] do
      true ->
        case res.status_code |> Integer.to_string() =~ ~r/20[0124]/ do
          true ->
            log_response.()

            IO.puts("Request URL: #{res.request_url}")
            IO.puts("Status: #{res.status_code}")
            IO.write("Headers: ")
            Enum.map(res.headers, fn {k, v} -> IO.write("#{k}: #{v}\n") end)

            IO.puts(
              "Body: #{Poison.Parser.parse!(res.body, %{}) |> Poison.encode!(pretty: true)}"
            )

          false ->
            log_error.()
        end

      false ->
        case res.status_code |> Integer.to_string() =~ ~r/20[0124]/ do
          true ->
            log_response.()

          false ->
            log_error.()
        end

        res
    end
  end

  # The actual HTTP request!
  defp do_request(method, endpoint, body, headers, options, auth_method \\ @auth_method) do
    Logger.debug(
      "Contacting: #{URI.merge(URI.parse(@base_url), endpoint)}\nMethod: #{String.upcase(method)}\nHeaders: #{
        inspect(
          (@default_headers ++ headers)
          |> authorization_headers(auth_method)
          |> user_agentize()
        )
      }\nBody:\n#{body}\n"
    )

    HTTPoison.request!(
      method,
      URI.merge(URI.parse(@base_url), endpoint),
      body,
      (@default_headers ++ headers)
      |> authorization_headers(auth_method)
      |> user_agentize(),
      @default_options ++ options
    )
    |> parse_response()
  end

  # HTTP calls implementation.
  def get(
        endpoint,
        headers \\ [],
        options \\ []
      ) do
    do_request("get", endpoint, "", headers, options)
  end

  def delete(
        endpoint,
        headers \\ [],
        options \\ []
      ) do
    do_request("delete", endpoint, "", headers, options)
  end

  def post(
        endpoint,
        body,
        headers \\ [],
        options \\ []
      ) do
    do_request("post", endpoint, body, headers, options)
  end

  def put(
        endpoint,
        body,
        headers \\ [],
        options \\ []
      ) do
    do_request("put", endpoint, body, headers, options)
  end

  def patch(
        endpoint,
        body,
        headers \\ [],
        options \\ []
      ) do
    do_request("patch", endpoint, body, headers, options)
  end
end
