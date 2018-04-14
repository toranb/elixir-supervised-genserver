# run the app from the command line

iex -S mix run

# inspect the pid of our first bucket process

pid = GenServer.whereis({:via, KV.Registry, {KV.Bucket, 1}})

# put a value in the map

KV.Bucket.put(1, "name", "toran")

# get a value from the map

KV.Bucket.get(1, "name")

# kill the child process

Process.exit(pid, :kill)

# inspect to learn that the first bucket worker has a new pid

GenServer.whereis({:via, KV.Registry, {KV.Bucket, 1}})

# get a value from the map

KV.Bucket.get(1, "name")

# To see what process information the Registry knows about

:sys.get_state(:registry)
