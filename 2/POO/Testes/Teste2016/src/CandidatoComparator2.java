import java.util.Comparator;

public class CandidatoComparator2 implements Comparator<Candidato> {

    public int compare(Candidato c1, Candidato c2){
        if(c1.getIdade() > c2.getIdade()) return 1;
        if(c1.getIdade() < c2.getIdade()) return -1;
        else{
            if(c1.getNome().compareTo(c2.getNome()) > 0) return 1;
            if(c1.getNome().compareTo(c2.getNome()) < 0) return -1;
            if(c1.getNome().compareTo(c2.getNome()) == 0) return 0;
        }
        return 0;
    }

}
