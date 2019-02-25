import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.concurrent.locks.ReentrantLock;

public class Worker implements Runnable{

    Socket socket;
    JogoImpl jogo;
    ReentrantLock lock;

    public Worker(Socket socket, JogoImpl jogo, ReentrantLock lock) {
        this.socket = socket;
        this.jogo = jogo;
        this.lock = lock;
    }

    public void run(){
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(socket.getOutputStream());
            while(true){
                String line = in.readLine();
                String parts[] = line.split(" ");
                if(parts[0].equals("inscrever")){
                    jogo.inscrever(parts[1]);
                }
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
