public class Estado {

    private String IP;
    private String porta;
    private float RAM;
    private float CPU;
    private float RTT;
    private float bandwidth;

    public Estado(){
        IP = "";
        porta = "";
        RAM = 0;
        CPU = 0;
        RTT = 0;
        bandwidth = 0;
    }

    public Estado(String IP, String porta, float RAM, float CPU, float RTT, float bandwidth){
        this.IP = IP;
        this.porta = porta;
        this.RAM = RAM;
        this.CPU = CPU;
        this.RTT = RTT;
        this.bandwidth = bandwidth;
    }

    public void setIP(String IP) {
        this.IP = IP;
    }

    public void setPorta(String porta){
        this.porta = porta;
    }

    public void setRAM(float RAM){
        this.RAM = RAM;
    }

    public void setCPU(float CPU){
        this.CPU = CPU;
    }

    public void setRTT(float RTT){
        this.RTT = RTT;
    }

    public void setBandwidth(float bandwidth){
        this.bandwidth = bandwidth;
    }

    public String getIP() {
        return IP;
    }

    public String getPorta() {
        return porta;
    }

    public float getRAM() {
        return RAM;
    }

    public float getCPU() {
        return CPU;
    }

    public float getRTT(){
        return RTT;
    }

    public float getBandwidth() {
        return bandwidth;
    }
}
