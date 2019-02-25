import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

class Cliente {

    private int port;


    Cliente(int port){
        this.port = port;
    }

    void start() throws IOException {
        Socket socket = new Socket("127.0.0.1", port);

        Scanner scanner = new Scanner(System.in);
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        BufferedReader inServer = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        PrintWriter out = new PrintWriter(socket.getOutputStream());

        System.out.println(inServer.readLine());
        String username = scanner.next();
        out.println(username);
        out.flush();

        ClienteReader clienteReader = new ClienteReader(inServer);
        Thread thread = new Thread(clienteReader);
        thread.start();

        String line = "";
        while(!line.equals("exit")){
            line = in.readLine();
            out.println(line);
            out.flush();
        }

        socket.shutdownOutput();
        socket.shutdownInput();
        socket.close();
    }

}
