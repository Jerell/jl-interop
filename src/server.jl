module Server

include("CCSTwin.jl")
using .CCSTwin
using ZMQ

function start(process_message::Function)
    context = Context()
    socket = Socket(context, REP)
    ZMQ.bind(socket, "tcp://*:5555")

    while true
        # Wait for next request from client
        message = String(ZMQ.recv(socket))
        println("Received request: $message")

        result = process_message(message)
        println("result: $result")
        # Send reply back to client
        ZMQ.send(socket, result)
    end

    println("stopping")
    ZMQ.close(socket)
    ZMQ.close(context)
end


end