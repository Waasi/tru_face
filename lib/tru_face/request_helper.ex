defmodule TruFace.RequestHelper do
  @base_url "https://api.chui.ai/v1"

  def path_for(resource) do
    "#{@base_url}/#{resource}"
  end

  def headers do
    [{"Content-Type", "application/json"}, {"x-api-key", api_key()}]
  end

  def parse_response(%HTTPoison.Response{status_code: 200, body: body}) do
    case Poison.decode(body, keys: :atoms) do
      {:ok, %{success: false, message: error}} ->
        {:error, %{reason: error}}
      {:ok, %{data: "no face detected" = error}} ->
        {:error, %{reason: error}}
      {:ok, %{data: %{enrollment_id: id}}} ->
        {:ok, id}
      {:ok, %{data: %{collection_id: id}}} ->
        {:ok, id}
      {:ok, %{data: %{key: id}}} ->
        {:ok, id}
      {:ok, %{data: scores_and_matches}} ->
        {:ok, avg_score(scores_and_matches)}
      _error -> {:error, %{reason: "Unable to Parse Response"}}
    end
  end
  def parse_response(%HTTPoison.Response{status_code: code}) do
    {:error, error_for(code)}
  end

  def build([], payload, _), do: payload
  def build([head|tail], body, 0) do
    payload =
      body
      |> Map.merge(%{"img0" => head})
    build(tail, payload, 1)
  end
  def build([head|tail], payload, index) do
    new_payload =
      payload
      |> Map.merge(%{"img#{index}" => head})
    build(tail, new_payload, index + 1)
  end

  #####
  # Private API
  #####

  defp avg_score(scores_and_matches) do
    scores =
      scores_and_matches
      |> Enum.filter(&score?/1)
    scores_sum =
      scores
      |> Enum.reduce(0, &accumulate/2)
    scores_sum / Enum.count(scores)
  end

  defp accumulate({_, value}, accumulator) do
    accumulator + value;
  end

  defp score?({key, _}) do
    key
    |> Atom.to_string()
    |> String.contains?("score")
  end

  defp api_key do
    Application.get_env(:tru_face, :api_key)
  end

  defp error_for(400), do: %{reason: "Bad Request"}
  defp error_for(401), do: %{reason: "Unauthorized"}
  defp error_for(403), do: %{reason: "Forbidden"}
  defp error_for(404), do: %{reason: "Not Found"}
  defp error_for(405), do: %{reason: "Method Not Allowed"}
  defp error_for(406), do: %{reason: "Not Acceptable"}
  defp error_for(410), do: %{reason: "Gone"}
  defp error_for(418), do: %{reason: "I'm a Tea Pot"}
  defp error_for(429), do: %{reason: "Too many requests"}
  defp error_for(503), do: %{reason: "Service Unavailable"}
  defp error_for(_), do: %{reason: "Internal Server Error"}
end
