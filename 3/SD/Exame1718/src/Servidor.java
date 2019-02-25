import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.concurrent.locks.ReentrantLock;

public class Servidor {


    public static void main(String[] args) throws IOException {

        ServerSocket serverSocket = new ServerSocket(12345);
        ReentrantLock lock = new ReentrantLock();
        ArrayList<String> jogadores = new ArrayList<>();
        JogoImpl jogo = new JogoImpl(jogadores);
        while(true){
            Socket socket = serverSocket.accept();
            Worker worker = new Worker(socket, jogo, lock);
            Thread thread = new Thread(worker);
            thread.start();
        }

    }

}
