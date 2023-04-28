using System.Net;
using System.Net.Sockets;
using System.Text;
using System;
using System.IO;
using System.IO.Pipes;

namespace api;
public class PipeClient
{

  // public static void Main()
  // {
  //   using (NamedPipeClientStream pipeClient =
  //       new NamedPipeClientStream(".", "testpipe", PipeDirection.InOut))
  //   {

  //     // Connect to the pipe or wait until the pipe is available.
  //     Console.Write("Attempting to connect to pipe...");
  //     pipeClient.Connect(1000);

  //     Console.WriteLine("Connected to pipe.");
  //     Console.WriteLine("There are currently {0} pipe server instances open.",
  //        pipeClient.NumberOfServerInstances);
  //     using (StreamReader sr = new StreamReader(pipeClient))
  //     {
  //       // Display the read text to the console
  //       string temp;
  //       while ((temp = sr.ReadLine()) != null)
  //       {
  //         Console.WriteLine("Received from server: {0}", temp);
  //       }
  //     }
  //   }
  //   Console.Write("Press Enter to continue...");
  //   Console.ReadLine();
  // }

  public static async Task Main()
  {
    IPHostEntry ipHostInfo = await Dns.GetHostEntryAsync("127.0.0.1");
    IPAddress ipAddress = ipHostInfo.AddressList[0];
    IPEndPoint ipEndPoint = new(ipAddress, 2_000);

    using Socket client = new(
    ipEndPoint.AddressFamily,
    SocketType.Stream,
    ProtocolType.Tcp);

    await client.ConnectAsync(ipEndPoint);
    while (true)
    {
      // Send message.
      var message = "Hi friends 👋!<|EOM|>";
      var messageBytes = Encoding.UTF8.GetBytes(message);
      _ = await client.SendAsync(messageBytes, SocketFlags.None);
      Console.WriteLine($"Socket client sent message: \"{message}\"");

      // Receive ack.
      var buffer = new byte[1_024];
      var received = await client.ReceiveAsync(buffer, SocketFlags.None);
      var response = Encoding.UTF8.GetString(buffer, 0, received);
      if (response == "<|ACK|>")
      {
        Console.WriteLine(
            $"Socket client received acknowledgment: \"{response}\"");
        break;
      }
    }

    client.Shutdown(SocketShutdown.Both);
  }
}