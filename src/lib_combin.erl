%% -*- erlang -*-
%%
%% Basic combinatorics for Erlang lists and maps.
%%
%% Copyright 2016-2017 Jorgen Brandt
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%    http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

%% @author Jörgen Brandt <joergen@cuneiform-lang.org>
%% @version 0.1.5
%% @copyright 2016 Jörgen Brandt

-module(lib_combin).

-export([cnr_all/1, cnr/2, pnr/1, permut_map/1, pick_from/1, vnr/2, fac/1]).

%%====================================================================
%% API functions
%%====================================================================


%% @doc Enumerates all combinations (order does not matter) with any possible
%%      length without replacement by drawing elements from `SrcLst'.
%%
%%      Example:
%%      ```
%%      lib_combin:cnr_all( [a,b,c] ).
%%      [[],[a],[b],[c],[b,a],[c,a],[c,b],[c,b,a]]
%%      '''
-spec cnr_all(SrcLst :: [_]) -> [[_]].

cnr_all(SrcLst) ->

    F = fun(N) -> cnr(N, SrcLst) end,

    lists:flatmap(F, lists:seq(0, length(SrcLst))).


%% @doc Enumerates all combinations (order does not matter) of length `N'
%%      without replacement by drawing elements from `SrcLst'.
%%
%%      Herein, `N` must be non-negative for the function clause to match.
%%
%%      Example:
%%      ```
%%      lib_combin:cnr( 2, [a,b,c] ).
%%      [[b,a],[c,a],[c,b]]
%%      '''
-spec cnr(N :: _, SrcLst :: [_]) -> [[_]].

cnr(N, SrcLst) when N >= 0 ->

    Cnr = fun Cnr(0, _, Acc) -> [Acc];
              Cnr(_, [], _) -> [];
              Cnr(M, [H | T], Acc) ->
                  case T of
                      [] -> Cnr(M - 1, [], [H | Acc]);
                      [_ | _] -> Cnr(M - 1, T, [H | Acc]) ++ Cnr(M, T, Acc)
                  end
          end,

    Cnr(N, SrcLst, []).


%% @doc Enumerates all variations (order matters) of length `N' without
%%      replacement by drawing elements from `SrcLst'.
%%
%%      Herein, `N` must be non-negative for the function clause to match.
%%
%%      Example:
%%      ```
%%      lib_combin:vnr( 2, [a,b,c] ).
%%      [[b,a],[c,a],[a,b],[c,b],[a,c],[b,c]]
%%      '''


-spec vnr(N :: _, SrcLst :: [_]) -> [[_]].

vnr(N, SrcLst) when N >= 0 ->

    Variat = fun Variat(0, _, Acc) ->
                     [Acc];
                 Variat(M, S, Acc) ->
                     lists:flatmap(fun(X) -> Variat(M - 1, S -- [X], [X | Acc]) end, S)
             end,

    Variat(N, SrcLst, []).


%% @doc Enumerates all permutations (order matters) without replacement by
%%      drawing elements from `SrcLst'.
%%
%%      Example:
%%      ```
%%      lib_combin:pnr( [a,b,c] ).
%%      [[c,b,a],[b,c,a],[c,a,b],[a,c,b],[b,a,c],[a,b,c]]
%%      '''


-spec pnr(SrcLst :: [_]) -> [[_]].

pnr(SrcLst) ->
    vnr(length(SrcLst), SrcLst).


%% @doc Enumerates all possible permutations by drawing one element from each
%%      list value of a given map `SrcMap'.
%%
%%      Example:
%%      ```
%%      lib_combin:permut_map( #{ sauce => [ketchup, mayo], bread => [sesame, plain], meat => [beef, chicken, mutton] } ).
%%      [#{bread => plain,meat => beef,sauce => ketchup},
%%       #{bread => sesame,meat => beef,sauce => ketchup},
%%       #{bread => plain,meat => chicken,sauce => ketchup},
%%       #{bread => sesame,meat => chicken,sauce => ketchup},
%%       #{bread => plain,meat => mutton,sauce => ketchup},
%%       #{bread => sesame,meat => mutton,sauce => ketchup},
%%       #{bread => plain,meat => beef,sauce => mayo},
%%       #{bread => sesame,meat => beef,sauce => mayo},
%%       #{bread => plain,meat => chicken,sauce => mayo},
%%       #{bread => sesame,meat => chicken,sauce => mayo},
%%       #{bread => plain,meat => mutton,sauce => mayo},
%%       #{bread => sesame,meat => mutton,sauce => mayo}]
%%      '''


-spec permut_map(maps:iterator(_, _) | map()) -> _.

permut_map(SrcMap) ->

    G = fun(K, VLst, Acc) ->
                [ A#{K => V} || V <- VLst, A <- Acc ]
        end,

    maps:fold(G, [#{}], SrcMap).


%% @doc Picks a random element from a given list.
%%
%%      Example:
%%      ```
%%      pick_from( [a,b,c] ).
%%      c
%%      '''


-spec pick_from([_, ...]) -> _.

pick_from(SrcLst = [_ | _]) ->
    N = rand:uniform(length(SrcLst)),
    lists:nth(N, SrcLst).


%% @doc The factorial function.
%%
%% Example:
%% ```
%% factorial( 4 ).
%% 24
%% '''


-spec fac(non_neg_integer()) -> pos_integer().

fac(0) ->
    1;

fac(N) when N > 0 ->
    N * fac(N - 1).
