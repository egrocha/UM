import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import java.io.ByteArrayInputStream;

class BoundedBuffer {

    private Barreira barreira;
    private int[] values;
    private int poswrite;

    BoundedBuffer(Barreira barreira, int num){
        this.barreira = barreira;
        this.values = new int[num];
        this.poswrite = 0;
    }

    synchronized void put(int v) {
        try{
            while(this.poswrite == this.values.length){
                System.out.println("PUT: buffer cheio");
                this.wait();
                //barreira.esperar();
            }
            System.out.println("PUT: inserção de "+v+" na buffer");
            this.values[poswrite] = v;
            poswrite++;
            notifyAll();
        } catch(InterruptedException e){
            e.printStackTrace();
        }

    }

    synchronized int get() {
        try {
            while (this.poswrite == 0) {
                System.out.println("GET: buffer vazio");
                this.wait();
            }
        } catch(InterruptedException e){
            e.printStackTrace();
        }
        int posread = --this.poswrite;
        int res = values[posread];
        this.notifyAll();
        System.out.println("Get - " + res);
        return res;
    }

}
