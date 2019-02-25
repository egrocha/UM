import java.io.BufferedReader;
import java.io.IOException;

public class ClienteReader implements Runnable{

    private BufferedReader inServer;

    ClienteReader(BufferedReader inServer){
        this.inServer = inServer;
    }

    public void run(){
        try {
            while(true) {
                System.out.println(inServer.readLine());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
