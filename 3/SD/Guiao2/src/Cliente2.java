public class Cliente2 implements Runnable{

    private Banco banco;

    Cliente2(Banco banco){
        this.banco = banco;
    }

    public void run(){
            try {
                banco.consultar();
                banco.transferir(1,0,1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            //banco.levantar(0, 5);
    }

}
