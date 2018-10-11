import java.io.*;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.HashMap;

public class Listener {

    public HashMap<Integer,Estado> tabelaEstado;

    public Listener(){
        tabelaEstado = new HashMap<>();
    }

    public void start(){
        String cominginText = "";
        while (true) {
            try {
                ServerSocket serverSocket = new ServerSocket(8888);
                Socket socket = serverSocket.accept();
                ObjectInputStream is = new ObjectInputStream(new BufferedInputStream((socket.getInputStream())));
                Estado estado = (Estado) is.readObject();
                tabelaEstado.put(tabelaEstado.size(),estado);
                System.out.print(tabelaEstado);
                //InetAddress host = InetAddress.getLocalHost();
                //Socket socket = new Socket("239.8.8.8", 8888);
                //Socket socket = new Socket(host, 8888);
            } catch (ClassNotFoundException | IOException e) {
                e.printStackTrace();
            }
        }
    }
}
