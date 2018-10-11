import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class VOR {

    private Map<String, Equipa> equipas;

    public VOR(Map<String, Equipa> equipas) {
        this.equipas = equipas;
    }

    Barco getBarco(String idEquipa, String idBarco) throws InvalidBoatException{
        if(this.equipas.get(idEquipa).getBarcos().containsKey(idBarco)){
            return this.equipas.get(idEquipa).getBarcos().get(idBarco).clone();
        }
        else throw new InvalidBoatException();
    }

    List<Barco> getBarcos(String idEquipa, double milhas){
        ArrayList<Barco> res = new ArrayList<>();
        for(Barco b : equipas.get(idEquipa).getBarcos().values()){
            if(b.getMilhas() > milhas) res.add(b.clone());
        }
        return res;
    }

    void removeBarco(String idEquipa, String idBarco) throws InvalidBoatException{
        if(this.equipas.get(idEquipa).getBarcos().containsKey(idBarco)){
            equipas.get(idEquipa).getBarcos().remove(idBarco);
        }
        else{
            throw new InvalidBoatException();
        }
    }

    void gravaFicheiroTextoSeguraveis(String fich) {
        try{
            PrintWriter pw = new PrintWriter(fich);
            for(Equipa e : equipas.values()){
                for(Barco b : e.getBarcos().values()){
                    if(b instanceof BarcoHibrido || b instanceof BarcoCatamaran){
                        pw.print(b);
                        pw.flush();
                    }
                }
            }
            pw.close();
        } catch (FileNotFoundException e){
            e.getMessage();
        }

    }

}
