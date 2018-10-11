/**
 * Classe que contem informações relativas às despesas geradas pelo sistema.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */

public class Despesa {

    private String tipo;
    private String data;
    private String NIFEmitente;
    private String NIFCliente;
    private String descricao;
    private String natureza;
    private float valor;

    /**
     * Construtor vazio para objetos da classe Despesa
     */
    public Despesa(){
        this.tipo = "";
        this.data = "";
        this.NIFEmitente = "";
        this.NIFCliente = "";
        this.descricao = "";
        this.natureza = "";
        this.valor = 0;
    }

    /**
     * Construtor com objecto para objetos da classe Despesa
     */
    public Despesa(Despesa d){
        this.tipo = d.getTipo();
        this.data = d.getData();
        this.NIFEmitente = d.getNIFEmitente();
        this.NIFCliente = d.getNIFCliente();
        this.descricao = d.getDescricao();
        this.natureza = d.getNatureza();
        this.valor = d.getValor();
    }

    /**
     * Construtor com argumentos para objetos da classe Despesa
     * @param tipo
     * @param data
     * @param NIFEmitente
     * @param NIFCliente
     * @param descricao
     * @param natureza
     * @param valor
     */
    public Despesa(String tipo, String data, String NIFEmitente, String NIFCliente,
                   String descricao, String natureza, float valor){
        this.tipo = tipo;
        this.data = data;
        this.NIFEmitente = NIFEmitente;
        this.NIFCliente = NIFCliente;
        this.descricao = descricao;
        this.natureza = natureza;
        this.valor = valor;
    }

    /**
     * getTipo - retorna valor de tipo
     *
     * @return tipo
     */
    public String getTipo() {
        return tipo;
    }

    /**
     * getData - retorna valor de data
     *
     * @return data
     */
    public String getData(){
        return data;
    }

    /**
     * getNIFEmitente - retorna valor de NIFEmitente
     *
     * @return NIFEmitente
     */
    public String getNIFEmitente(){
        return NIFEmitente;
    }

    /**
     * getNIFCliente - retorna valor de NIFCliente
     *
     * @return NIFCliente
     */
    public String getNIFCliente(){
        return NIFCliente;
    }

    /**
     * getDescricao - retorna valor de descricao
     *
     * @return descricao
     */
    public String getDescricao(){
        return descricao;
    }

    /**
     * getNatureza - retorna valor de natureza
     *
     * @return natureza
     */
    public String getNatureza(){
        return natureza;
    }

    /**
     * getValor - retorna valor de valor
     *
     * @return valor
     */
    public float getValor(){
        return valor;
    }

    /**
     * setTipo - atribui novo valor a tipo
     *
     * @param tipo
     */
    public void setTipo(String tipo){
        this.tipo = tipo;
    }

    /**
     * setData - atribui novo valor a data
     *
     * @param data
     */
    public void setData(String data){
        this.data = data;
    }

    /**
     * setNIFEmitente - atribui novo valor a NIFEmitente
     *
     * @param NIFEmitente
     */
    public void setNIFEmitente(String NIFEmitente){
        this.NIFEmitente = NIFEmitente;
    }

    /**
     * setNIFCliente - atribui novo valor a NIFCliente
     *
     * @param NIFCliente
     */
    public void setNIFCliente(String NIFCliente){
        this.NIFCliente = NIFCliente;
    }

    /**
     * setDescricao - atribui novo valor a descricao
     *
     * @param descricao
     */
    public void setDescricao(String descricao){
        this.descricao = descricao;
    }

    /**
     * setNatureza - atribui novo valor a natureza
     *
     * @param natureza
     */
    public void setNatureza(String natureza){
        this.natureza = natureza;
    }

    /**
     * setValor - atribui novo valor a valor
     *
     * @param valor
     */
    public void setValor(float valor){
        this.valor = valor;
    }

    /**
     * clone - cria clone da Despesa
     *
     * @return despesa
     */
    public Despesa clone(){
        return new Despesa(this);
    }

    /**
     * equals - verifica se objecto o é igual a instância de Despesa
     *
     * @param o
     * @return se objectos forem iguais retorna true, senão retorna false
     */
    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null || o.getClass() != this.getClass()) return false;
        Despesa d = (Despesa) o;
        return (tipo.equals(d.getTipo()) && data.equals(d.getData()) &&
                NIFEmitente.equals(d.getNIFEmitente()) && NIFCliente.equals(d.getNIFCliente()) &&
                descricao.equals(d.getDescricao()) && natureza.equals(d.getDescricao()) &&
                valor == d.getValor());
    }

    /**
     * toString - criar String com informação sobre Despesa
     *
     * @return toString da instância Despesa
     */
    public String toString(){
        return "tipo:"+tipo+" data:"+data+" NIFEmitente:"+NIFEmitente+" NIFCliente"+NIFCliente+
                " descricao:"+descricao+" natureza:"+natureza+" valor:"+valor;
    }
}
