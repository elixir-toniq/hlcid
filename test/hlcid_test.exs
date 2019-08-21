defmodule HLCIDTest do
  use ExUnit.Case
  doctest HLCID

  @valid_base64 ~r"^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$"

  test "can generate ids" do
    assert ts = HLCID.generate()
  end

  test "can encode and decode to base64" do
    id = HLCID.generate()

    assert HLCID.to_base64(id) =~ @valid_base64

    assert id
           |> HLCID.to_base64()
           |> HLCID.from_base64() == id
  end
end
