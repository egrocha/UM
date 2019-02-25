import java.util.HashMap;
import java.util.concurrent.locks.ReentrantLock;

public class Banco {

    private ReentrantLock lock = new ReentrantLock();
    private final HashMap<Integer, Conta> contas;

    Banco(){
        contas = new HashMap<>();
        Conta conta1 = new Conta(0,0);
        contas.put(0, conta1);
        Conta conta2 = new Conta(1,5);
        contas.put(1,conta2);
        /*contas = new ArrayList<>();
        for(int i = 0; i < numContas; i++) {
            Conta conta = new Conta();
            contas.add(conta);
        }
        contas.get(0).addValor(1000);*/
    }

    public synchronized void consultar(int id){
        System.out.println("Conta "+id+": "+contas.get(id).getValor());
    }

    private void depositar(int conta, int valor){
        contas.get(conta).addValor(valor);
    }

    private void levantar(int conta, int valor){
        contas.get(conta).remValor(valor);
    }

    public void transferir(int contaLev, int contaDep, int valor) throws InterruptedException {
        contas.get(contaLev).lock();
        contas.get(contaDep).lock();
        depositar(contaDep, valor);
        levantar(contaLev, valor);
        contas.get(contaDep).unlock();
        contas.get(contaLev).unlock();
    }

    public int criarConta(double saldoInicial){
        this.lock.lock();
        int id = contas.size();
        Conta conta = new Conta(id, saldoInicial);
        contas.put(id, conta);
        this.lock.unlock();
        return id;
    }

    public void fecharConta(int id){
        this.lock.lock();
        if(contas.containsKey(id)) {
            consultar(id);
            contas.remove(id);
        }
        this.lock.unlock();
    }

    public void consultarTotal(int ids[]){
        this.lock.lock();
        for (int id : ids) {
            consultar(id);
        }
        this.lock.unlock();
    }

}
