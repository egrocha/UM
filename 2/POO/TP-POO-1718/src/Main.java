import java.io.Serializable;
import java.util.Scanner;

/**
 * Classe Main do Trabalho Prático.
 *
 * @author André Vieira
 * @author Eduardo Rocha
 * @author Ricardo Neves
 * @version 22-04-18
 */

public class Main implements Serializable {

    private static Processamento processamento;

    /**
     * Método main do trabalho, que trata de criar uma instância de Processamento para
     * iniciar o funcionamento do sistema
     *
     * @param args
     */
    public static void main(String[] args) {
        String[] dados = new String[2];
        processamento = new Processamento();
        while(true) {
            int opcao = menuInicial();
            switch (opcao) {
                case 1:
                    dados = menuLogin();
                    if (processamento.loginEmpresa(dados[0], dados[1]))
                        menuEmpresas(dados[0]);
                    else System.out.print("Dados inválidos\n");
                    break;
                case 2:
                    dados = menuLogin();
                    if(processamento.loginIndividual(dados[0], dados[1]))
                        menuIndividuais(dados[0]);
                    else System.out.print("Dados inválidos\n");
                    break;
                case 3:
                    dados[0] = processamento.registarEmpresa();
                    menuEmpresas(dados[0]);
                    break;
                case 4:
                    dados[0] = processamento.registarIndividual();
                    menuIndividuais(dados[0]);
                    break;
                case 5:
                    processamento.save();
                    System.out.print("Dados guardados\n");
                    break;
                case 6:
                    processamento.load();
                    System.out.print("Dados importados\n");
                    break;
                case 7:
                    dados = menuLogin();
                    if(dados[0].equals("admin") && dados[1].equals("admin")){
                        menuAdmin();
                    }
                    break;
                case 0:
                    return;
            }
        }
    }


    /**
     * Método que imprime o menu inicial que é mostrado ao utilizador quando acede inicialmente ao
     * sistema, permitindo-lhe realizar operações de login, registo, ou de alteração de dados
     *
     * @return opcao
     */
    private static int menuInicial(){
        int opcao;
        System.out.print("Escolha uma opção:\n");
        System.out.print("1 - Login para Empresas\n");
        System.out.print("2 - Login para Contribuintes Individuais\n");
        System.out.print("3 - Registar Empresa\n");
        System.out.print("4 - Registar Contribuinte Individual\n");
        System.out.print("5 - Guardar Dados\n");
        System.out.print("6 - Importar Dados\n");
        System.out.print("7 - Login Administrador\n");
        System.out.print("0 - Sair.\n");
        System.out.print("Opção:");
        Scanner scanner = new Scanner(System.in);
        while (true) {
            opcao = scanner.nextInt();
            if(opcao >= 0 && opcao <= 7) return opcao;
            else System.out.print("Opção inválida.\nOpção:");
        }
    }

    /**
     * Método que imprime o menu de Login, para todos os tipos de contribuintes que tentam
     * entrar no sistema
     *
     * @return dados
     */
    private static String[] menuLogin(){
        String[] dados = new String[2];
        Scanner scanner = new Scanner(System.in);
        System.out.print("NIF:");
        dados[0] = scanner.nextLine();
        System.out.print("Password:");
        dados[1] = scanner.nextLine();
        return dados;
    }

    /**
     * Método que imprime o menu que contem as opções que as empresas têm ao seu dispor
     *
     * @param NIF
     */
    private static void menuEmpresas(String NIF){
        Scanner scanner = new Scanner(System.in);
        int opcao;
        while(true){
            System.out.print("Escolha uma opção:\n");
            System.out.print("1 - Gerar factura\n");
            System.out.print("2 - Alterar classificação de factura\n");
            System.out.print("3 - Rastrear classificações de facturas\n");
            System.out.print("4 - Listagem de facturas\n");
            System.out.print("5 - Listagem de facturas entre um intervalo de datas\n");
            System.out.print("6 - Listagem de facturas ordenadas por valor\n");
            System.out.print("7 - Calcular total faturado pela empresa em intervalo\n");
            System.out.print("0 - Sair\n");
            System.out.print("Opção:");
            opcao = scanner.nextInt();
            switch(opcao) {
                case 1:
                    processamento.gerarDespesa(NIF);
                    System.out.print("Factura registada\n");
                    break;
                case 2:
                    processamento.alterarClassificacao(NIF);
                    System.out.print("Alteração efectuada\n");
                    break;
                case 3:
                    processamento.rastreioClassificacoes(NIF);
                    break;
                case 4:
                    processamento.listagemFacturas10(NIF);
                    break;
                case 5:
                    processamento.listagemFacturasDatas(NIF);
                    break;
                case 6:
                    processamento.listagemFacturasContribuinte(NIF);
                    break;
                case 7:
                    processamento.totalFaturado(NIF);
                    break;
                case 0:
                    return;
                default:
                    System.out.print("Opção inválida\nOpção:");
            }
        }
    }

    /**
     * Método que imprime o menu relativo aos contribuintes individuais do sistema, permitindo-lhes
     * aceder às funcionalidades do sistema reservadas a si
     *
     * @param NIF
     */
    private static void menuIndividuais(String NIF){
        Scanner scanner = new Scanner(System.in);
        int opcao;
        while(true){
            System.out.print("Escolha uma opção:\n");
            System.out.print("1 - Verificar despesas\n");
            System.out.print("0 - Sair\n");
            System.out.print("Opção:");
            opcao = scanner.nextInt();
            switch(opcao) {
                case 1:
                    processamento.verificarDespesas(NIF);
                    break;
                case 0:
                    return;
                default:
                    System.out.print("Opção inválida\nOpção:");
            }
        }
    }

    /**
     * Método que imprime o menu que contem as funcionalidades exclusivas aos
     * administradores
     */
    private static void menuAdmin(){
        Scanner scanner = new Scanner(System.in);
        int opcao;
        while(true){
            System.out.print("Escolha uma opção:\n");
            System.out.print("1 - Ver 10 contribuintes que mais gastam (NYI)\n");
            System.out.print("2 - Ver empresas que mais despesas registam (NYI)\n");
            System.out.print("0 - Sair\n");
            System.out.print("Opção:");
            opcao = scanner.nextInt();
            switch(opcao) {
                case 1:
                    break;
                case 2:
                    break;
                case 0:
                    return;
                default:
                    System.out.print("Opção inválida\nOpção:");
            }
        }
    }

}