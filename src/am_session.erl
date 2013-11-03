-module(am_session).
-export([start/1,
         level1/0,
         level2/0]).


start(Level) ->        % user's first time ? ah, so give him a test and level
    if
        Level == 1 ->
            spawn(fun() -> level1() end);
        Level == 2 ->
            spawn(fun() -> level2() end)
    end.



level1() ->
    io:format('level1').

level2() ->
    io:format("2").
