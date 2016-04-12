
function reroute
    switch $argv[1]
        case start
            sudo route add -net 160.36.127.0/24 172.20.10.1
        case stop
            sudo route delete -net 160.36.127.0/24 172.20.10.1
    end
end
