import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Scanner;

/**
 * Classe que realiza diversos processos internos de negócios do sistema
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */
public class Processamento {

    private HashMap<String, Empresa> empresas;
    private HashMap<String, Individual> individuais;
    private HashMap<String, HashMap<Integer, Despesa>> despesas;

    /**
     * Construtor vazio para a classe Processamento
     */
    Processamento(){
        empresas = new HashMap<>();
        individuais = new HashMap<>();
        despesas = new HashMap<>();
        gerador();
        save();
        load();
    }

    /**
     * Método que permite as Empresas fazer login no sistema
     *
     * @param NIF
     * @param password
     * @return boolean
     */
    public boolean loginEmpresa(String NIF, String password) {
        return empresas.containsKey(NIF) && (empresas.get(NIF).getPassword().equals(password));
    }

    /**
     * Método que permite os contribuintes individuais fazer login no sistema
     *
     * @param NIF
     * @param password
     * @return boolean
     */
    public boolean loginIndividual(String NIF, String password){
        return individuais.containsKey(NIF) && (individuais.get(NIF).getPassword().equals(password));
    }

    /**
     * Método que permite registar novas empresas no sistema
     *
     * @return NIF
     */
    public String registarEmpresa(){
        Scanner scanner = new Scanner(System.in);
        System.out.print("NIF:");
        String NIF;
        while(true) {
            NIF = scanner.nextLine();
            if(!empresas.containsKey(NIF)) break;
            else{
                System.out.print("NIF inválido\nNIF:");
            }
        }
        System.out.print("Email:");
        String email = scanner.nextLine();
        System.out.print("Nome:");
        String nome = scanner.nextLine();
        System.out.print("Morada:");
        String morada = scanner.nextLine();
        System.out.print("Password:");
        String password = scanner.nextLine();
        System.out.print("Atividades que realiza ('Fim' para acabar):\n");
        HashMap<String, String> ativRealiza = new HashMap<>();
        while(true){
            String atividade = scanner.nextLine();
            if(atividade.equals("Fim")) break;
            else ativRealiza.put(atividade, atividade);
        }
        System.out.print("Factor:");
        float factor = scanner.nextFloat();
        empresas.put(NIF, new Empresa(NIF, email, nome, morada, password, ativRealiza, factor));
        return NIF;
    }

    /**
     * Método que permite registar novos contribuintes individuais no sistema
     *
     * @return NIF
     */
    public String registarIndividual(){
        Scanner scanner = new Scanner(System.in);
        System.out.print("NIF:");
        String NIF;
        while(true) {
            NIF = scanner.nextLine();
            if(!individuais.containsKey(NIF)) break;
            else{
                System.out.print("NIF inválido\nNIF:");
            }
        }
        System.out.print("Email:");
        String email = scanner.nextLine();
        System.out.print("Nome:");
        String nome = scanner.nextLine();
        System.out.print("Morada:");
        String morada = scanner.nextLine();
        System.out.print("Password:");
        String password = scanner.nextLine();
        System.out.print("Número de Dependentes:");
        int numDependentes = scanner.nextInt();
        float factor = 0f;
        HashMap<String, String> NIFs = new HashMap<>();
        System.out.print("NIFs de habitantes da residência ('Fim' para acabar):");
        while(true){
            String NIFhab = scanner.nextLine();
            if(NIFhab.equals("Fim")) break;
            else NIFs.put(NIFhab, NIFhab);
        }
        HashMap<String, String> ativDeduzir = new HashMap<>();
        System.out.print("Atividades a deduzir ('Fim' para acabar):");
        while(true){
            String atividade = scanner.nextLine();
            if(atividade.equals("Fim")) break;
            else NIFs.put(atividade, atividade);
        }
        individuais.put(NIF, new Individual(NIF, email, nome, morada, password,
                                               numDependentes, factor, NIFs, ativDeduzir));
        return NIF;
    }

