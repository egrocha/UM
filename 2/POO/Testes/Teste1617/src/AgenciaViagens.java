import java.io.*;
import java.util.List;
import java.util.Map;

public class AgenciaViagens {

    private String nome;
    private Map<Hotel, List<String>> hoteis;

    public void gravarFicheiro(int estrelas) {
        try {
            PrintWriter pw = new PrintWriter("hotel.txt");
            for(Hotel h : hoteis.keySet()){
                if(h.getEstrelas() == estrelas){
                    pw.write(hoteis.get(h).toString());
                }
            }
        } catch (IOException e){
            System.out.print(e.getMessage());
        }
    }

    public Hotel criaInstancia(String filename) {
        try{
            FileInputStream fis = new FileInputStream(filename);
            ObjectInputStream ois = new ObjectInputStream(fis);
            Hotel h = (Hotel) ois.readObject();
            ois.close();
            fis.close();
            return h;
        } catch(IOException | ClassNotFoundException e){
            Hotel h = new Hotel();
            return h;
        }
    }

    /* d) - É preciso que as classes AgenciaViagens e Hotel implementem
    as duas Serializable
    */

}
