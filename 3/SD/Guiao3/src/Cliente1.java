import java.util.concurrent.locks.ReentrantLock;

public class Cliente1 implements Runnable{

    private Banco banco;

    Cliente1(Banco banco){
        this.banco = banco;
    }

    public void run(){
        try {
            banco.criarConta(0);
            banco.transferir(0,1,5);
            int[] ids = new int[3];
            ids[0] = 0;
            ids[1] = 1;
            ids[2] = 2;
            banco.consultarTotal(ids);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}
