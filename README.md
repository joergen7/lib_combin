# lib_combin
###### Basic combinatorics for Erlang lists and maps.
[![hex.pm](https://img.shields.io/hexpm/v/lib_combin.svg?style=flat-square)](https://hex.pm/packages/lib_combin)

This library provides basic combinatoric operations like permutation or combinations without replacement for the most common data structures in Erlang: lists and maps.

The [documentation](https://cuneiform-lang.org/man/lib_combin/index.html) of the `lib_combin` module's API is available online.

## Usage

### Adding lib_combin to a Project

#### rebar3

To integrate `lib_combin` into a rebar3 managed project change the `deps` entry in your application's `rebar.config` file to include the tuple `{lib_combin, "0.1.5"}`.

    {deps, [{lib_combin, "0.1.5"}]}.

#### mix

    {:lib_combin, "~> 0.1.5"}

### Examples

#### Combinations without replacement

To enumerate all combinations (order does not matter) without replacement of length 2 by drawing from the list `[a, b, c]` we use the `cnr/2` function as follows:

    lib_combin:cnr( 2, [a, b, c] ).
    [[b,a],[c,a],[c,b]]

To enumerate all combinations (order does not matter) without replacement of any possible length by drawing from the list `[a, b, c]` we use the `cnr_all/1` function as follows:

    lib_combin:cnr_all( [a, b, c] ).
    [[],[a],[b],[c],[b,a],[c,a],[c,b],[c,b,a]]

#### Variations and Permutations

To enumerate all variations (order matters) without replacement of length 2 by drawing from the list `[a, b, c]` we use the `vnr/2` function as follows:

    lib_combin:vnr( 2, [a, b, c] ).
    [[b,a],[c,a],[a,b],[c,b],[a,c],[b,c]]

To enumerate all permutations (order matters) without replacement from the list `[a, b, c]` we use the `pnr/1` function as follows:

    lib_combin:pnr( [a, b, c] ).
    [[c,b,a],[b,c,a],[c,a,b],[a,c,b],[b,a,c],[a,b,c]]

#### Maps

Say, we're leading a burger restaurant which serves burgers made up from a fixed palette of ingredients for bread, meat, and sauce. We can represent the ingredients as an Erlang map in the following way:

    Ingredients = #{ sauce => [ketchup, mayo],
                     bread => [sesame, plain],
                     meat  => [beef, chicken, mutton] }.

To find out which burgers can appear on the menu, we use the function `permut_map/1` as follows:

    lib_combin:permut_map( Ingredients ).
    [#{bread => plain,meat => beef,sauce => ketchup},
     #{bread => sesame,meat => beef,sauce => ketchup},
     #{bread => plain,meat => chicken,sauce => ketchup},
     #{bread => sesame,meat => chicken,sauce => ketchup},
     #{bread => plain,meat => mutton,sauce => ketchup},
     #{bread => sesame,meat => mutton,sauce => ketchup},
     #{bread => plain,meat => beef,sauce => mayo},
     #{bread => sesame,meat => beef,sauce => mayo},
     #{bread => plain,meat => chicken,sauce => mayo},
     #{bread => sesame,meat => chicken,sauce => mayo},
     #{bread => plain,meat => mutton,sauce => mayo},
     #{bread => sesame,meat => mutton,sauce => mayo}]

#### Factorial

The library also contains an implementation of the factorial function.

    lib_combin:fac( 4 ).
    24

## System Requirements

- Erlang OTP 18.0 or higher
- Rebar3 3.0.0 or higher

## Resources

- [joergen7/gen_pnet](https://github.com/joergen7/gen_pnet) A generic Petri net OTP behavior using `lib_combin` to enumerate transition firing modes.
- [seantanly/elixir-combination](https://github.com/seantanly/elixir-combination). An alternative library for combinations and permutations in Elixir.

## Authors

- Jorgen Brandt (joergen7) [joergen.brandt@onlinehome.de](mailto:joergen.brandt@onlinehome.de)

## License

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)
