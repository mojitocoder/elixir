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


## Syntax
+ `IO.puts "Hello world"` to print onto console
+ `Process.sleep(10)` to put the process to sleep for 10 millisec
+ `pid = spawn(ModuleName, :method, [])` to spawn a new process
+ `send pid, message` to send `message` to the process
+ `flush` to flush all message to shell
+ `:observer.start` to start the ErlangVM' observer app
+ `IEx.Helpers.recompile` to reload code from inside `iex`

## GenServer

## Supervisor
+ `Process.info(self, :links)` to find all processes linked to the current one
+ `Process.link(pid)` to link the current process to the `pid` one
+ `Process.alive?(pid)` whether a process is still alive

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

