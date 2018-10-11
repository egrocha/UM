import java.util.List;
import java.util.Set;

public class BarcoCatamaran extends Barco {

    private double seguro;

    public double getSeguro(){
        return seguro;
    }

    public BarcoCatamaran(String id, double milhas, String categoria, double autonomia, Pessoa skipper, Set<Pessoa> tripulantes, List<RegistoEtapa> registo) {
        super(id, milhas, categoria, autonomia, skipper, tripulantes, registo);
    }
}