    /**
     * Método que permite gerar novas despesas, por parte das empresas
     * @return despesa
     */
    public void gerarDespesa(String NIF){
        Scanner scanner = new Scanner(System.in);
        System.out.print("Tipo de factura:");
        String tipo = scanner.nextLine();
        Date data = new Date();
        System.out.print("NIF do emitente:");
        String NIFemitente = scanner.nextLine();
        System.out.print("NIF do Cliente:");
        String NIFcliente = scanner.nextLine();
        System.out.print("Descrição:");
        String descricao = scanner.nextLine();
        System.out.print("Natureza:");
        String natureza = scanner.nextLine();
        System.out.print("Valor:");
        float valor = scanner.nextFloat();
        int size = despesas.get(NIF).size();
        Despesa despesa = new Despesa(size, tipo, data, NIFemitente,
                NIFcliente, descricao, natureza, valor);
        if(despesas.containsKey(NIF)) despesas.get(NIF).put(size, despesa);
        else{
            HashMap<Integer, Despesa> novo = new HashMap<>();
            novo.put(size, despesa);
            despesas.put(NIF, novo);
        }
    }

    /**
     * Método que permite os contribuintes individuais ver quantas despesas foram emitidas em seu nome
     * @param NIF
     */
    public void verificarDespesas(String NIF){
        HashMap<String, String> NIFs = individuais.get(NIF).getNIFs();
        int cont = 0;
        int montante = 0;
        for(HashMap<Integer, Despesa> hm : despesas.values()){
            for(Despesa d : hm.values())     {
                if (d.getNIFCliente().equals(NIF)) {
                    cont++;
                    montante += d.getValor();
                    System.out.print("Despesa emitida em:" + d.getData() + "\nPor:" + d.getNIFEmitente() + "\n");
                }
                for (String n : NIFs.values()) {
                    if (d.getNIFCliente().equals(n)) {
                        cont++;
                        montante += d.getValor();
                        System.out.print("Despesa emitida em:" + d.getData() + "\nPor:" + d.getNIFEmitente() +
                                "\nPara:" + d.getNIFCliente() + "\n");
                    }
                }
            }
        }
        if(cont == 0) System.out.print("Não tem despesas emitidas em seu nome.\n");
        else System.out.print("Montante acumulado:"+montante+"\n");
    }

    /**
     * Método que permite alterar às empresas alterar as naturezas atribuidas às suas despesas
     *
     * @param NIF
     */
    public void alterarClassificacao(String NIF){
        int cont = 0;
        HashMap<Integer, Despesa> despesasAux = this.despesas.get(NIF);
        if(despesasAux.size() > 0) System.out.print("Escolha uma factura\n");
        else System.out.print("A sua empresa não tem facturas associadas\n");
        for(Despesa d : despesasAux.values()){
            System.out.print(cont+": Cliente:"+d.getNIFCliente()+", Data:"+d.getData()+
                             ", Valor:"+d.getValor()+", Classificação:"+d.getNatureza());
            System.out.print("\n");
            cont++;
        }
        Scanner scanner = new Scanner(System.in);
        int opcao;
        opcao = getOpcaoDespesas(despesasAux.size());
        System.out.print("Nova classificação:");
        String classificacao = scanner.nextLine();
        String naturezaAux = despesasAux.get(opcao).getNatureza();
        despesasAux.get(opcao).getClassificacoes().add(naturezaAux);
        despesasAux.get(opcao).setNatureza(classificacao);
        despesasAux.put(despesasAux.get(opcao).getID(), despesasAux.get(opcao));
    }

    /**
     * Método que permite rastrear as mudanças feitas por uma empresa às naturezas das suas
     * despesas
     *
     * @param NIF
     */
    public void rastreioClassificacoes(String NIF){
        HashMap<Integer, Despesa> despesasAux = this.despesas.get(NIF);
        int opcao;
        int cont = 0;
        for(Despesa d : despesasAux.values()){
            System.out.print(cont+": Cliente:"+d.getNIFCliente()+", Data:"+d.getData()+
                             ", Valor:"+d.getValor()+", Classificação:"+d.getNatureza()+"\n");
            cont++;
        }
        opcao = getOpcaoDespesas(despesasAux.size());
        for(String s : despesasAux.get(opcao).getClassificacoes()){
            System.out.print(s+"\n");
        }
    }

