-module(erlhoptoad_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, Environment} = application:get_env(environment),
    {ok, ApiKey} = application:get_env(apikey),
    case application:get_env(error_logger) of
       {ok, true} ->
             error_logger:add_report_handler(erlhoptoad_error_logger);
       _ -> ok
    end,

    erlhoptoad_sup:start_link(Environment, ApiKey).

stop(_State) ->
    ok.
