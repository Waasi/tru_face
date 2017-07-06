use Mix.Config

config :tru_face,
  api_key: System.get_env("TRUE_FACE_API_KEY"),
  test_images_path: System.get_env("TEST_IMAGES_PATH")
