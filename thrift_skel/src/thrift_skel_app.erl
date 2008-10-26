%%%-------------------------------------------------------------------
%%% File    : SKEL_SHORTNAME_app.erl
%%% Author  :  <todd@amiestreet.com>
%%% Description : 
%%%
%%% Created :  5 Feb 2008 by  <todd@amiestreet.com>
%%%-------------------------------------------------------------------
-module(SKEL_SHORTNAME_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, create_tables/0]).

-export([start_all/0, cold_start/0]).

%%====================================================================
%% Application callbacks
%%====================================================================
%%--------------------------------------------------------------------
%% Function: start(Type, StartArgs) -> {ok, Pid} |
%%                                     {ok, Pid, State} |
%%                                     {error, Reason}
%% Description: This function is called whenever an application 
%% is started using application:start/1,2, and should start the processes
%% of the application. If the application is structured according to the
%% OTP design principles as a supervision tree, this means starting the
%% top supervisor of the tree.
%%--------------------------------------------------------------------
start(_Type, _StartArgs) ->
    case SKEL_SHORTNAME_sup:start_link() of
        {ok, Pid} -> 
            {ok, Pid};
        Error ->
            Error
    end.

%%--------------------------------------------------------------------
%% Function: stop(State) -> void()
%% Description: This function is called whenever an application
%% has stopped. It is intended to be the opposite of Module:start/2 and
%% should do any necessary cleaning up. The return value is ignored. 
%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%--------------------------------------------------------------------
%% Function: create_tables
%% 
%% Description: Creates new mnesia tables
%%--------------------------------------------------------------------
create_tables() ->
    ok.

%%--------------------------------------------------------------------
%% Function: start_all
%% 
%% Description: Starts apps this depends on, then starts this
%%--------------------------------------------------------------------
start_all() ->
    application:load(thrift),
    [application:start(App) || App <- [sasl, SKEL_SHORTNAME]].

%%--------------------------------------------------------------------
%% Function: cold_start
%%
%% Description: Creates the database and then starts the server
%%--------------------------------------------------------------------
cold_start() ->
    ok = mnesia:start(),
    ok = create_tables(),
    start_all().

%%====================================================================
%% Internal functions
%%====================================================================
    
