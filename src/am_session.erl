-module(am_session).
-export([start/1,
         get_exercise/2,
         send_answer/2]).


start(Level) ->        % user's first time ? ah, so give him a test and level
    if
        Level == 1 ->
            spawn(fun() -> level1() end);
        Level == 2 ->
            spawn(fun() -> level2() end)
    end.


get_exercise(Pid, Event) ->
    Ref = make_ref(),
    Pid ! {self(), Ref, Event},
    receive
        {Ref, Msg, Res} -> {ok, Msg, Res}
    after 15000 ->
        {error, timeout}
    end.


send_answer(Pid, Answer) ->
    Ref = make_ref(),
    Pid ! {self(), Ref, Answer},
    level1(). % here we decide if change level or not

wait_answer() ->
    receive
        {Pid, Ref, Answer} -> ok;
        io:format("answer received")
    end,
    level2().


level1() ->
    receive
        {Pid, Ref, Msg} -> Pid ! {Ref, "1 + 1", 2};
        _ -> ok
    end,
    io:format("Sent exercise - level1"),
    wait_answer().


level2() ->
    receive
        {Pid, Ref, Msg} -> Pid ! {Ref, "2 + 1", 3};
        _ -> ok
    end,
    io:format("Sent exercise - level2"),
    wait_answer().



wait_answer() ->
    ok.
