Elixir
===

## Baby steps
+ Install using this guide: https://elixir-lang.org/getting-started/introduction.html#installation
+ Verify if the installation is done: `$elixir --version`
+ Run interactive shell: `$iex`
+ Execute a source file: `$elixir abc.exs`


## Mix
+ `mix` is a the Elixir build tool:
   + To create a new project from scaffolding: `$ mix new {folder_name} --module {module_name}`
   + To compile a project, go into the project folder and: `$ mix compile`
   + Once project has been compiled, you can start a session inside: `$ iex -S mix`
     + You can do live debugging here, e.g. `KV.hello`
   + To run test, go into the project folder and: `$ mix test`
   + `$ mix help` to have more information
   + `mix deps.get` to install all dependencies (Ruby's `bundle install`)
+ Get help in `iex`:
   + `h <module_name>` to get help, e.g. `h Map`
   + `h <func>` to get information about the function, e.g. `h Map.keys/1`
   + `i variable_name` to get information about that variable 


## Syntax
+ `IO.puts "Hello world"` to print onto console
+ `Process.sleep(10)` to put the process to sleep for 10 millisec
+ `pid = spawn(ModuleName, :method, [])` to spawn a new process
+ `send pid, message` to send `message` to the process
+ `flush` to flush all message to shell
+ `:observer.start` to start the ErlangVM' observer app
+ `IEx.Helpers.recompile` to reload code from inside `iex`

## Clustering

+ `iex --sname quynh` to start a new shell with (short) name = `quynh`
+ `iex --name quynh@127.0.0.1` to start a new shell with a long name
+ From the shell, i.e. `iex`
   + `node` to get the name of node name of the VM
   + `Node.list` to get the list nodes that connect to the current one
   + `Node.connect <name>` to connect the current shell to another node
+ `:rpc.multical/3` to execute code in the cluster
+ `mix escript.build` to generate the command line


+ ​

## Postgres
+ Start the service: `pg_ctl -D /usr/local/var/postgres start`
+ Stop the service: `pg_ctl -D /usr/local/var/postgres stop`
+ Version: `postgres -V `
+ Command line: `psql postgres`
  + `\du`: see what's installed on the machine
  + `\l`: list of databases
  + `\d`: list of tables

## GenServer

## Supervisor
+ `Process.info(self, :links)` to find all processes linked to the current one
+ `Process.link(pid)` to link the current process to the `pid` one
+ `Process.alive?(pid)` whether a process is still alive
+ `Process.flag(:trap_exit, true)` to trap the exit signals from the current process

## Ring project - Chapter 5

Ring of linked process:

+ `iex -S mix`: Get into interactive console
+ `pids = Ring.create_processes(10)`: Create 10 processes
+ `Ring.link_processes(pids)`: Create a ring of linked processes
+ `pids |> Enum.map(fn pid -> "#{inspect pid}: #{inspect Process.info(pid, :links)}" end)`: Inspec the ring
+ `pids |> Enum.shuffle |> List.first |> send(:crash)`: Crash a random process in the ring
+ `pids |> Enum.map(fn pid -> Process.alive?(pid) end)`: Check whether any process is still alive

Trapping exits:

+ `Process.flag(:trap_exit, true)`: Trap the exit signals from the current process
+ `pid = spawn(fn -> receive do :crash -> 1/0 end end)`: Create a process that will crash on signal
+ `Process.link(pid)`: Link two processes
+ `send(pid, :crash)`: Crash the target process
+ `flush`: To see the crash message the current process receive
+ Note that the current process still survice after the crash

3 ways for a process to terminate:

+ Naturally, no more code to run

   + `pid = spawn(fn -> receive do :ok -> :ok end end)`: a process to wait for only one message
   + `Process.link(pid)`
   + `send(pid, :ok)`: execute the code
   + `flush`: to see the message on the shell
+ Forcefully terminated
   + `Process.flag(:trap_exit, true)`: trap the exit signals
   + `Process.exit(self, :whoops)`: raise exit signal
   + `flush`: to see the exit signal was trapped
   + `Process.exit(self, **:kill**)`: send an **untrappable** signal, the shell will be crashed
+ Exception on a process, per the previous example

## Data types

Elixir support the following data types:
+ Value types
   + Integer
   + Float
   + Atom
   + Range
   + Regex
+ System types
   + PID and port
   + Reference 
+ Collection types
   + Tuple
   + List
   + Maps
   + Binaries

**Utilities:**
+ `i` command in `iex`: Print out information about a variable

## Plan
+ `Blitzy` command-line program
+ `Registry` for message dispatching & pub/sub


## Phoenix

- Install the latest version of Phoenix: `mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez`
- `mix phx.new` to create a new project, e.g. `mix phx.new conduit --module Conduit --app conduit --no-brunch --no-html`
- `mix phx.server` to run the Phoenix webserver, default URL: `http://localhost:4000/`
- `mix phx.routes` to show the defined routes in the application


##Dev Environment

+ Erlang version: `erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell`
+ Elixir version: `elixir -v`
+ `asdf` for version manager:
   + 	​