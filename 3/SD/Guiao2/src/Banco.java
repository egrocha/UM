import java.util.concurrent.locks.ReentrantLock;

public class Banco {

    private ReentrantLock lock = new ReentrantLock();
    private Conta contas[];

    Banco(int numContas){
        contas = new Conta[numContas];
        for(int i = 0; i < numContas; i++) {
            contas[i] = new Conta();
        }
        contas[0].addValor(1000);
    }

    public synchronized void consultar(){
        System.out.println("Conta "+0+": "+contas[0].getValor());
        System.out.println("Conta "+1+": "+contas[1].getValor());
    }

    private void depositar(int conta, int valor){
        contas[conta].addValor(valor);
    }

    private void levantar(int conta, int valor){
        contas[conta].remValor(valor);
    }

    public void transferir(int contaLev, int contaDep, int valor) throws InterruptedException {
        contas[contaLev].lock();
        contas[contaDep].lock();
        depositar(contaDep, valor);
        levantar(contaLev, valor);
        contas[contaDep].unlock();
        contas[contaLev].unlock();
    }

}
