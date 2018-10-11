import java.util.*;

public class Parque {

    private HashMap<String,Lugar> parque;

    public Parque(){
        this.parque = new HashMap<>();
        Lugar lugar = new Lugar();
        parque.put("a",lugar);
    }

    public void printMatriculas(){
        System.out.print(parque.keySet()+"\n");
    }

    public Set<String> devolveMatriculas(){
        return parque.keySet();
    }

    public void registaLugar(String matricula, String nome,
                             int minutos, boolean permanente){
        Lugar lugar = new Lugar(matricula, nome, minutos, permanente);
        parque.put(matricula,lugar);
    }

    public void removeLugar(String matricula){
        if(parque.containsKey(matricula)){
            parque.remove(matricula);
        }
    }

    public void alteraTempo(String matricula, int minutos){
        if(parque.containsKey(matricula)){
            parque.get(matricula).setMinutos(minutos);
        }
    }

    public int totalMinutos1(){
        int total = 0;
        Collection<Lugar> lugares = parque.values();
        for(Lugar l : lugares){
            total += l.getMinutos();
        }
        System.out.print(total);
        return total;
    }

    public int totalMinutos2(){
        int total = 0;
        ArrayList<Lugar> lugares = new ArrayList<Lugar>(parque.values());
        for(int i = 0; i < lugares.size(); i++){
            total += lugares.get(i).getMinutos();
        }
        System.out.print(total);
        return total;
    }
}
