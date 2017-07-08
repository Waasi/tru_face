ExUnit.start()

defmodule TestHelper do
  def test_images() do
    ["fhjgvfhjgvfkhsgvdv", "djfhbasjfhbasjdfhb"]
  end

  def test_image() do
    "elfknalfknwlfknwqlfknwqlkf"
  end

  def expected_headers do
    api_key = Application.get_env(:tru_face, :api_key)
    [{"Content-Type", "application/json"}, {"x-api-key", api_key}]
  end

  def expected_path_for(resource) do
    "https://api.chui.ai/v1/#{resource}"
  end

  def mocked_enroll do
    %HTTPoison.Response{
      status_code: 200,
      body: Poison.encode!(%{data: %{enrollment_id: "eid"}})
    }
  end

  def mocked_update_enroll do
    %HTTPoison.Response{
      status_code: 200,
      body: Poison.encode!(%{data: %{enrollment_id: "eid"}})
    }
  end

  def mocked_create_collection do
    %HTTPoison.Response{
      status_code: 200,
      body: Poison.encode!(%{data: %{collection_id: "cid"}})
    }
  end

  def mocked_update_collection do
    %HTTPoison.Response{
      status_code: 200,
      body: Poison.encode!(%{data: %{collection_id: "cid"}})
    }
  end

  def mocked_face_match do
    %HTTPoison.Response{
      status_code: 200,
      body: Poison.encode!(%{data: %{emb0_score: 0.9, emb0_match: true, emb1_score: 0.9, emb1_match: true}})
    }
  end

  def mocked_face_identity do
    %HTTPoison.Response{
      status_code: 200,
      body: Poison.encode!(%{data: %{name: "Juan Del Pueblo", key: "person_id"}})
    }
  end
end
