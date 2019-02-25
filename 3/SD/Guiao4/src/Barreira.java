public class Barreira {

    int max;
    int num;

    public Barreira(int max){
        this.max = max;
        this.num = 0;
    }

    public void esperar(){
        while(num < max){
            try{
                num++;
                wait();
            } catch(InterruptedException e){
                e.printStackTrace();
            }
        }
        notifyAll();
    }

}
