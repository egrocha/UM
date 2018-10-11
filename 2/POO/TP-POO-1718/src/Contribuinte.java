import java.io.Serializable;

/**
 * Classe que define as informações comuns a todos os tipos de contribuintes.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */

public class Contribuinte implements Serializable {

    private String NIF;
    private String email;
    private String nome;
    private String morada;
    private String password;

    /**
     * Construtor vazio para a classe Contribuinte
     */
    public Contribuinte(){
        this.NIF = "";
        this.email = "";
        this.nome = "";
        this.morada = "";
        this.password = "";
    }

    /**
     * Construtor com objeto para a classe Contribuinte
     */
    public Contribuinte(Contribuinte c){
        this.NIF = c.getNIF();
        this.email = c.getEmail();
        this.nome = c.getNome();
        this.morada = c.getMorada();
        this.password = c.getPassword();
    }

    /**
     * Construtor com argumentos para a classe Contribuinte
     */
    public Contribuinte(String NIF, String email, String nome, String morada, String password){
        this.NIF = NIF;
        this.email = email;
        this.nome = nome;
        this.morada = morada;
        this.password = password;
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
     * clone - cria clone da Contribuinte
     *
     * @return contribuinte
     */
    public Contribuinte clone(){
        return new Contribuinte(this);
    }

    /**
     * equals - verifica se objecto o é igual a instância de Contribuinte
     *
     * @param o
     * @return se objectos forem iguais retorna true, senão retorna false
     */
    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || this.getClass() != o.getClass()) return false;
        Contribuinte c = (Contribuinte) o;
        return(NIF.equals(c.getNIF()) && email.equals(c.getEmail()) &&
                nome.equals(c.getNome()) && morada.equals(c.getMorada()) &&
                password.equals(c.getPassword()));
    }

    /**
     * toString - cria String com informação sobre Contribuinte
     *
     * @return toString da instância Contribuinte
     */
    public String toString(){
        return "NIF:"+this.NIF+" nome:"+this.nome+" email:"+this.email+
                " morada:"+this.morada+" password:"+this.password;
    }
}