    /**
     * Método auxiliar usado para obter uma opção entre do utilizador
     * após previamente ter imprimido uma lista de despesas
     *
     * @param size
     */
    public int getOpcaoDespesas(int size){
        Scanner scanner = new Scanner(System.in);
        int opcao;
        while(true) {
            System.out.print("Opção:");
            opcao = scanner.nextInt();
            scanner.nextLine();
            if (opcao >= 0 && opcao < size) break;
            else System.out.print("Opção inválida\n");
        }
        return opcao;
    }

    /**
     * Método que lista a 10 facturas, emitidas por uma empresa, com maiores valores
     *
     * @param NIF
     */
    public void listagemFacturas10(String NIF){
        HashMap<Integer, Despesa> despesas = this.despesas.get(NIF);
        ArrayList<Despesa> despesasAux = new ArrayList<>();
        for(Despesa d : despesas.values()){
            if(d.getNIFEmitente().equals(NIF)){
                despesasAux.add(d.clone());
            }
        }
        despesasAux.sort(new FacturaComparator());
        for(int i = 0; i < 10 && i < despesasAux.size(); i++) {
            System.out.print((i+1)+": Valor:"+despesasAux.get(i).getValor()+
                             " Cliente:"+despesasAux.get(i).getNIFCliente()+
                             " Data:"+despesasAux.get(i).getData()+"\n");
        }
    }

    /**
     * Método que lista facturas emitidas para um cliente por uma certa empresa,
     * entre duas datas fornecida pelo utilizador
     *
     * @param NIF
     */
    public void listagemFacturasDatas(String NIF) {
        HashMap<Integer, Despesa> despesas = this.despesas.get(NIF);
        Scanner scanner = new Scanner(System.in);
        System.out.print("NIF do cliente:");
        String NIFCliente = scanner.nextLine();
        Date[] data = scannerData();
        for(Despesa d : despesas.values()){
            if(!d.getData().before(data[0]) && !d.getData().after(data[1]) &&
               NIFCliente.equals(d.getNIFCliente())){
                System.out.print("Cliente: "+d.getNIFCliente()+" Valor: "+d.getValor()+
                                 " Data: "+d.getData()+"\n");
            }
        }
    }

    /**
     * Método que lista todas as faturas emitidas para um cliente por uma certa empresa,
     * ordenada pelo seu valor, em ordem decrescente
     *
     * @param NIF
     */
    public void listagemFacturasContribuinte(String NIF){
        HashMap<Integer, Despesa> despesas = this.despesas.get(NIF);
        ArrayList<Despesa> despesasAux = new ArrayList<>();
        Scanner scanner = new Scanner(System.in);
        System.out.print("NIF do cliente:");
        String NIFCliente = scanner.nextLine();
        for(Despesa d : despesas.values()){
            if(d.getNIFCliente().equals(NIFCliente)){
                despesasAux.add(d.clone());
            }
        }
        despesasAux.sort(new FacturaComparator());
        for(Despesa d : despesasAux){
            System.out.print("Cliente: "+d.getNIFCliente()+" Valor: "+d.getValor()+
                             " Data: "+d.getData()+" Natureza: "+d.getNatureza()+"\n");
        }
    }

    /**
     * Método que calcula o total faturado por uma empresa dentro de um
     * determinado intervalo de tempo
     *
     * @param NIF
     */
    public void totalFaturado(String NIF){
        HashMap<Integer, Despesa> despesas = this.despesas.get(NIF);
        Date[] data = scannerData();
        int total = 0;
        for(Despesa d : despesas.values()){
            if(!d.getData().before(data[0]) && !d.getData().after(data[1])) {
                total += d.getValor();
            }
        }
        System.out.print("Total faturado: "+total+"\n");
    }

    /**
     * Método usado para receber input de utilizador sobre intervalo de data
     * a ser usado
     *
     * @return data
     */
    public Date[] scannerData(){
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Scanner scanner = new Scanner(System.in);
        Date[] data = new Date[2];
        while(true) {
            try {
                System.out.print("Data inicial (formato: dd/MM/yyyy HH:mm:ss):");
                String dataInicial = scanner.nextLine();
                data[0] = sdf.parse(dataInicial);
                System.out.print("Data final (formato: dd/MM/yyyy HH:mm:ss):");
                String dataFinal = scanner.nextLine();
                data[1] = sdf.parse(dataFinal);
                break;
            } catch (ParseException e) {
                System.out.println("Formato inválido\n");
            }
        }
        return data;
    }

