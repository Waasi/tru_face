defmodule TruFace.Detective do
  @moduledoc """
  Detective module provides functions for face detection.

  ### Functions
      - enroll/1
      - enroll!/1
      - update/2
      - create_collection/1
      - update_collection/2
      - match?/2
      - idetity?/2
  """

  alias TruFace.RequestHelper

  @doc """
  This function receives a list of image binaries
  it returns a tuple like {:ok, "enroll_id"} if it's
  successful and {:error, %{reason: reason}} if it
  fails.

  ### Example
      ```iex> TruFace.Detective.enroll([img1, img2, img3])
         {:ok, "enroll_id"}```
  """

  @spec enroll(list()) :: {:ok, String.t()} | {:error, map()}
  def enroll([]) do
    {:error, %{reason: "must include the array of images"}}
  end
  def enroll(images) do
    payload =
      images
      |> Enum.map(&Base.encode64/1)
      |> Poison.encode!()
    RequestHelper.path_for("enroll")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  This function receives a list of image binaries
  it returns an enroll_id if it's successful and
  %{reason: reason} if it fails.

  ### Example
      ```iex> TruFace.Detective.enroll!([img1, img2, img3])
         "enroll_id"```
  """

  @spec enroll!(list()) :: String.t() | map()
  def enroll!([]) do
    %{reason: "must include the array of images"}
  end
  def enroll!(images) do
    payload =
      images
      |> Enum.map(&Base.encode64/1)
      |> Poison.encode!()
    {_, response} =
      RequestHelper.path_for("enroll")
      |> HTTPoison.post!(payload, RequestHelper.headers(), [])
      |> RequestHelper.parse_response()
    response
  end
end
