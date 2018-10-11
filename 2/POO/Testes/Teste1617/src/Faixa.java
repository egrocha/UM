import java.time.LocalDateTime;
import java.util.ArrayList;

public class Faixa {

    private String nome;
    private String autor;
    private double duracao;
    private int classificacao;
    private ArrayList<String> letra;
    private int numeroVezesTocada;
    private LocalDateTime ultimaVez;

    public Faixa(Faixa f){
        this.nome = f.getNome();
        this.autor = f.getAutor();
        this.duracao = f.getDuracao();
        this.classificacao = f.getClassificacao();
        this.letra = f.getLetra();
        this.numeroVezesTocada = f.getNumeroVezesTocada();
        this.ultimaVez = f.getUltimaVez();
    }

    public String getNome(){
        return nome;
    }

    public String getAutor(){
        return autor;
    }

    public double getDuracao(){
        return duracao;
    }

    public int getClassificacao(){
        return classificacao;
    }

    public ArrayList<String> getLetra() {
        return letra;
    }

    public int getNumeroVezesTocada(){
        return numeroVezesTocada;
    }

    public LocalDateTime getUltimaVez() {
        return ultimaVez;
    }

    public boolean equals(Object o){
        if(o == this) return true;
        if(o == null) return false;
        Faixa f = (Faixa) o;
        for(int i = 0; i<letra.size(); i++){
            if(!(letra.get(i).equals(f.getLetra().get(i)))) return false;
        }
        if(!(ultimaVez.equals(f.getUltimaVez()))) return false;
        return (nome.equals(f.getNome()) && autor.equals(f.getAutor()) &&
                duracao == f.getDuracao() && classificacao == f.getClassificacao() &&
                numeroVezesTocada == f.getNumeroVezesTocada());
    }

    public int compareTo(Faixa f){
        int n = f.getNumeroVezesTocada();
        if(this.numeroVezesTocada > n) return 1;
        if(this.numeroVezesTocada < n) return -1;
        return 0;
    }

    public int compareToData(Faixa f){
        if(this.ultimaVez.isBefore(f.getUltimaVez())) return -1;
        if(!(this.ultimaVez.isBefore(f.getUltimaVez()))) return 1;
        return 0;
    }

    public Faixa clone(){
        return new Faixa(this);
    }

    /*
    public interface Playable {
        public default void play() {
            System.audio.play(letra);
        }
    }
    */

}
