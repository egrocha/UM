import java.util.concurrent.locks.ReentrantLock;

public class Cliente1 implements Runnable{

    private Banco banco;

    Cliente1(Banco banco){
        this.banco = banco;
    }

    public void run(){
        /*
        for(int i = 0; i < 1000; i++) {
            banco.consultar();
            banco.transferir(0, 1, 1);
            //banco.depositar(0, 5);
        }
        banco.consultar();
        */
        try {
            banco.consultar();
            banco.transferir(0,1,1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try {
            banco.consultar();
            banco.transferir(0,1,1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}
