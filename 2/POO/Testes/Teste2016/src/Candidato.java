public class Candidato {

    private String nome;
    private int idade;

    public String getNome(){
        return nome;
    }

    public int getIdade(){
        return idade;
    }

    public Candidato(Candidato c){

    }

    public Candidato clone(){
        return new Candidato(this);
    }

    public Candidato(){
        nome = "";
        idade = 0;
    }

}
