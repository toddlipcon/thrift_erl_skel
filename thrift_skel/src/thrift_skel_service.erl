-module(SKEL_SHORTNAME_service).

-include("SKEL_ERLANGIFIED_LONGNAME_thrift.hrl").
-include("SKEL_SHORTNAME_types.hrl").

-export([start_link/0, stop/1,
         handle_function/2

% Thrift implementations
% FILL IN HERE
         ]).

%%%%% EXTERNAL INTERFACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start_link() ->
    thrift_server:start_link(get_port(), SKEL_ERLANGIFIED_LONGNAME_thrift, ?MODULE).

stop(Server) ->
    thrift_server:stop(Server),
    ok.

%%%%% THRIFT INTERFACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle_function(Function, Args) when is_atom(Function), is_tuple(Args) ->
    case apply(?MODULE, Function, tuple_to_list(Args)) of
        ok -> ok;
        Reply -> {reply, Reply}
    end.

%%%%% HELPER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_port() ->
    {ok, Result} = application:get_env(SKEL_SHORTNAME, service_port),
    Result.


