% Copyright 2016 Jörgen Brandt

% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at

%     http://www.apache.org/licenses/LICENSE-2.0

% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

-module( combin ).

%% API exports
-export( [cnr/1, cnr/2] ).
-export( [intersect/1, intersect/2, union/1, union/2, subtr/1, subtr/2, eq/2] ).
-export( [index_of/2] ).

-ifdef( TEST ).
-include_lib("eunit/include/eunit.hrl").
-endif.


%%====================================================================
%% API functions
%%====================================================================

-spec cnr( Omega::[_] ) -> [[_]].

cnr( Omega )
when is_list( Omega ) ->

  F = fun( N ) -> cnr( N, Omega ) end,

  lists:flatmap( F, down_to_1( length( Omega ), [] ) ).


-spec cnr( N::pos_integer(), Omega::[_] ) -> [[_]].

cnr( N, Omega )
when is_integer( N ), N > 0,
     is_list( Omega ) ->
     
  cnr( N, Omega, [] ).

-spec eq( L1::[_], L2::[_] ) -> boolean().

eq( L1, L2 )
when is_list( L1 ),
     is_list( L2 ) ->
  lists:usort( L1 ) =:= lists:usort( L2 ).


-spec intersect( L1::[_], L2::[_] ) -> [_].

intersect( L1, L2 )
when is_list( L1 ),
     is_list( L2 ) ->

  A = lists:usort( L1 ),
  B = lists:usort( L2 ),

  C = A--B,
  D = B--A,

  (lists:usort( A++B )--C)--D.

-spec intersect( L::[[_]] ) -> [_].

intersect( [H] )
when is_list( H ) ->
  lists:usort( H );

intersect( [H|T] )
when is_list( H ) ->
  intersect( H, intersect( T ) ).

-spec union( L1::[_], L2::[_] ) -> [_].

union( L1, L2 )
when is_list( L1 ),
     is_list( L2 ) ->

  A = lists:usort( L1 ),
  B = lists:usort( L2 ),

  lists:usort( A++B ).

-spec union( L::[[_]] ) -> [_].

union( [H] )
when is_list( H ) ->
  lists:usort( H );

union( [H|T] )
when is_list( H ) ->
  union( H, union( T ) ).

-spec subtr( L1::[_], L2::[_] ) -> [_].

subtr( L1, L2 )
when is_list( L1 ),
     is_list( L2 ) ->

  A = lists:usort( L1 ),
  B = lists:usort( L2 ),

  A--B.

-spec subtr( L::[[_]] ) -> [_].

subtr( [H] ) ->
  lists:usort( H );

subtr( [H|T] ) ->
  subtr( H, union( T ) ).


-spec index_of( Member::_, Lst::[_] ) -> pos_integer().

index_of( M, Lst )
when is_list( Lst ) ->
  index_of( M, Lst, 1 ).

%%====================================================================
%% Internal functions
%%====================================================================

-spec index_of( Member::_, Lst::[_], N::pos_integer() ) -> pos_integer().

index_of( M, [], _ ) ->
  error( {eexist, M} );

index_of( M, [M|_], N )
when is_integer( N ), N > 0 ->
  N;

index_of( M, [_|T], N )
when is_integer( N ), N > 0 ->
  index_of( M, T, N+1 ).

-spec cnr( N::pos_integer(), Omega0::[_], Acc::[_] ) -> [_].

cnr( 0, _, Acc )
when is_list( Acc ) ->
  [Acc];

cnr( _, [], _ ) ->
  [];

cnr( N, Omega0, Acc ) 
when is_integer( N ), N > 0,
     is_list( Omega0 ),
     is_list( Acc ) ->

  Omega = lists:usort( Omega0 ),

  [H|T] = Omega,

  case T of
    []    -> cnr( N-1, [], [H|Acc] );
    [_|_] -> cnr( N-1, T, [H|Acc] )++cnr( N, T, Acc )
  end.
  
-spec down_to_1( N::non_neg_integer(), Acc::[pos_integer()] ) -> [pos_integer()].

down_to_1( 0, Acc ) ->
  Acc;

down_to_1( N, Acc )
when is_integer( N ), N > 0,
     is_list( Acc ) ->
  down_to_1( N-1, [N|Acc] ).




%%====================================================================
%% Unit tests
%%====================================================================

-ifdef( TEST ).

cnr_one_returns_n_elements_test() ->
  Omega = [a, b, c, d, e, f],
  ?assertEqual( 6, length( cnr( 1, Omega, [] ) ) ).

cnr_n_returns_one_elements_test() ->
  Omega = [a, b, c, d, e, f],
  ?assertEqual( 1, length( cnr( 6, Omega, [] ) ) ).

cnr_is_robust_wrt_duplicates_test() ->
  Omega = [a, b, c, d, e, f, f, e, b],
  ?assertEqual( 1, length( cnr( 6, Omega, [] ) ) ).

cnr_all_test() ->
  Omega = [a,b,c],
  ?assertEqual( 3+3+1, length( cnr( Omega ) ) ).

-endif.