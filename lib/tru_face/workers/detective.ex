defmodule TruFace.Workers.Detective do
  @moduledoc """
  Detective module provides functions for face detection
  with a Generic Server behavior.
  """

  use GenServer

  alias TruFace.Detective

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec enroll(list(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def enroll(images, name) do
    GenServer.call(__MODULE__, {:enroll, images, name})
  end

  @spec update(list(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def update(images, eid) do
    GenServer.call(__MODULE__, {:update, images, eid})
  end

  @spec create_collection(String.t()) :: {:ok, String.t()} | {:error, map()}
  def create_collection(name) do
    GenServer.call(__MODULE__, {:create_collection, name})
  end

  @spec update_collection(String.t(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def update_collection(eid, cid) do
    GenServer.call(__MODULE__, {:update_collection, eid, cid})
  end

  @spec train(String.t()) :: {:ok, String.t()} | {:error, map()}
  def train(cid) do
    GenServer.call(__MODULE__, {:train, cid})
  end

  @spec match?(binary(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def match?(raw_image, eid) do
    GenServer.call(__MODULE__, {:match, raw_image, eid})
  end

  @spec identity(binary(), String.t()) :: {:ok, String.t()} | {:error, map()}
  def identity(raw_image, cid) do
    GenServer.call(__MODULE__, {:identify, raw_image, cid})
  end

  #####
  # GenServer Callbacks
  #####

  def handle_call({:enroll, images, name}, _from, state) do
    response = Detective.enroll(images, name)
    {:reply, response, state}
  end

  def handle_call({:update, images, eid}, _from, state) do
    response = Detective.update(images, eid)
    {:reply, response, state}
  end

  def handle_call({:create_collection, name}, _from, state) do
    response = Detective.create_collection(name)
    {:reply, response, state}
  end

  def handle_call({:update_collection, eid, cid}, _from, state) do
    response = Detective.update_collection(eid, cid)
    {:reply, response, state}
  end

  def handle_call({:train, cid}, _from, state) do
    response = Detective.train(cid)
    {:reply, response, state}
  end

  def handle_call({:match, raw_image, eid}, _from, state) do
    response = Detective.match?(raw_image, eid)
    {:reply, response, state}
  end

  def handle_call({:identify, raw_image, cid}, _from, state) do
    response = Detective.identity?(raw_image, cid)
    {:reply, response, state}
  end
end
