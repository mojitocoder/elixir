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
   + `:observer.start` to start the ErlangVM' observer app


## Syntax
+ `IO.puts "Hello world"` to print onto console
+ `Process.sleep(10)` to put the process to sleep for 10 millisec
+ `pid = spawn(ModuleName, :method, [])` to spawn a new process
+ `send pid, message` to send `message` to the process
+ ​