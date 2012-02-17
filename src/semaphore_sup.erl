%% @doc
-module(semaphore_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Callbacks
-export([init/1]).

-include("include/semaphore.hrl").

%%
%% API
%%

-spec start_link() -> supervisor:start_link_ret().
%% @doc
start_link() -> supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%
%% Callbacks
%%

-spec init([]) -> {ok, {{supervisor:strategy(), pos_integer(),                  pos_integer()},
                        [supervisor:child_spec()]}}.
%% @hidden
init([]) ->
    Child = {?SERVER, {?SERVER, start_link, [?SERVER]},
             permanent, 8000, worker, [?SERVER]},
    {ok, {{one_for_one, 0, 1}, [Child]}}.
