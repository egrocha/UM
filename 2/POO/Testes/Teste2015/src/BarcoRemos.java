import java.util.List;
import java.util.Set;

public class BarcoRemos extends Barco{


    public BarcoRemos(String id, double milhas, String categoria, double autonomia, Pessoa skipper, Set<Pessoa> tripulantes, List<RegistoEtapa> registo) {
        super(id, milhas, categoria, autonomia, skipper, tripulantes, registo);
    }
}
