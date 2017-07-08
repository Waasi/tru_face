defmodule TruFace.RequestHelperTest do
  use ExUnit.Case

  alias TruFace.RequestHelper

  test "returns headers" do
    expected = TestHelper.expected_headers()
    assert ^expected = RequestHelper.headers()
  end

  test "returns a path" do
    expected = TestHelper.expected_path_for("enroll")
    assert ^expected = RequestHelper.path_for("enroll")
  end

  test "parses response" do
    assert {:error, %{reason: "Not Found"}} = RequestHelper.parse_response(%HTTPoison.Response{status_code: 404})
  end

  test "builds payload" do
    response = 
      ["one", "two"]
      |> RequestHelper.build(%{}, 0)
    assert %{"img0" => "one", "img1" => "two"} = response
  end
end
