-module(lib_combin_tests).

-include_lib("eunit/include/eunit.hrl").
-import(lib_combin, [cnr_all/1, cnr/2, pnr/1, permut_map/1, pick_from/1, vnr/2, fac/1]).


cnr_one_returns_n_elements_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual(6, length(cnr(1, SrcLst))).


cnr_n_returns_one_elements_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual(1, length(cnr(6, SrcLst))).


cnr_zero_is_degenerate_but_valid_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual([[]], cnr(0, SrcLst)).


cnr_neg_throws_error_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertError(function_clause, cnr(-1, SrcLst)).


cnr_too_large_returns_empty_list_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual([], cnr(7, SrcLst)).


cnr_all_test() ->
    SrcLst = [a, b, c],
    ?assertEqual(1 + 3 + 3 + 1, length(cnr_all(SrcLst))).


vnr_one_returns_n_elements_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual(6, length(vnr(1, SrcLst))).


vnr_n_returns_one_elements_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual(fac(6), length(vnr(6, SrcLst))).


vnr_zero_is_degenerate_but_valid_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual([[]], vnr(0, SrcLst)).


vnr_neg_throws_error_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertError(function_clause, vnr(-1, SrcLst)).


vnr_too_large_returns_empty_list_test() ->
    SrcLst = [a, b, c, d, e, f],
    ?assertEqual([], vnr(7, SrcLst)).


pnr_test() ->
    Result = lib_combin:pnr([a, b, c]),
    ?assertEqual(6, length(Result)),
    ?assert(lists:member([c, b, a], Result)),
    ?assert(lists:member([b, c, a], Result)),
    ?assert(lists:member([c, a, b], Result)),
    ?assert(lists:member([a, c, b], Result)),
    ?assert(lists:member([b, a, c], Result)),
    ?assert(lists:member([a, b, c], Result)).


permut_empty_map_returns_empty_map_singleton_test() ->
    ?assertEqual([#{}], permut_map(#{})).


permut_map_containing_single_empty_list_returns_empty_list_test() ->
    ?assertEqual([], permut_map(#{b => []})).


permut_map_containing_empty_list_returns_empty_list_test() ->
    ?assertEqual([], permut_map(#{a => [x, y], b => [], c => [m, n]})).


burger_restaurant_example_test() ->

    IngredientMap = #{
                      sauce => [ketchup, mayo],
                      bread => [sesame, plain],
                      meat => [beef, chicken, mutton]
                     },

    Result = lib_combin:permut_map(IngredientMap),

    ?assertEqual(12, length(Result)),
    ?assert(lists:member(#{sauce => ketchup, bread => sesame, meat => beef}, Result)),
    ?assert(lists:member(#{sauce => mayo, bread => sesame, meat => beef}, Result)),
    ?assert(lists:member(#{sauce => ketchup, bread => plain, meat => beef}, Result)),
    ?assert(lists:member(#{sauce => mayo, bread => plain, meat => beef}, Result)),
    ?assert(lists:member(#{sauce => ketchup, bread => sesame, meat => chicken}, Result)),
    ?assert(lists:member(#{sauce => mayo, bread => sesame, meat => chicken}, Result)),
    ?assert(lists:member(#{sauce => ketchup, bread => plain, meat => chicken}, Result)),
    ?assert(lists:member(#{sauce => mayo, bread => plain, meat => chicken}, Result)),
    ?assert(lists:member(#{sauce => ketchup, bread => sesame, meat => mutton}, Result)),
    ?assert(lists:member(#{sauce => mayo, bread => sesame, meat => mutton}, Result)),
    ?assert(lists:member(#{sauce => ketchup, bread => plain, meat => mutton}, Result)),
    ?assert(lists:member(#{sauce => mayo, bread => plain, meat => mutton}, Result)).


pick_from_singleton_list_returns_only_element_test() ->
    ?assertEqual(a, pick_from([a])).


pick_from_empty_throws_error_test() ->
    ?assertError(function_clause, pick_from([])).


fac_zero_is_one_test() ->
    ?assertEqual(1, fac(0)).


fac_one_is_one_test() ->
    ?assertEqual(1, fac(1)).


fac_two_is_two_test() ->
    ?assertEqual(2, fac(2)).


fac_three_is_six_test() ->
    ?assertEqual(6, fac(3)).


fac_four_is_24_test() ->
    ?assertEqual(24, fac(4)).


fac_neg_throws_error_test() ->
    ?assertError(function_clause, fac(-1)).
