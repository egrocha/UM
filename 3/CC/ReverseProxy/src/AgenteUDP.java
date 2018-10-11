import com.sun.management.OperatingSystemMXBean;

import java.io.*;
import java.lang.management.ManagementFactory;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;

public class AgenteUDP {

    int time, timeInc;

    public AgenteUDP(){
        //String cominginText = "";
        while (true) {
            getIP();
            try {
                //InetAddress host = InetAddress.getLocalHost();
                //Socket socket = new Socket("239.8.8.8", 8888);
                ServerSocket serverSocket = new ServerSocket(8887);
                Socket socket = serverSocket.accept();
                BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                timeInc = Integer.parseInt(in.readLine());
                time = (int) System.currentTimeMillis() % 1000;
                //System.out.print(cominginText);
                Estado estado = prepEstado();
                sendEstado(estado);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private Estado prepEstado(){
        String IP = getIP();
        String porta = "8888";
        float RAM = getRAM();
        float CPU = getCPU();
        float RTT = time - timeInc;
        float bandwidth = 0f;
        Estado estado = new Estado(IP, porta, RAM, CPU, RTT, bandwidth);
        return estado;
    }

    private void sendEstado(Estado estado){
        try{
            ObjectOutputStream os;
            Socket socket = new Socket("128.0.0.0", 8888);
            os = new ObjectOutputStream(new BufferedOutputStream(socket.getOutputStream()));
            os.writeObject(estado);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String getIP(){
        String IP = "";
        try {
            InetAddress ip = InetAddress.getLocalHost();
            IP = ip.toString();
            System.out.print(IP);
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return IP;
    }

    private float getRAM(){
        com.sun.management.OperatingSystemMXBean mxbean =
                (com.sun.management.OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
        return (float) mxbean.getTotalPhysicalMemorySize();
    }

    private float getCPU(){
        OperatingSystemMXBean osBean = ManagementFactory.getPlatformMXBean(
                OperatingSystemMXBean.class);
        return (float) osBean.getSystemCpuLoad();
    }
}
