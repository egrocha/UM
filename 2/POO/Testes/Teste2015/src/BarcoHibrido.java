import sun.reflect.generics.visitor.Reifier;

import java.util.List;
import java.util.Set;

public class BarcoHibrido extends Barco{

    private double capacidadeB;
    private double potenciaE;
    private double autonomiaE;
    private double seguro;

    public double getSeguro(){
        return seguro;
    }

    public double getCapacidadeB() {
        return capacidadeB;
    }

    public double getPotenciaE() {
        return potenciaE;
    }

    public double getAutonomiaE() {
        return getAutonomia();
    }

    public BarcoHibrido(String id, double milhas, String categoria, double autonomia,
                        Pessoa skipper, Set<Pessoa> tripulantes,
                        List<RegistoEtapa> registo, double capacidadeB, double potenciaE,
                        double autonomiaE){
        super(id, milhas, categoria, autonomia, skipper, tripulantes, registo);
        this.capacidadeB = capacidadeB;
        this.potenciaE = potenciaE;
        this.autonomiaE = autonomiaE;
    }

    public String toString(){
        return super.toString() +
                "CapacidadeB: " + this.getCapacidadeB() +
                "PotenciaE: " + this.getPotenciaE() +
                "AutonomiaE: " + this.getAutonomiaE();
    }

    public double getAutonomia(){
        double total = 0;
        total += getAutonomiaE();
        total += super.getAutonomia();
        return total;
    }

    public BarcoHibrido(BarcoHibrido b) {
        super(b);
    }
}
