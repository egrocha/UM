import java.util.List;
import java.util.Set;

public class Barco {

    private String id;
    private double milhas;
    private String categoria;
    private double autonomia;
    private Pessoa skipper;
    private Set<Pessoa> tripulantes;
    private List<RegistoEtapa> registo;

    public Barco(String id, double milhas, String categoria, double autonomia,
                 Pessoa skipper, Set<Pessoa> tripulantes, List<RegistoEtapa> registo){
        this.id = id;
        this.milhas = milhas;
        this.categoria = categoria;
        this.autonomia = autonomia;
        this.skipper = skipper;
        this.tripulantes = tripulantes;
        this.registo = registo;
    }

    public Barco(Barco b){
        this.id = b.getId();
        this.milhas = b.getMilhas();
        this.categoria = b.getCategoria();
        this.autonomia = b.getAutonomia();
        this.skipper = b.getSkipper();
        this.tripulantes = b.getTripulantes();
    }

    public String getCategoria() {
        return categoria;
    }

    public String getId() {
        return id;
    }

    public double getAutonomia() {
        return autonomia;
    }

    public double getMilhas() {
        return milhas;
    }

    public Pessoa getSkipper() {
        return skipper;
    }

    public Set<Pessoa> getTripulantes() {
        return tripulantes;
    }

    public List<RegistoEtapa> getRegisto() {
        return registo;
    }

    public Barco clone(){
        return new Barco(this);
    }

}
