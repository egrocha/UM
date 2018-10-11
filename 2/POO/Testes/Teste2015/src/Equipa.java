import java.util.Map;
import java.util.TreeSet;

public class Equipa {

    private String nome;
    private Map<String, Barco> barcos;

    public Equipa(){

    }

    public Map<String, Barco> getBarcos(){
        return barcos;
    }

    public double totalEmProva(String idBarco){
        double total = 0;
        for(RegistoEtapa r : barcos.get(idBarco).getRegisto()){
            total += r.getFim().getTimeInMillis() - r.getInicio().getTimeInMillis();
        }
        return total;
    }

    public double registoMaisLongo(){
        double maior = 0;
        double aux = 0;
        for(Barco b : barcos.values()){
            aux = b.getRegisto().size();
            if(aux > maior) maior = aux;
        }
        return maior;
    }

    public TreeSet<Barco> barcosComSeguro(){
        TreeSet<Barco> res = new TreeSet<Barco>(new SeguroComparator());
        for(Barco b : barcos.values()){
            if(b instanceof BarcoHibrido || b instanceof BarcoCatamaran){
                res.add(b.clone());
            }
        }
        return res;
    }

}
