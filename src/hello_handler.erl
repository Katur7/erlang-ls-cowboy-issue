-module(hello_handler).
-behaviour(cowboy_rest).

%% Cowboy exports
-export([ init/2
        , allowed_methods/2
        , content_types_provided/2
        , to_json/2
        ]).

%%%===================================================================
%%% Cowboy callbacks
%%%===================================================================

-record(state, { }).

init(Req, _) ->
    State = #state{ },
    {cowboy_rest, Req, State}.

allowed_methods(Req, State) ->
    {[<<"HEAD">>, <<"GET">>, <<"POST">>, <<"OPTIONS">>], Req, State}.

content_types_provided(Req, State) ->
    {[{{<<"application">>, <<"json">>, '*'}, to_json}], Req, State}.

%%%===================================================================
%%% Handlers
%%%===================================================================

to_json(Req, State) ->
    Data = #{ msg => <<"Hello Erlang!">> },
    {jsx:encode(Data), Req, State}.
