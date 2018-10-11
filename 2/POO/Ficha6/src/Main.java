public class Main {

    public static void main(String[] args){
        Parque parque = new Parque();
        parque.devolveMatriculas();
        parque.registaLugar("b","b",2,true);
        parque.totalMinutos2();
        //parque.printMatriculas();
        parque.removeLugar("a");
        //parque.printMatriculas();
        //parque.alteraTempo("b", 4);
    }

}
