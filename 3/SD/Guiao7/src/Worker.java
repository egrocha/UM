import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.locks.ReentrantLock;

public class Worker implements Runnable{

    private int id;
    private ArrayList<String> usernames;
    private HashMap<Integer, Socket> clientes;
    private ReentrantLock lock;

    Worker(int id, HashMap<Integer, Socket> clientes, ArrayList<String> usernames){
        this.id = id;
        this.clientes = clientes;
        this.usernames = usernames;
        this.lock = new ReentrantLock();
    }

    @Override
    public void run() {
        try {
            Socket socket = clientes.get(id);
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(socket.getOutputStream());

            String username;
            while(true) {
                out.println("Introduza o seu username:");
                out.flush();
                username = in.readLine();
                lock.lock();
                boolean userCheck = usernames.contains(username);
                lock.unlock();
                if(userCheck){
                    out.println("ERRO: Username repetido");
                    out.flush();
                }
                else{
                    lock.lock();
                    usernames.add(username);
                    lock.unlock();
                    out.println("Utilizador registado");
                    out.flush();
                    break;
                }
            }

            String line = "";
            while (!line.equals("exit")) {
                line = in.readLine();
                for(Socket s : clientes.values()) {
                    PrintWriter aux = new PrintWriter(s.getOutputStream());
                    if(s != socket) aux.println(username + ": " + line);
                    aux.flush();
                }
            }

            socket.shutdownOutput();
            socket.shutdownInput();
            socket.close();
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
