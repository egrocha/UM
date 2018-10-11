/**
 * Classe que define as informações relativas a empresas.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */

import java.util.*;

public class Empresa {

    private String NIF;
    private String email;
    private String nome;
    private String morada;
    private String password;
    private HashMap<String,String> ativRealiza;
    private float factor;

    /**
     * Construtor vazio para objetos da classe Empresa
     */
    public Empresa(){
        this.NIF = "";
        this.email = "";
        this.nome = "";
        this.morada = "";
        this.password = "";
        this.ativRealiza = new HashMap<>();
        this.factor = 0;
    }

    /**
     * Construtor para objetos da classe Empresa
     * @param e
     */
    public Empresa(Empresa e){
        this.NIF = e.NIF;
        this.email = e.email;
        this.nome = e.nome;
        this.morada = e.morada;
        this.password = e.password;
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
    public Empresa(String NIF, String email, String nome, String morada,
                   String password, HashMap<String,String> ativRealiza, float factor){
        this.NIF = NIF;
        this.email = email;
        this.nome = nome;
        this.morada = morada;
        this.password = password;
        this.ativRealiza = ativRealiza;
        this.factor = factor;
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
        return(NIF.equals(e.getNIF()) && email.equals(e.getEmail()) &&
                nome.equals(e.getNome()) && morada.equals(e.getMorada()) &&
                password.equals(e.getPassword()) && e.getFactor() == factor);
    }

    /**
     * toString - criar String com informação sobre Empresa
     *
     * @return toString da instância Empresa
     */
    public String toString(){
        return "NIF:"+this.NIF+" nome:"+this.nome+" email:"+this.email+
                " morada:"+this.morada+" password:"+this.password+" ativRealiza:"+
                this.ativRealiza+" factor:"+this.factor;
    }
}