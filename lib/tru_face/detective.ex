defmodule TruFace.Detective do
  @moduledoc """
  Detective module provides functions for face detection.

  ### Functions
      - enroll/1
      - enroll!/1
      - update/2
      - update!/2
      - create_collection/1
      - create_collection!/1
      - update_collection/2
      - update_collection!/2
      - train/1
      - match?/2
      - identity?/2
  """

  alias TruFace.RequestHelper

  @doc """
  This function receives a list of image binaries
  it returns a tuple like {:ok, "enrollment_id"} if it's
  successful and {:error, %{reason: "reason"}} if it
  fails.

  ### Example
      ```iex> TruFace.Detective.enroll([img1, img2, img3])
         {:ok, "enrollment_id"}```
  """

  @spec enroll(list()) :: {:ok, String.t()} | {:error, map()}
  def enroll([]) do
    {:error, %{reason: "must include the array of images"}}
  end
  def enroll(images) do
    payload =
      images
      |> RequestHelper.build(%{}, 0)
      |> Poison.encode!()
    RequestHelper.path_for("enroll")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  This function receives a list of image binaries
  it returns an "enrollment_id" if it's successful
  and %{reason: "reason"} if it fails.

  ### Example
      ```iex> TruFace.Detective.enroll!([img1, img2, img3])
         "enrollment_id"```
  """

  @spec enroll!(list()) :: String.t() | map()
  def enroll!([]) do
    %{reason: "must include the array of images"}
  end
  def enroll!(images) do
    payload =
      images
      |> RequestHelper.build(%{}, 0)
      |> Poison.encode!()
    {_, response} =
      RequestHelper.path_for("enroll")
      |> HTTPoison.post!(payload, RequestHelper.headers(), [])
      |> RequestHelper.parse_response()
    response
  end

  @doc """
  This function receives a list of image
  binaries and a enrrollment id. Returns
  a tuple like {:ok, "enrollment_id"} if it's
  successful and {:error, %{reason: "reason"}}
  if it fails.

  ### Example
      ```iex> TruFace.Detective.update([img1, img2, img3], enrollment_id)
         {:ok, "enrollment_id"}```
  """

  @spec enroll(list()) :: {:ok, String.t()} | {:error, map()}
  def update([], _) do
    {:error, %{reason: "must include the array of images"}}
  end
  def update(images, enrollment_id) do
    payload =
      images
      |> RequestHelper.build(%{}, 0)
      |> Map.merge(%{"enrollment_id" => enrollment_id})
      |> Poison.encode!()
    RequestHelper.path_for("enroll")
    |> HTTPoison.put!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  This function receives a list of image
  binaries and a enrrollment id. Returns
  an "enrollment_id" if it's successful
  and %{reason: "reason"} if it fails.

  ### Example
      ```iex> TruFace.Detective.update!([img1, img2, img3], enrollment_id)
         "enrollment_id"```
  """

  @spec enroll!(list()) :: String.t() | map()
  def update!([], _) do
    %{reason: "must include the array of images"}
  end
  def update!(images, enrollment_id) do
    payload =
      images
      |> RequestHelper.build(%{}, 0)
      |> Map.merge(%{"enrollment_id" => enrollment_id})
      |> Poison.encode!()
    {_, response} =
      RequestHelper.path_for("enroll")
      |> HTTPoison.put!(payload, RequestHelper.headers(), [])
      |> RequestHelper.parse_response()
    response
  end

  @doc """
  This function receives a String type name and
  returns {:ok, "collection_id"} when successful
  otherwise returns {:error, %{reason: "reason"}}

  ### Example
      ```iex> TruFace.Detective.create_collection("test_collection")
         {:ok, "collection_id"}```
  """

  @spec create_collection(String.t()) :: {:ok, String.t()} | {:error, map()}
  def create_collection("") do
    {:error, %{reason: "must include the name for collection"}}
  end
  def create_collection(name) do
    payload =
      %{name: name}
      |> Poison.encode!()
    RequestHelper.path_for("collection")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  This function receives a String type name and
  returns "collection_id" when successful otherwise
  returns %{reason: "reason"}

  ### Example
      ```iex> TruFace.Detective.create_collection!("test_collection")
         "collection_id"```
  """

  @spec create_collection!(String.t()) :: {:ok, String.t()} | {:error, map()}
  def create_collection!("") do
    %{reason: "must include the name for collection"}
  end
  def create_collection!(name) do
    payload =
      %{name: name}
      |> Poison.encode!()
    {_, response} =
      RequestHelper.path_for("collection")
      |> HTTPoison.post!(payload, RequestHelper.headers(), [])
      |> RequestHelper.parse_response()
    response
  end

  @doc """
  This function receives String type enrollment_id and collection_id.
  Returns {:ok, "collection_id"} when successful otherwise returns
  {:error, %{reason: "reason"}}

  ### Example
      ```iex> TruFace.Detective.update_collection("enrollment_id", "collection_id")
         {:ok, "collection_id"}```
  """

  @spec update_collection(String.t(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def update_collection("", _) do
    {:error, %{reason: "must include enrollment_id"}}
  end
  def update_collection(_, "") do
    {:error, %{reason: "must include collection_id"}}
  end
  def update_collection(enrollment_id, collection_id) do
    payload =
      %{enrollment_id: enrollment_id, collection_id: collection_id}
      |> Poison.encode!()
    RequestHelper.path_for("collection")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  This function receives String type enrollment_id and collection_id.
  Returns "collection_id" when successful otherwise %{reason: "reason"}
  when unsuccessful.

  ### Example
      ```iex> TruFace.Detective.update_collection!("enrollment_id", "collection_id")
         "collection_id"```
  """

  @spec update_collection!(String.t(), String.t()) :: String.t() | map()
  def update_collection!("", _) do
    %{reason: "must include enrollment_id"}
  end
  def update_collection!(_, "") do
    %{reason: "must include collection_id"}
  end
  def update_collection!(enrollment_id, collection_id) do
    payload =
      %{enrollment_id: enrollment_id, collection_id: collection_id}
      |> Poison.encode!()
    {_, response} =
      RequestHelper.path_for("collection")
      |> HTTPoison.post!(payload, RequestHelper.headers(), [])
      |> RequestHelper.parse_response()
    response
  end

  @doc """
  This function receives a String type collection_id
  and returns {:ok, "collection_id"} when successful
  otherwise returns {:error, %{reason: "reason"}}

  ### Example
      ```iex> TruFace.Detective.train("collection_id")
         {:ok, "collection_id"}```
  """

  @spec train(String.t()) :: {:ok, String.t()} | {:error, map()}
  def train("") do
    {:error, %{reason: "must include the collection id"}}
  end
  def train(collection_id) do
    payload =
      %{collection_id: collection_id}
      |> Poison.encode!()
    RequestHelper.path_for("train")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  This function receives an image binary and an
  enrollment_id of String type. Returns {:ok, n}
  where n is the avarage score of the image for
  the given enrollment_id. Otherwise it returns
  {:error, %{reason: "reason"}}

  ### Example
      ```iex> TruFace.Detective.create_collection(image_binary, "enrollment_id")
         {:ok, 0.7}```
  """

  @spec match?(binary(), String.t()) :: {:ok, float()} | {:error, map()}
  def match?(_, "") do
    {:error, %{reason: "must include the enrollment_id"}}
  end
  def match?(raw_image, enrollment_id) do
    image = raw_image
    payload =
      %{img: image, enrollment_id: enrollment_id}
      |> Poison.encode!()
    RequestHelper.path_for("match")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  This function receives an image binary and an
  collection_id of String type. Returns {:ok, id}
  where id is the id of the person identified in
  the given image at a given collection. Otherwise
  it returns {:error, %{reason: "reason"}}

  ### Example
      ```iex> TruFace.Detective.identity?(image_binary, "collection_id")
         {:ok, "person_id"}```
  """

  @spec match?(binary(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def identity?(_, "") do
    {:error, %{reason: "must include the collection_id"}}
  end
  def identity?(raw_image, collection_id) do
    image = raw_image
    payload =
      %{img: image, collection_id: collection_id}
      |> Poison.encode!()
    RequestHelper.path_for("identify")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end
end
