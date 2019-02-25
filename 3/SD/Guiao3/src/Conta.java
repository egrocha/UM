import java.util.concurrent.locks.ReentrantLock;

public class Conta {

    private ReentrantLock lock = new ReentrantLock();
    private double valor = 0;
    private int id = 0;

    Conta(int id, double valorInicial){
        this.id = id;
        this.valor = valorInicial;
    }

    public double getValor(){
        return this.valor;
    }

    public void addValor(double valor){
        lock.lock();
        this.valor += valor;
        lock.unlock();
    }

    public void remValor(int valor){
        lock.lock();
        this.valor -= valor;
        lock.unlock();
    }

    public void lock(){
        this.lock.lock();
    }

    public void unlock(){
        this.lock.unlock();
    }

}
