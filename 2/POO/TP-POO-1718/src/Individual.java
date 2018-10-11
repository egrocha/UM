/**
 * Classe que define as informações relativas a contribuintes individuais.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */


import java.io.Serializable;
import java.util.*;

public class Individual extends Contribuinte implements Serializable{

    private int numDependentes;
    private float coeficiente;
    private HashMap<String,String> NIFs;
    private HashMap<String,String> ativDeduzir;

    /**
     * Construtor vazio para objetos da classe Individual
     */
    public Individual()
    {
        super();
        this.numDependentes = 0;
        this.coeficiente = 0;
        this.NIFs = new HashMap<>();
        this.ativDeduzir = new HashMap<>();
    }

    /**
     * Construtor para objetos da classe Individual
     * @param i
     */
    public Individual(Individual i){
        super(i.getNIF(), i.getEmail(), i.getNome(), i.getMorada(), i.getPassword());
        this.numDependentes = i.getNumDependentes();
        this.coeficiente = i.getCoeficiente();
        this.NIFs = i.getNIFs();
        this.ativDeduzir = i.getAtivDeduzir();
    }

    /**
     * Construtor para objetos da classe Individual
     * @param NIF
     * @param email
     * @param nome
     * @param morada
     * @param nome
     */
    public Individual(String NIF, String email, String nome, String morada,
                          String password, int numDependentes, float coeficiente,
                          HashMap<String,String> NIFs, HashMap<String,String> ativDeduzir){
        super(NIF, email, nome, morada, password);
        this.numDependentes = numDependentes;
        this.coeficiente = coeficiente;
        this.NIFs = NIFs;
        this.ativDeduzir = ativDeduzir;
    }

    /**
     * getPassword - retorna valor de numDependentes
     *
     * @return numDependentes
     */
    public int getNumDependentes(){
        return this.numDependentes;
    }

    /**
     * getPassword - retorna valor de coeficiente
     *
     * @return coeficiente
     */
    public float getCoeficiente(){
        return this.coeficiente;
    }

    /**
     * getPassword - retorna valor de NIFs
     *
     * @return NIFs
     */
    public HashMap<String, String> getNIFs(){
        return this.NIFs;
    }

    /**
     * getPassword - retorna valor de password
     *
     * @return ativDeduzir
     */
    public HashMap<String, String> getAtivDeduzir(){
        return this.ativDeduzir;
    }

    /**
     * setPassword - atribui novo valor a numDependentes
     *
     * @param numDependentes
     */
    public void setNumDependentes(int numDependentes)
    {
        this.numDependentes = numDependentes;
    }

    /**
     * setPassword - atribui novo valor a coeficiente
     *
     * @param coeficiente
     */
    public void setCoeficiente(float coeficiente)
    {
        this.coeficiente = coeficiente;
    }

    /**
     * setPassword - atribui novo valor a NIFs
     *
     * @param NIFs
     */
    public void setNIFs(HashMap<String,String> NIFs)
    {
        this.NIFs = NIFs;
    }

    /**
     * setPassword - atribui novo valor a ativDeduzir
     *
     * @param ativDeduzir
     */
    public void setAtivDeduzir(HashMap<String,String> ativDeduzir)
    {
        this.ativDeduzir = ativDeduzir;
    }

    /**
     * clone - cria clone da Individual
     *
     * @return contIndividual
     */
    public Individual clone(){
        return new Individual(this);
    }

    /**
     * equals - verifica se objecto o é igual a instância de Individual
     *
     * @param o
     * @return se objectos forem iguais retorna true, senão retorna false
     */
    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass()) return false;
        Individual i = (Individual) o;
        return(super.equals(o) && numDependentes==i.getNumDependentes() &&
                coeficiente==i.getCoeficiente());
    }

    /**
     * toString - criar String com informação sobre Individual
     *
     * @return toString da instância Individual
     */
    public String toString(){
        return super.toString()+" numDependentes:"+ this.numDependentes+
                " coeficiente:"+this.coeficiente+" NIFs:"+this.NIFs+
                " ativDeduzir:"+this.ativDeduzir;
    }

}