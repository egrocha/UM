public class Main implements Runnable{

    private int print = 1;

    public void run(){

        int i = 4;

        for(int x = 0; x < i; x++){
            System.out.println(print);
            print++;
        }
    }

    public static void main(String[] args) throws InterruptedException{

        int i = 0;
        int numberOfThreads = 4;

        Thread[] threads = new Thread[numberOfThreads];

        for(i = 0; i < numberOfThreads; i++){
            threads[i] = new Thread(new Main());

        }

        for(i = 0; i < numberOfThreads; i++){
            threads[i].start();
        }

        for(i = 0; i < numberOfThreads; i++){
            threads[i].join();
        }

    }

}
