%% -*- erlang -*-
%%
%% Copyright 2016 Jörgen Brandt
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

%% @author Jörgen Brandt <brandjoe@hu-berlin.de>

-module( combin ).

%% API exports
-export( [cnr/1, cnr/2, permut_map/1] ).

-ifdef( TEST ).
-include_lib("eunit/include/eunit.hrl").
-endif.


%%====================================================================
%% API functions
%%====================================================================

%% @doc Enumerates all possible combinations without replacement by drawing
%%      elements from a list.

-spec cnr( SrcLst::[_] ) -> [[_]].

cnr( SrcLst )
when is_list( SrcLst ) ->

  F = fun( N ) -> cnr( N, SrcLst ) end,

  lists:flatmap( F, lists:seq( 1, length( SrcLst ) ) ).


%% @doc Enumerates all combinations of length `N` without replacement by drawing
%%      elements from a list.

-spec cnr( N::pos_integer(), SrcLst::[_] ) -> [[_]].

cnr( N, SrcLst )
when is_integer( N ), N > 0,
     is_list( SrcLst ) ->

  Cnr = fun
          Cnr( 0, _, Acc )     -> [Acc];
          Cnr( _, [], _ )      -> [];
          Cnr( M, [H|T], Acc ) ->
            case T of
              []    -> Cnr( M-1, [], [H|Acc] );
              [_|_] -> Cnr( M-1, T, [H|Acc] )++Cnr( M, T, Acc )
            end
        end,
     
  Cnr( N, lists:usort( SrcLst ), [] ).


%% @doc Enumerates all possible permutations by drawing one element from each
%%      list value of a given map `SrcMap`.

-spec permut_map( #{ _ => [_] } ) -> [#{ _ => _ }].

permut_map( SrcMap ) when is_map( SrcMap ) ->

  F = fun
        ( K, VLst, [] )  -> [#{ K => V } || V <- VLst];
        ( K, VLst, Acc ) -> [A#{ K => V } || V <- VLst, A <- Acc]
      end,

  maps:fold( F, [], SrcMap ).


%%====================================================================
%% Internal functions
%%====================================================================










%%====================================================================
%% Unit tests
%%====================================================================

-ifdef( TEST ).

cnr_one_returns_n_elements_test() ->
  SrcLst = [a, b, c, d, e, f],
  ?assertEqual( 6, length( cnr( 1, SrcLst ) ) ).

cnr_n_returns_one_elements_test() ->
  SrcLst = [a, b, c, d, e, f],
  ?assertEqual( 1, length( cnr( 6, SrcLst ) ) ).

cnr_is_robust_wrt_duplicates_test() ->
  SrcLst = [a, b, c, d, e, f, f, e, b],
  ?assertEqual( 1, length( cnr( 6, SrcLst ) ) ).

cnr_all_test() ->
  SrcLst = [a,b,c],
  ?assertEqual( 3+3+1, length( cnr( SrcLst ) ) ).

-endif.