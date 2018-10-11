import java.util.*;

public class PlayList {

    private String nome;
    private static Map<String, List<Faixa>> musicas;

    public PlayList(String nome) {
        this.nome = nome;
        musicas = new HashMap<>();
    }

    public List<Faixa> getFaixas(String autor) throws AutorInexistenteException{
        ArrayList<Faixa> res = new ArrayList<>();
        if(!musicas.containsKey(autor)) throw new AutorInexistenteException();
        else{
            return new ArrayList<>(musicas.get(autor));
        }
    }

    public double tempoTotal(String autor) throws AutorInexistenteException{
        double total = 0;
        if(!musicas.containsKey(autor)) throw new AutorInexistenteException();
        else{
            for(Faixa f : musicas.get(autor)){
                total += f.getDuracao();
            }
        }
        return total;
    }

    public Map<Integer, List<Faixa>> faixasPorClass(){
        Map<Integer, List<Faixa>> res = new HashMap<>();
        for(int i = 1; i <= 5; i++){
            List<Faixa> aux = new ArrayList<>();
            aux.clear();
            for(List<Faixa> fs : musicas.values()){
                for(Faixa f : fs){
                    if(i == f.getClassificacao()){
                        aux.add(f.clone());
                        res.put(i, aux);
                    }
                }
            }
        }
        return res;
    }


}
