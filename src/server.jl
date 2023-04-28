module Server
include("CCSTwin.jl")
using .CCSTwin
using Sockets

function start()
  println(placeholderfunc())

  errormonitor(@async begin
    server = listen("testpipe")
    println("listening")
    while true
      sock = accept(server)
      @async while isopen(sock)
        write(sock, readline(sock, keep=true))
      end
    end
  end)
end

end