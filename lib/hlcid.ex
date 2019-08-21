defmodule HLCID do
  @moduledoc """
  Documentation for Hlcid.
  """

  alias HLCID.{Clock}

  @doc """
  Generates a new id. An optional encoding parameter is specified.
  """
  def generate do
    {:ok, ts} = HLClock.send_timestamp(Clock)

    ts
  end

  def to_base64(ts) do
    ts
    |> HLClock.Timestamp.encode()
    |> Base.url_encode64()
  end

  def from_base64(ts) when is_binary(ts) do
    ts
    |> Base.url_decode64!()
    |> HLClock.Timestamp.decode()
  end
end
