import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class JogoImpl implements Jogo{

    ArrayList<String> jogadores;
    ReentrantLock lock;
    Condition condition;
    boolean jogoPronto;
    boolean precisoJogador;

    JogoImpl(ArrayList<String> jogadores){
        this.jogadores = jogadores;
        this.lock = new ReentrantLock();
        this.condition = lock.newCondition();
        this.jogoPronto = false;
        this.precisoJogador = false;
    }


    @Override
    public List<String> inscrever(String nome) throws InterruptedException {
        if(jogadores.size() >= 30) return null;
        else{
            lock.lock();
            jogadores.add(nome);
            lock.unlock();
            condition.notifyAll();
            if(jogadores.size() == 30){
                jogoPronto = true;
                lock.notifyAll();
            }
            while(!jogoPronto) {
                lock.wait(60000);
                if(jogadores.size() < 30) startGame();
            }
        }
        return jogadores;
    }

    public void startGame() throws InterruptedException {
        while(!(jogadores.size() > 20 && jogadores.size() % 2 == 0)) {
            condition.await();
        }
        lock.lock();
        jogoPronto = true;
        lock.unlock();
        lock.notifyAll();
        condition.notifyAll();
    }

}
