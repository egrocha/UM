public class Cliente2 implements Runnable{

    private Banco banco;

    Cliente2(Banco banco){
        this.banco = banco;
    }

    public void run(){
        try {
            banco.criarConta(5);
            banco.transferir(0,1,10);
            banco.fecharConta(1);
            banco.consultar(0);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}
