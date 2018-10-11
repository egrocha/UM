public class Lugar {

    private String matricula;
    private String nome;
    private int minutos;
    private boolean permanente;

    public Lugar(){
        this.matricula = "a";
        this.nome = "a";
        this.minutos = 1;
        this.permanente = true;
    }

    public Lugar(String matricula, String nome, int minutos, boolean permamente){
        this.matricula = matricula;
        this.nome = nome;
        this.minutos = minutos;
        this.permanente = permamente;
    }

    public int getMinutos(){
        return this.minutos;
    }

    public void setMinutos(int minutos){
        this.minutos = minutos;
        System.out.print(this.minutos);
    }

}
