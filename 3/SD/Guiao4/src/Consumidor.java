public class Consumidor implements Runnable{

    BoundedBuffer bf;
    Barreira barreira;
    int numOps;

    public Consumidor(BoundedBuffer bf, Barreira barreira, int numOps){
        this.bf = bf;
        this.barreira = barreira;
        this.numOps = numOps;
    }

    @Override
    public void run() {
        int j;
        for(int i = 0; i < numOps; i++){
            try {
                j = bf.get();
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

}
