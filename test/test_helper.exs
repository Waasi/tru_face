ExUnit.start()

defmodule TestHelper do
  def test_images() do
    test_images_path()
    |> File.ls!()
    |> Enum.map(&read_image/1)
  end

  def test_image() do
    test_images_path()
    |> File.ls!()
    |> Enum.at(0)
    |> read_image()
  end

  def expected_headers do
    api_key = Application.get_env(:tru_face, :api_key)
    [{"Content-Type", "application/json"}, {"x-api-key", api_key}]
  end

  def expected_path_for(resource) do
    "https://api.chui.ai/v1/#{resource}"
  end

  defp read_image(image_path) do
    "#{test_images_path()}/#{image_path}"
    |> File.read!()
  end

  defp test_images_path() do
    Application.get_env(:tru_face, :test_images_path)
  end
end
