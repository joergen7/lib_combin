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
-export( [cnr/2] ).

-ifdef( TEST ).
-include_lib("eunit/include/eunit.hrl").
-endif.


%%====================================================================
%% API functions
%%====================================================================

-spec cnr( N::pos_integer(), Omega::[_] ) -> [[_]].

cnr( N, Omega )
when is_integer( N ), N > 0,
     is_list( Omega ) ->
     
  cnr( N, Omega, [] ).

%%====================================================================
%% Internal functions
%%====================================================================


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

-endif.