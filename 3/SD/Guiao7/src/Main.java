import java.io.IOException;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws IOException {
        System.out.println("1 - Cliente");
        System.out.println("2 - Servidor");
        Scanner scanner = new Scanner(System.in);
        int op = scanner.nextInt();
        if(op == 1){
            Cliente cliente = new Cliente(12345);
            cliente.start();
        }
        else{
            Servidor servidor = new Servidor();
            servidor.start();
        }
    }

}
