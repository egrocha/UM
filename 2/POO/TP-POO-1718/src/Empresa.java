import java.io.Serializable;
import java.util.*;

/**
 * Classe que define as informações relativas a empresas.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */


public class Empresa extends Contribuinte implements Serializable{

    private HashMap<String,String> ativRealiza;
    private float factor;

    /**
     * Construtor vazio para objetos da classe Empresa
     */
    public Empresa(){
        super();
        this.ativRealiza = new HashMap<>();
        this.factor = 0;
    }

    /**
     * Construtor para objetos da classe Empresa
     * @param e
     */
    public Empresa(Empresa e){
        super(e.getNIF(), e.getEmail(), e.getNome(), e.getMorada(), e.getPassword());
        this.ativRealiza = e.getAtividades();
        this.factor = e.getFactor();
    }

    /**
     * Construtor com argumentos para objetos da classe Empresa
     * @param NIF
     * @param email
     * @param nome
     * @param morada
     * @param password
     * @param ativRealiza
     * @param factor
     */
    Empresa(String NIF, String email, String nome, String morada,
            String password, HashMap<String, String> ativRealiza, float factor){
        super(NIF, email, nome, morada, password);
        this.ativRealiza = ativRealiza;
        this.factor = factor;
    }

    /**
     * getPassword - retorna valor de password
     *
     * @return ativRealiza
     */
    public HashMap<String,String> getAtividades(){
        return this.ativRealiza;
    }

    /**
     * getPassword - retorna valor de factor
     *
     * @return factor
     */
    public float getFactor(){
        return this.factor;
    }

    /**
     * setPassword - atribui novo valor a ativRealiza
     *
     * @param ativRealiza
     */
    public void setAtivRealiza(HashMap<String,String> ativRealiza)
    {
        this.ativRealiza = ativRealiza;
    }

    /**
     * setPassword - atribui novo valor a factor
     *
     * @param factor
     */
    public void setFactor(Float factor)
    {
        this.factor = factor;
    }

    /**
     * clone - cria clone da Empresa
     *
     * @return empresa
     */
    public Empresa clone(){
        return new Empresa(this);
    }

    /**
     * equals - verifica se objecto o é igual a instância de Empresa
     *
     * @param o
     * @return se objectos forem iguais retorna true, senão retorna false
     */
    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass()) return false;
        Empresa e = (Empresa) o;
        return(super.equals(e) && e.getFactor() == factor && ativRealiza.equals((e.getAtividades())));
    }

    /**
     * toString - criar String com informação sobre Empresa
     *
     * @return toString da instância Empresa
     */
    public String toString(){
        return super.toString()+" ativRealiza:"+
                this.ativRealiza+" factor:"+this.factor;
    }
}