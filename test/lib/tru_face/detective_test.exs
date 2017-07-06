defmodule TruFace.DetectiveTest do
  use ExUnit.Case

  alias TruFace.Detective
  import TestHelper

  test "enrolls 3 images" do
    assert {:ok, _} = Detective.enroll(test_images())
  end

  test "updates a profile" do
    {:ok, enroll_id} = Detective.enroll(test_images())
    assert {:ok, ^enroll_id} = Detective.update(test_image(), enroll_id)
  end

  test "creates a collection" do
    assert {:ok, _} = Detective.create_collection("test")
  end

  test "updates a collection" do
    {:ok, enroll_id} = Detective.enroll(test_images())
    {:ok, collection_id} = Detective.create_collection("test")
    assert {:ok, ^collection_id} = Detective.update_collection(enroll_id, collection_id)
  end

  test "matches a face" do
    {:ok, enroll_id} = Detective.enroll(test_images())
    {:ok, collection_id} = Detective.create_collection("test")
    {:ok, _} = Detective.update_collection(enroll_id, collection_id)
    {:ok, _avg_score} = Detective.match?(test_image(), enroll_id)
  end

  test "identify a face" do
    {:ok, enroll_id} = Detective.enroll(test_images())
    {:ok, collection_id} = Detective.create_collection("test")
    {:ok, _} = Detective.update_collection(enroll_id, collection_id)
    {:ok, _avg_score} = Detective.identity?(test_image(), collection_id)
  end
end
