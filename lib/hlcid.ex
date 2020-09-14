defmodule HLCID do
  @moduledoc """
  HLCID is an OTP application which runs on each of your nodes. You can ask it
  for an ID like so:

  ```elixir
  id = HLCID.generate()
  url_safe_id = HLCID.to_base64(id)
  => "AWy00jCrAABKaDWL0Z6heg=="
  ```

  Each ID is a slightly modified [hybrid logical clock](https://cse.buffalo.edu/tech-reports/2014-04.pdf).
  Each timestamp is composed of 48 bits of physical time, 16 bits of logical
  time, and 64 bits of random bytes. When encoded as binaries each id maintains
  lexical ordering.

  HLCs automatically account for clock drift by utilizing both physical and
  logical time. But if the physical clock drifts beyond a given range
  - 300 seconds by default - you won't be able to generate IDs. If you run
  HLCID in production, you'll want to monitor NTP for clock drift. Because HLCs
  use logical time to avoid conflicts and provide one-way causality tracking,
  there is a limited number of ids available in a millisecond window. This
  limitation isn't a problem for our use case, but if you need to generate
  more then 65000 ids per node per millisecond, than HLCID won't work for you.
  """

  alias HLCID.{Clock}

  @doc """
  Generates a new id.
  """
  def generate do
    {:ok, ts} = HLClock.send_timestamp(Clock)

    ts
  end

  @doc """
  Converts an id to url safe base64.
  """
  def to_base64(ts) do
    ts
    |> HLClock.Timestamp.encode()
    |> Base.url_encode64()
  end

  @doc """
  Converts a base64 binary back to a id
  """
  def from_base64(ts) when is_binary(ts) do
    ts
    |> Base.url_decode64!()
    |> HLClock.Timestamp.decode()
  end
end
