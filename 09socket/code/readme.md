https://dev.to/dechamp/the-dreaded-bind-address-already-in-use-kill-it-583l

the dreaded port error "bind: address already in use", kill it!

tl;dr: `lsof -i :<PORT>`, then get PID and run next command with it (be careful running this command) `kill <PID>`. If you want a all in one, you can use this! `kill $(lsof -i :<PORT> | awk 'NR>1 {print $2}')`

So you're cruising along and you go to start your service, just to find out that you had something running on that same port you needed.

DOH!

Well here is a quick solution. Just swap out with lets say 3000, or what ever your port is.

`lsof -i :<port>`
