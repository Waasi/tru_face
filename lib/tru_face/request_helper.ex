defmodule TruFace.RequestHelper do
  @base_url "https://api.chui.ai/v1"

  def path_for(resource) do
    "#{@base_url}/#{resource}"
  end

  def headers do
    [{"Content-Type", "application/json"}, {"x-api-key", api_key()}]
  end

  def parse_response(%HTTPoison.Response{status_code: 201, body: body}) do
    case Poison.decode(body) do
      {:ok, json} -> {:ok, json}
      _error -> {:error, %{reason: "Unable to Parse Response"}}
    end
  end
  def parse_response(%HTTPoison.Response{status_code: code}), do: {:error, error_for(code)}

  #####
  # Private API
  #####

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
