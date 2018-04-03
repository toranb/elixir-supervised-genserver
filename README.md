# run the app from the command line

iex -S mix run

# get children of supervisor

Supervisor.which_children(KV.Overlord)

# match to get the pid of children running

[{id, pid, type, module}, _] = Supervisor.which_children(KV.Overlord)

Supervisor.which_children(pid)

[{bucketId, bucketPid, bucketType, bucketModule}, _, _] = Supervisor.which_children(pid)

# put a value in the map

KV.Bucket.put(bucketPid, "name", "toran")

# get a value from the map

KV.Bucket.get(bucketPid, "name")

# kill the child process

Process.exit(bucketPid, :kill)

# inspect to learn that the supervisor has a new child pid

[{id, pid, type, module}, _] = Supervisor.which_children(KV.Overlord)

Supervisor.which_children(pid)

[{bucketId, bucketPid, bucketType, bucketModule}, _, _] = Supervisor.which_children(pid)

# get a value from the map

KV.Bucket.get(bucketPid, "name")
