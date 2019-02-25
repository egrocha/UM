import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;

class Servidor {

    private int cont;
    private ArrayList<String> usernames;
    private HashMap<Integer, Socket> clientes;

    Servidor(){
        this.cont = 0;
        this.usernames = new ArrayList<>();
        this.clientes = new HashMap<>();
    }

    void start() throws IOException {
        ServerSocket serverSocket = new ServerSocket(12345);

        while (true) {
            Socket socket = serverSocket.accept();
            clientes.put(cont, socket);
            Worker worker = new Worker(cont, clientes, usernames);
            cont++;
            Thread thread = new Thread(worker);
            thread.start();
        }
    }

}
