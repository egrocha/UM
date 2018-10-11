import java.io.IOException;

public class MonitorUDP {

    public MonitorUDP(){
        Sender s = new Sender(3,"Pedido");
        Runnable r = () -> {
            try {
                s.start();
            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            }
        };
        Thread t = new Thread(r);
        t.start();
        Listener l = new Listener();
        Runnable r2 = l::start;
        Thread t2 = new Thread(r2);
        t2.start();
    }
}
