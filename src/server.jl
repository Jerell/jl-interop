module Server

include("CCSTwin.jl")
using .CCSTwin
using ZMQ

function start()
    context = Context()
    socket = Socket(context, REP)
    ZMQ.bind(socket, "tcp://*:5555")

    while true
        # Wait for next request from client
        message = String(ZMQ.recv(socket))
        println("Received request: $message")

        # Do some 'work'
        sleep(1)

        # Send reply back to client
        ZMQ.send(socket, placeholderfunc())
    end

    println("stopping")
    ZMQ.close(socket)
    ZMQ.close(context)
end


end