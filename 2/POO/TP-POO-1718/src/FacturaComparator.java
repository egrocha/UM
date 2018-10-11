import java.util.Comparator;

/**
 * Classe Comparator usada para ordenar faturas.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */

public class FacturaComparator implements Comparator<Despesa>{

    /**
     * Método Comparator que compara duas despesas para verificar qual delas tem maior
     * valor. É usado para organizar listas de despesas em ordem decrescente de valor.
     *
     * @param d1
     * @param d2
     * @return int
     */
    @Override
    public int compare(Despesa d1, Despesa d2){
        if(d1.getValor() > d2.getValor()) return -1;
        if(d1.getValor() < d2.getValor()) return 1;
        return 0;
    }

}
