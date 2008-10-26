%%%-------------------------------------------------------------------
%%% File    : SKEL_SHORTNAME_sup.erl
%%% Author  :  <todd@amiestreet.com>
%%% Description : Price Service supervisor
%%%
%%% Created :  5 Feb 2008 by  <todd@amiestreet.com>
%%%-------------------------------------------------------------------
-module(SKEL_SHORTNAME_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
%%--------------------------------------------------------------------
%% Function: start_link() -> {ok,Pid} | ignore | {error,Error}
%% Description: Starts the supervisor
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================
%%--------------------------------------------------------------------
%% Func: init(Args) -> {ok,  {SupFlags,  [ChildSpec]}} |
%%                     ignore                          |
%%                     {error, Reason}
%% Description: Whenever a supervisor is started using 
%% supervisor:start_link/[2,3], this function is called by the new process 
%% to find out about restart strategy, maximum restart frequency and child 
%% specifications.
%%--------------------------------------------------------------------
init([]) ->
    ServiceChild = {SKEL_SHORTNAME_service,
                    {SKEL_SHORTNAME_service,start_link,[]},
                    permanent,2000,worker,[SKEL_SHORTNAME_service]},
    {ok,{{one_for_one,5,60}, [ServiceChild]}}.

%%====================================================================
%% Internal functions
%%====================================================================