    /**
     * Método save, que guarda as diversas HashMaps contendo informações do sistema
     * em ficheiros .ser
     */
    public void save() {
        try {
            FileOutputStream fos = new FileOutputStream("data.ser");
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(empresas);
            oos.writeObject(individuais);
            oos.writeObject(despesas);
            oos.close();
            fos.close();
            System.out.print("Serialized HashMap data is saved in hashmap.ser");
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }

    /**
     * Método load, que preenche as HashMaps do sistema com informação contida
     * em ficheiros .ser, previamente criados pelo sistema
     */
    public void load(){
        try
        {
            FileInputStream fis = new FileInputStream("data.ser");
            ObjectInputStream ois = new ObjectInputStream(fis);
            empresas = (HashMap<String,Empresa>) ois.readObject();
            individuais = (HashMap<String,Individual>) ois.readObject();
            despesas = (HashMap<String, HashMap<Integer, Despesa>>) ois.readObject();
            System.out.print(empresas+"\n");
            System.out.print(individuais+"\n");
            System.out.print(despesas+"\n");
            ois.close();
            fis.close();
        } catch(IOException ioe) {
            ioe.printStackTrace();
        } catch(ClassNotFoundException c) {
            System.out.println("Class not found");
            c.printStackTrace();
        }
    }

    /**
     * Método de teste criado para gerar dados que permitam testar todas as funcionalidades do sistema
     */
    private void gerador(){
        Empresa empresa = new Empresa("A","A","A","A","A", new HashMap<>(), 0);
        Empresa empresa2 = new Empresa("B","B","B","B","B", new HashMap<>(), 0);
        Empresa empresa3 = new Empresa("C","C","C","C","C", new HashMap<>(), 0);
        empresas.put(empresa.getNIF(), empresa.clone());
        empresas.put(empresa2.getNIF(), empresa2.clone());
        empresas.put(empresa3.getNIF(), empresa3.clone());

        HashMap<String, String> NIFs = new HashMap<>();
        NIFs.put("1","1");
        NIFs.put("2","2");
        HashMap<String, String> atividades = new HashMap<>();
        atividades.put("A","A");
        atividades.put("B","B");
        Individual individual = new Individual("a","a","a","a","a",NIFs.size(),0,NIFs,atividades);
        Individual individual2 = new Individual("b","b","b","b","b",0,0, new HashMap<>(), new HashMap<>());
        individuais.put(individual.getNIF(),individual.clone());
        individuais.put(individual2.getNIF(),individual2.clone());

        Despesa despesa = new Despesa(0,"0",new Date(),"A","1","0","0",5);
        Despesa despesa2 = new Despesa(1,"1",new Date(),"A","b","1","1",10);
        Despesa despesa3 = new Despesa(2,"2",new Date(),"B","a","2","2",12);
        Despesa despesa4 = new Despesa(3,"3",new Date(),"B","b","3","3",2);
        Despesa despesa5 = new Despesa(4,"4",new Date(),"A","2","4","4",21);
        Despesa despesa6 = new Despesa(5,"5",new Date(),"A","b","5","5",54);
        Despesa despesa7 = new Despesa(6,"6",new Date(),"A","a","6","6",1);
        Despesa despesa8 = new Despesa(7,"7",new Date(),"A","b","7","7",13);
        HashMap<Integer, Despesa> despesasAux = new HashMap<>();
        HashMap<Integer, Despesa> despesasAux2 = new HashMap<>();
        despesasAux.put(despesa.getID(),despesa.clone());
        despesasAux.put(despesa2.getID(),despesa2.clone());
        despesasAux2.put(despesa3.getID(),despesa3.clone());
        despesasAux2.put(despesa4.getID(),despesa4.clone());
        despesasAux.put(despesa5.getID(),despesa5.clone());
        despesasAux.put(despesa6.getID(),despesa6.clone());
        despesasAux.put(despesa7.getID(),despesa7.clone());
        despesasAux.put(despesa8.getID(),despesa8.clone());
        despesas.put(despesa.getNIFEmitente(), despesasAux);
        despesas.put(despesa3.getNIFEmitente(), despesasAux2);
    }
}
