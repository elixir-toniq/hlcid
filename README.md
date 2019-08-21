# HLCID

HLCID provides an API for generating 128 bit, k-ordered, globally unique ids without coordination.

## Why do I need this?

Distributed systems often need to generate unique ids. But standard UUIDv4 ids don't provide any sorting capabilities. HLCIDs are globally unique and roughly time sorted. Servers can generate these ids with no coordination.

## How does it work?

HLCID is an OTP application which runs on each of your nodes. You can ask it for an ID like so:

```elixir
id = HLCID.generate()
url_safe_id = HLCID.to_base64()
=> "AWy00jCrAABKaDWL0Z6heg=="
```

Each ID is a slightly modified [hybrid logical clock](https://cse.buffalo.edu/tech-reports/2014-04.pdf). Each timestamp is composed of 48 bits of physical time, 16 bits of logical time, and 64 bits of random bytes. When encoded as binaries each id maintains lexical ordering.

HLCs automatically account for clock drift by utilizing both physical and logical time. But if the physical clock drifts beyond a given range - 300 seconds by default - you won't be able to generate IDs. If you run HLCID in production, you'll want to monitor NTP for clock drift. Because HLCs use logical time to avoid conflicts and provide one-way causality tracking, there is a limited number of ids available in a millisecond window. This limitation isn't a problem for our use case, but if you need to generate more then 65000 ids per node per millisecond, than HLCID won't work for you.

## Additional projects

* [HLClock](https://github.com/toniqsystems/hlclock) - The library which provides the hybrid logical clocks.
* [ecto_hlclock](https://github.com/toniqsystems/ecto_hlclock) - Provides Ecto migrations and types for using HLCs as a database id.

## Alternatives

While HLCID works for our use case, you should be aware of the alternative solutions and chose one that matches your needs.

* Flake - Flake IDs heavily inspired HLCID. The main differences are that HLCID uses a purely random set of bytes instead of the machine name. If HLCIDs are broadcast across your cluster, they can be also be used for snapshots.
* KSUID - These ids provide the same benefits of flake and HLCID, but KSUID allows for far more events in a given time window due to its use of randomness. It also has no bounds on the physical clock when means it can't become unavailable.

## Installation

```elixir
def deps do
  [
    {:hlcid, "~> 0.1.0"}
  ]
end
```
