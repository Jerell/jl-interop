using NetMQ.Sockets;
using NetMQ;

namespace api;
public class Client
{
  public static string Main()
  {
    Console.WriteLine("Connecting to hello world server…");
    string str = "";
    using (var requester = new RequestSocket())
    {
      requester.Connect("tcp://localhost:5555");

      int requestNumber;
      for (requestNumber = 0; requestNumber != 10; requestNumber++)
      {
        Console.WriteLine("Sending Hello {0}...", requestNumber);
        requester.SendFrame("Hello");
        str = requester.ReceiveFrameString();
        Console.WriteLine("Received World {0}", requestNumber);
      }
      requester.Close();
    }
    return str;
  }
}