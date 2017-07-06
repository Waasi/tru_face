# TruFace
[![Build Status](https://travis-ci.org/Waasi/tru_face.svg?branch=master)](https://travis-ci.org/Waasi/tru_face)

This is an Elixir library for [TrueFace AI](https://chui.ai/)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `tru_face` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:tru_face, "~> 0.1.0"}]
    end
    ```

  2. Ensure `tru_face` is started before your application:

    ```elixir
    def application do
      [applications: [:tru_face]]
    end
    ```

Remember to add the following:

For testing purposes add a directory with images of a person
and add the path to an env variable named `TEST_IMAGES_PATH`.

Once you get a TrueFace AI api key add an env variable named `TRUE_FACE_API_KEY`
with the obtained api key as value.

## Usage

The full documentation for TruFace can be found [here](here)

## Contributing

1. Fork it (https://github.com/[my-github-username]/tru_face/fork)
2. Create your feature branch (`git checkout -b feature/my_new_feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Special Thanks To:

- @nchafni for all the support.
