public class Conta {

    private int valor = 0;

    Conta(){

    }

    public int getValor(){
        return this.valor;
    }

    public void addValor(int valor){
        synchronized (this) {
            this.valor += valor;
        }
    }

    public void remValor(int valor){
        synchronized (this) {
            this.valor -= valor;
        }
    }

}
