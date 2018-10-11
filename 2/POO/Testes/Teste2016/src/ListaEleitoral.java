import sun.reflect.generics.tree.Tree;

import java.util.*;

public class ListaEleitoral {

    private String partidoPolitico;
    private Set<Candidato> eleitos;
    private List<Candidato> porEleger;

    public ListaEleitoral(String partidoPolitico, Collection<Candidato> candidatos){
        this.partidoPolitico = partidoPolitico;
        ArrayList<Candidato> porEleger = new ArrayList<>();
        for(Candidato c : candidatos){
            porEleger.add(c.clone());
        }
        this.porEleger = porEleger;
    }

    public Candidato aEleger(){
        return porEleger.get(0).clone();
    }

    public void elege(){
        if(porEleger.size()>0){
            eleitos.add(porEleger.get(0));
            porEleger.remove(0);
        }
    }

    public void elege(int n){
        for(int i = 0; i < n; i++){
            if(porEleger.size() > 0){
                eleitos.add(porEleger.get(0));
                porEleger.remove(0);
            }
        }
    }

    public Collection<Candidato> candidatos(){
        ArrayList<Candidato> res = new ArrayList<>();
        for(Candidato c : eleitos){
            res.add(c.clone());
        }
        for(Candidato c : porEleger){
            res.add(c.clone());
        }
        return res;
    }

    public TreeSet<Candidato> eleitos(){
        TreeSet<Candidato> res = new TreeSet<>();
        for(Candidato c : eleitos){
            res.add(c.clone());
        }
        return res;
    }

    public TreeSet<Candidato> eleitosNome(){
        TreeSet<Candidato> res = new TreeSet<>(new CandidatoComparator());
        for(Candidato c : eleitos){
            res.add(c.clone());
        }
        return res;
    }

    public TreeSet<Candidato> eleitosIdade(){
        TreeSet<Candidato> res = new TreeSet<>(new CandidatoComparator2());
        for(Candidato c : eleitos){
            res.add(c.clone());
        }
        return res;
    }



}
