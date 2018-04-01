# run the app from the command line

iex -S mix run

# find the process id

pid = GenServer.whereis(KV.Bucket)

# put a value in the map

KV.Bucket.put(pid, "name", "toran")

# get a value from the map

KV.Bucket.get(pid, "name")
