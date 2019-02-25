public class Produtor implements Runnable{

    BoundedBuffer bf;
    Barreira barreira;
    int numOps;

    public Produtor(BoundedBuffer bf, Barreira barreira, int numOps){
        this.bf = bf;
        this.barreira = barreira;
        this.numOps = numOps;
    }

    @Override
    public void run() {
        for(int i = 0; i < numOps; i++){
            bf.put(i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            barreira.esperar();
        }
    }

}
