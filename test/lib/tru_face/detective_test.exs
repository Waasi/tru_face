defmodule TruFace.DetectiveTest do
  use ExUnit.Case

  alias TruFace.Detective

  import TestHelper
  import Mock

  test "enrolls 3 images" do
    with_mocks([
      {HTTPoison, [], [post!: fn(_, _, _, _) -> mocked_enroll() end]},
      {HTTPoison, [], [put!: fn(_, _, _, _) -> mocked_update_enroll() end]}
    ]) do
      Detective.enroll(test_images())
    end
  end

  test "updates a profile" do
    with_mocks([
      {HTTPoison, [], [post!: fn(_, _, _, _) -> mocked_enroll() end]},
      {HTTPoison, [], [put!: fn(_, _, _, _) -> mocked_update_enroll() end]}
    ]) do
      {:ok, enrollment_id} = Detective.enroll(test_images())
      assert {:ok, ^enrollment_id} = Detective.update(test_images(), enrollment_id)
    end
  end

  test "creates a collection" do
    with_mocks([
      {HTTPoison, [], [post!: fn(_, _, _, _) -> mocked_create_collection() end]},
      {HTTPoison, [], [put!: fn(_, _, _, _) -> mocked_update_collection() end]}
    ]) do
      assert {:ok, _} = Detective.create_collection("test")
    end
  end

  test "updates a collection" do
    with_mocks([
      {HTTPoison, [],
        [post!: fn
          ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_enroll()
          ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_create_collection()
        end]
      },
      {HTTPoison, [],
        [put!: fn
           ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_update_enroll()
           ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_update_collection()
        end]
      }
    ]) do
      {:ok, enrollment_id} = Detective.enroll(test_images())
      {:ok, collection_id} = Detective.create_collection("test")
      assert {:ok, ^collection_id} = Detective.update_collection(enrollment_id, collection_id)
    end
  end

  test "trains a collection" do
    with_mocks([
      {HTTPoison, [],
        [post!: fn
          ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_enroll()
          ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_create_collection()
          ("https://api.chui.ai/v1/train", _, _, _) -> mocked_train_collection()
        end]
      },
      {HTTPoison, [],
        [put!: fn
           ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_update_enroll()
           ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_update_collection()
        end]
      }
    ]) do
      {:ok, enrollment_id} = Detective.enroll(test_images())
      {:ok, collection_id} = Detective.create_collection("test")
      assert {:ok, ^collection_id} = Detective.update_collection(enrollment_id, collection_id)
    end
  end

  test "matches a face" do
    with_mocks([
      {HTTPoison, [],
        [post!: fn
          ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_enroll()
          ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_create_collection()
          ("https://api.chui.ai/v1/match", _, _, _) -> mocked_face_match()
        end]
      },
      {HTTPoison, [],
        [put!: fn
           ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_update_enroll()
           ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_update_collection()
        end]
      }
    ]) do
      {:ok, enrollment_id} = Detective.enroll(test_images())
      {:ok, collection_id} = Detective.create_collection("test")
      {:ok, _} = Detective.update_collection(enrollment_id, collection_id)
      {:ok, 0.9} = Detective.match?(test_image(), enrollment_id)
    end
  end

  test "identify a face" do
    with_mocks([
      {HTTPoison, [],
        [post!: fn
          ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_enroll()
          ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_create_collection()
          ("https://api.chui.ai/v1/identify", _, _, _) -> mocked_face_identity()
        end]
      },
      {HTTPoison, [],
        [put!: fn
           ("https://api.chui.ai/v1/enroll", _, _, _) -> mocked_update_enroll()
           ("https://api.chui.ai/v1/collection", _, _, _) -> mocked_update_collection()
        end]
      }
    ]) do
      {:ok, enrollment_id} = Detective.enroll(test_images())
      {:ok, collection_id} = Detective.create_collection("test")
      {:ok, _} = Detective.update_collection(enrollment_id, collection_id)
      {:ok, "person_id"} = Detective.identity?(test_image(), collection_id)
    end
  end
end
