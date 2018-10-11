/**
 * Classe Main do Trabalho Prático.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */

import java.util.HashMap;

public class Main{

    private HashMap<String, Empresa> empresas;
    private HashMap<String, ContIndividual> individuais;
    private HashMap<String, Despesa> despesas;

    public void main(String[] args){
        this.empresas = new HashMap<>();
        this.individuais = new HashMap<>();
        this.despesas = new HashMap<>();
    }

}