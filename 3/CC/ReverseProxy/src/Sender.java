import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.nio.ByteBuffer;
import java.util.concurrent.TimeUnit;

public class Sender{

    private int ttl;
    private int wait;
    private int porta;
    private String IP;
    private byte[] buffer;

    public Sender(int wait, String buffer){
        this.ttl = 1;
        this.wait = wait;
        //this.porta = 8888;
        this.porta = 8887;
        this.IP = "239.8.8.8";
        //this.IP = "127.0.1.1";
        //this.buffer = hexStringToByteArray(buffer);
    }

    public Sender(){
        this.ttl = 1;
        this.wait = 1;
        this.porta = 8888;
        this.IP = "239.8.8.8";
        //this.buffer = hexStringToByteArray("Pedido");
    }

    public void start() throws IOException, InterruptedException {
        while (true) {
            int time = (int) System.currentTimeMillis() % 1000;
            ByteBuffer b = ByteBuffer.allocate(4);
            b.putInt(time);
            byte[] buffer = b.array();
            MulticastSocket s = new MulticastSocket();
            DatagramPacket packet = new DatagramPacket(buffer,
                    buffer.length, InetAddress.getByName(IP), porta);
            System.out.print("sent " + packet+"\n");
            TimeUnit.SECONDS.sleep(wait);
        }
    }

    private static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                    + Character.digit(s.charAt(i+1), 16));
        }
        return data;
    }
}
