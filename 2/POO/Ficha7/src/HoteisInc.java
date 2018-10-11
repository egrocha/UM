import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

public class HoteisInc {

    private HashMap<String, Hotel> hoteis;

    public HoteisInc(){
        hoteis = new HashMap<>();
        hoteis.put("a",new Hotel("a","a","a","a",5,10));
        hoteis.put("b",new Hotel("a","a","b","a",7,10));
        String cod = "a";
        System.out.print(existeHotel(cod)+"\n");
        System.out.print(quantos()+"\n");
        System.out.print(quantos("a")+"\n");
        Hotel c = new Hotel("c","c","c","c", 10, 15);
        adiciona(c);
        System.out.print(existeHotel("c")+"\n");
        System.out.print(getHoteis()+"\n");
    }

    public boolean existeHotel(String cod){
        return hoteis.containsKey(cod);
    }

    public int quantos(){
        int total = 0;
        for(Hotel h : hoteis.values()){
            total += h.getNum();
        }
        return total;
    }

    public int quantos(String loc){
        int total = 0;
        for(Hotel h : hoteis.values()){
            if(h.getLocalidade().equals(loc)){
                total += h.getNum();
            }
        }
        return total;
    }

    public void adiciona(Hotel h){
        this.hoteis.put(h.getCodigo(),h.clone());
    }

    public List<Hotel> getHoteis(){
        ArrayList<Hotel> res = new ArrayList<>();
        for(Hotel h : hoteis.values()){
            res.add(h.clone());
        }
        return res;
    }

    public void adiciona(Set<Hotel> hs){
        for(Hotel h : hs){
            adiciona(h);
        }
    }

    public void save(){
        try {
            FileOutputStream fos = new FileOutputStream("hoteis.ser");
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(hoteis);
            oos.close();
            fos.close();
        } catch (IOException ioe){
            ioe.printStackTrace();
        }
    }

    public void load(){
        try{
            FileInputStream fis = new FileInputStream("hoteis.ser");
            ObjectInputStream ois = new ObjectInputStream(fis);
            hoteis = (HashMap<String, Hotel>) ois.readObject();
            ois.close();
            fis.close();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch (ClassNotFoundException c){
            c.printStackTrace();
        }
    }

    public void saveInst(){
        try {
            FileOutputStream fos = new FileOutputStream("hoteisInst.ser");
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(this);
            oos.close();
            fos.close();
        } catch (IOException ioe){
            ioe.printStackTrace();
        }
    }

}
