public class Main {

    public static void main(String[] args) throws InterruptedException {
        int num = 10;
        Barreira barreira = new Barreira(3);
        BoundedBuffer bf = new BoundedBuffer(barreira, num);
        Thread t[] = new Thread[10];

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < 7; i++){
            if(i < 6) {
                Produtor produtor = new Produtor(bf, barreira, 14);
                t[i] = new Thread(new Thread(produtor));
            }
            else{
                Produtor produtor = new Produtor(bf, barreira, 16);
                t[i] = new Thread(new Thread(produtor));
            }
        }
        for(int i = 7; i < 10; i++) {
            if(i < 9) {
                Consumidor consumidor = new Consumidor(bf, barreira, 33);
                t[i] = new Thread(new Thread(consumidor));
            }
            else {
                Consumidor consumidor = new Consumidor(bf, barreira, 34);
                t[i] = new Thread(new Thread(consumidor));
            }
        }
        for(int i = 0; i < 10; i++){
            t[i].start();
        }
        for(int i = 0; i < 10; i++) {
            t[i].join();
        }

        long stopTime = System.currentTimeMillis();
        long elapsedTime = stopTime - startTime;
        System.out.println(elapsedTime);
    }

}
