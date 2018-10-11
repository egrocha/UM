public class Hotel {

    String codigo;
    String nome;
    String localidade;
    String categoria;
    int num;
    float preco;

    public Hotel(){
        codigo = "";
        nome = "";
        localidade = "";
        categoria = "";
        num = 0;
        preco = 0f;
    }

    public Hotel(String codigo, String nome, String localidade, String categoria,
                 int num, float preco){
        this.codigo = codigo;
        this.nome = nome;
        this.localidade = localidade;
        this.categoria = categoria;
        this.num = num;
        this.preco = preco;
    }

    public Hotel(Hotel h){
        this.codigo = h.getCodigo();
        this.nome = h.getNome();
        this.localidade = h.getLocalidade();
        this.categoria = h.getCategoria();
        this.num = h.getNum();
        this.preco = h.getPreco();
    }

    private String getNome(){
        return this.nome;
    }

    private String getCategoria(){
        return this.categoria;
    }

    private float getPreco(){
        return this.preco;
    }

    public String getCodigo(){
        return this.codigo;
    }

    public int getNum(){
        return this.num;
    }

    public String getLocalidade(){
        return this.localidade;
    }

    public Hotel clone(){
        return new Hotel(this);
    }

}
