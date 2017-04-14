# Basic combinatorics for Erlang lists and maps.

[![hex.pm](https://img.shields.io/hexpm/v/lib_combin.svg?style=flat-square)](https://hex.pm/packages/lib_combin) [![Build Status](https://travis-ci.org/joergen7/lib_combin.svg?branch=dev)](https://travis-ci.org/joergen7/lib_combin)

This library provides basic combinatoric operations like permutation or combinations without replacement for the most common data structures in Erlang: lists and maps.

# Adding lib_combin to a Project

## rebar3

To integrate `lib_combin` into a rebar3 managed project change the `deps` entry in your application's `rebar.config` file to include the tuple `{lib_combin, "0.1.1"}`.

    {deps, [{lib_combin, "0.1.1"}]}.

## mix

    {:lib_combin, "~> 0.1.1"}

# API Documentation

The [documentation](https://cuneiform-lang.org/man/lib_combin/index.html) of the `lib_combin` module's API is available online.

# Examples

## Combinations without replacement

To enumerate all combinations (order does not matter) without replacement of length 2 by drawing from the list `[a, b, c]` we use the `cnr/2` function as follows:

    lib_combin:cnr( 2, [a, b, c] ).
    [[b,a],[c,a],[c,b]]


# Resources

- [seantanly/elixir-combination](https://github.com/seantanly/elixir-combination). An alternative library for combinations and permutations in Elixir.


# License

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)