/**
 * Classe que define as informações relativas a contribuintes individuais.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */


import java.util.*;

public class ContIndividual{

    private String NIF;
    private String email;
    private String nome;
    private String morada;
    private String password;
    private int numDependentes;
    private float coeficiente;
    private HashMap<String,String> NIFs;
    private HashMap<String,String> ativDeduzir;

    /**
     * Construtor vazio para objetos da classe ContIndividual
     */
    public ContIndividual()
    {
        this.NIF = "";
        this.email = "";
        this.nome = "";
        this.morada = "";
        this.password = "";
        this.numDependentes = 0;
        this.coeficiente = 0;
        this.NIFs = new HashMap<>();
        this.ativDeduzir = new HashMap<>();
    }

    /**
     * Construtor para objetos da classe ContIndividual
     * @param c
     */
    public ContIndividual(ContIndividual c){
        this.NIF = c.getNIF();
        this.email = c.getEmail();
        this.nome = c.getNome();
        this.morada = c.getMorada();
        this.password = c.getPassword();
        this.numDependentes = c.getNumDependentes();
        this.coeficiente = c.getCoeficiente();
        this.NIFs = c.getNIFs();
        this.ativDeduzir = c.getAtivDeduzir();
    }

    /**
     * Construtor para objetos da classe ContIndividual
     * @param NIF
     * @param email
     * @param nome
     * @param morada
     * @param nome
     */
    public ContIndividual(String NIF, String email, String nome, String morada,
                          String password, int numDependentes, float coeficiente,
                          HashMap<String,String> NIFs, HashMap<String,String> ativDeduzir){
        this.NIF = NIF;
        this.email = email;
        this.nome = nome;
        this.morada = morada;
        this.password = password;
        this.numDependentes = numDependentes;
        this.coeficiente = coeficiente;
        this.NIFs = NIFs;
        this.ativDeduzir = ativDeduzir;
    }

    /**
     * getNIF - retorna valor de NIF
     *
     * @return NIF
     */
    public String getNIF(){
        return this.NIF;
    }

    /**
     * getEmail - retorna valor de email
     *
     * @return email
     */
    public String getEmail(){
        return this.email;
    }

    /**
     * getNome - retorna valor de nome
     *
     * @return nome
     */
    public String getNome(){
        return this.nome;
    }

    /**
     * getMorada - retorna valor de morada
     *
     * @return morada
     */
    public String getMorada(){
        return this.morada;
    }

    /**
     * getPassword - retorna valor de password
     *
     * @return password
     */
    public String getPassword(){
        return this.password;
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
    public HashMap<String,String> getAtivDeduzir(){
        return this.ativDeduzir;
    }

    /**
     * setNIF - atribui novo valor a NIF
     *
     * @param NIF
     */
    public void setNIF(String NIF)
    {
        this.NIF = NIF;
    }

    /**
     * setEmail - atribui novo valor a email
     *
     * @param email
     */
    public void setEmail(String email)
    {
        this.email = email;
    }

    /**
     * setNome - atribui novo valor a nome
     *
     * @param nome
     */
    public void setNome(String nome)
    {
        this.nome = nome;
    }

    /**
     * setMorada - atribui novo valor a morada
     *
     * @param morada
     */
    public void setMorada(String morada)
    {
        this.morada = morada;
    }

    /**
     * setPassword - atribui novo valor a password
     *
     * @param password
     */
    public void setPassword(String password)
    {
        this.password = password;
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
     * clone - cria clone da ContIndividual
     *
     * @return contIndividual
     */
    public ContIndividual clone(){
        return new ContIndividual(this);
    }

    /**
     * equals - verifica se objecto o é igual a instância de ContIndividual
     *
     * @param o
     * @return se objectos forem iguais retorna true, senão retorna false
     */
    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass()) return false;
        ContIndividual e = (ContIndividual) o;
        return(NIF.equals(e.getNIF()) && email.equals(e.getEmail()) &&
                nome.equals(e.getNome()) && morada.equals(e.getMorada()) &&
                password.equals(e.getPassword()) && numDependentes==e.getNumDependentes() &&
                coeficiente==e.getCoeficiente());
    }

    /**
     * toString - criar String com informação sobre ContIndividual
     *
     * @return toString da instância ContIndividual
     */
    public String toString(){
        return "NIF:"+this.NIF+" nome:"+this.nome+" email:"+this.email+
                " morada:"+this.morada+" password:"+this.password+" numDependentes:"+
                this.numDependentes+" coeficiente:"+this.coeficiente+" NIFs:"+this.NIFs+
                " ativDeduzir:"+this.ativDeduzir;
    }
}