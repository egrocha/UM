import java.lang.reflect.Array;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MusicasComVideo {


    private String nome;
    private String autor;
    private double duracao;
    private int classificacao;
    private static ArrayList<String> letra;
    private int numeroVezesTocada;
    private LocalDateTime ultimaVez;
    private static ArrayList<Character> video;

    public MusicasComVideo(MusicasComVideo f){
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

    public ArrayList<Character> getVideo(){
        return video;
    }

    /*
    public interface Playable {
        public default void play() {
            System.audio.play(letra);
            System.audio.play(video);
        }
    }
    */

}
