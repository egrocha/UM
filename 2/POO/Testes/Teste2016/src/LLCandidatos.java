public class LLCandidatos {

    private Nodo nodoInicial;
    private int tamanho;

    public LLCandidatos(){
        this.nodoInicial = new Nodo();
        this.tamanho = 1;
    }

    public int size(){
        return this.tamanho;
    }

    public void add(Candidato c){
        Nodo actual = nodoInicial;
        while(actual.getNext() != null){
            actual = actual.getNext();
        }
        actual.setNext(new Nodo(c));
    }

    public Nodo getNodoInicial(){
        return this.nodoInicial;
    }

    public Candidato get(int i) throws CandidatoException{
        Nodo actual = nodoInicial;
        if(actual == null) throw new CandidatoException();
        for(int j = 0; j < i; j++){
            if(actual.getNext() == null) throw new CandidatoException();
            else actual = actual.getNext();
        }
        return actual.getCandidato().clone();
    }

    public int getTamanho(){
        return this.tamanho;
    }

    public boolean equals(Object o){
        if(o == this) return false;
        if(o == null || o.getClass() != this.getClass()) return false;
        LLCandidatos l = (LLCandidatos) o;
        return (nodoInicial.equals(l.getNodoInicial()) && tamanho == l.getTamanho());
    }

}
