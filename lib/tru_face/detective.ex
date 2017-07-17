defmodule TruFace.Detective do
  @moduledoc """
  Detective module provides functions for face detection.
  """

  alias TruFace.RequestHelper

  @doc """
  Enrolls a set of images.

  ### Example
      iex> TruFace.Detective.enroll([img1, img2, img3], "en1")
      {:ok, "enrollment_id"}
  """

  @spec enroll(list(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def enroll([], _) do
    {:error, %{reason: "must include the array of images"}}
  end
  def enroll(images, name) do
    payload =
      images
      |> RequestHelper.build(%{name: name}, 0)
      |> Poison.encode!()
    RequestHelper.path_for("enroll")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  Enrolls a set of images.

  ### Example
      iex> TruFace.Detective.enroll!([img1, img2, img3], "en1")
      "enrollment_id"
  """

  @spec enroll!(list(), String.t()) :: String.t() | map()
  def enroll!([], _) do
    %{reason: "must include the array of images"}
  end
  def enroll!(images, name) do
    payload =
      images
      |> RequestHelper.build(%{name: name}, 0)
      |> Poison.encode!()
    {_, response} =
      RequestHelper.path_for("enroll")
      |> HTTPoison.post!(payload, RequestHelper.headers(), [])
      |> RequestHelper.parse_response()
    response
  end

  @doc """
  Updates an enrollment with the given set of images.

  ### Example
      iex> TruFace.Detective.update([img1, img2, img3], enrollment_id)
      {:ok, "enrollment_id"}
  """

  @spec update(list(), String.t()) :: {:ok, String.t()} | {:error, map()}
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
  Updates an enrollment with the given set of images.

  ### Example
      iex> TruFace.Detective.update!([img1, img2, img3], enrollment_id)
      "enrollment_id"
  """

  @spec update!(list(), String.t()) :: String.t() | map()
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
  Creates a named collection to group enrollments.

  ### Example
      iex> TruFace.Detective.create_collection("test_collection")
      {:ok, "collection_id"}
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
  Creates a named collection to group enrollments.

  ### Example
      iex> TruFace.Detective.create_collection!("test_collection")
      "collection_id"
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
  Updates a collection by adding an enrollment.

  ### Example
      iex> TruFace.Detective.update_collection("enrollment_id", "collection_id", "col1")
      {:ok, "collection_id"}
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
    |> HTTPoison.put!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  Updates a collection by adding an enrollment.

  ### Example
      iex> TruFace.Detective.update_collection!("enrollment_id", "collection_id", "col1")
      "collection_id"
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
      |> HTTPoison.put!(payload, RequestHelper.headers(), [])
      |> RequestHelper.parse_response()
    response
  end

  @doc """
  Triggers training for the classifier of a collection.

  ### Example
      iex> TruFace.Detective.train("collection_id")
      {:ok, "collection_id"}
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
  Checks if an image matches an image in an enrollment.

  ### Example
      iex> TruFace.Detective.match?(image_binary, "enrollment_id")
      {:ok, 0.7}
  """

  @spec match?(binary(), String.t()) :: {:ok, float()} | {:error, map()}
  def match?(_, "") do
    {:error, %{reason: "must include the enrollment_id"}}
  end
  def match?(raw_image, enrollment_id) do
    image = raw_image
    payload =
      %{img: image, id: enrollment_id}
      |> Poison.encode!()
    RequestHelper.path_for("match")
    |> HTTPoison.post!(payload, RequestHelper.headers(), [])
    |> RequestHelper.parse_response()
  end

  @doc """
  Checks if an image matches an enrollment in the collection.

  ### Example
      iex> TruFace.Detective.identity?(image_binary, "collection_id")
      {:ok, "person_id"}
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
