public class Main {

    public static void main(String[] args) throws InterruptedException {

        Banco banco = new Banco();
        Cliente1 cliente1 = new Cliente1(banco);
        Cliente2 cliente2 = new Cliente2(banco);

        Thread thread1 = new Thread(cliente1);
        Thread thread2 = new Thread(cliente2);

        thread1.start();
        thread2.start();

        thread1.join();
        thread2.join();

    }

}