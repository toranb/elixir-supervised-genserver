# run the app from the command line

iex -S mix run

# get children of supervisor

Supervisor.which_children(KV.Supervisor)

# match to get the pid of children running

[{id, pid, type, module}] = Supervisor.which_children(KV.Supervisor)

# put a value in the map

KV.Bucket.put(pid, "name", "toran")

# get a value from the map

KV.Bucket.get(pid, "name")

# kill the child process

Process.exit(pid, :kill)

# inspect to learn that the supervisor has a new child pid

Supervisor.which_children(KV.Supervisor)

# again, match to get the pid of children running

[{id, pid, type, module}] = Supervisor.which_children(KV.Supervisor)

# get a value from the map
# note new pid does not reflect prev state

KV.Bucket.get(pid, "name")
