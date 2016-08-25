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

-module( lset ).

-export( [intersect/1, intersect/2, union/1, union/2, subtr/1, subtr/2, eq/2] ).
-export( [index_of/2] ).

%%====================================================================
%% API functions
%%====================================================================

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

