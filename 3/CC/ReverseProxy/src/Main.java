import javax.management.monitor.Monitor;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Scanner;

public class Main {

    private static HashMap<String, Estado> tabelaEstado;

    public static void main(String args[]) {
        //TabelaEstado tabela = new TabelaEstado();
        tabelaEstado = new HashMap<>();
        //MonitorUDP monitor = new MonitorUDP();
        printMenu();
    }

    private static void printMenu() {
        while (true) {
            System.out.print("1 - MonitorUDP\n");
            System.out.print("2 - AgenteUDP\n");
            System.out.print("3 - ReverseProxy\n");
            System.out.print("0 - Sair\n");
            Scanner scanner = new Scanner(System.in);
            int option = scanner.nextInt();
            if (option == 1) {
                MonitorUDP monitorUDP = new MonitorUDP();
            }
            else if (option == 2) {
                AgenteUDP agenteUDP = new AgenteUDP();
            }
            else System.out.print("Opção inválida\n");
        }
    }
}
