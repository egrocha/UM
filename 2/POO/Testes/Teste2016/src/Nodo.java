public class Nodo {

    private Candidato candidato;
    private Nodo next;

    public Nodo(){
        candidato = new Candidato();
        next = null;
    }

    public Nodo(Candidato c){
        this.candidato = c;
        this.next = null;
    }

    public Nodo getNext(){
        return next;
    }

    public Candidato getCandidato() {
        return candidato;
    }

    public void setNext(Nodo n){
        this.next = n;
    }

    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || o.getClass() == this.getClass()) return false;
        Nodo n = (Nodo) o;
        return candidato.equals(n.getCandidato()) && next.equals(n.getNext());
    }

}
