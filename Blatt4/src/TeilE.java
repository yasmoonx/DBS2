/**
 * Licensee: Chris(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;

import java.util.ArrayList;

public class TeilE {
    private static final int ROW_COUNT = 100;

    public void listEData() throws PersistentException {
        ArrayList<String> sameVorlesung = new ArrayList<>();
        System.out.println("Listing Studiengang...");
        Studiengang[] studiengangs = Studiengang.listStudiengangByQuery(null, null);
        int lengthE = Math.min(studiengangs.length, ROW_COUNT);
        for (int i = 0; i < lengthE; i++) {
            System.out.println(studiengangs[i]);
            System.out.println("Listing Vorlesung...");
            Vorlesung[] vorlesungs = Vorlesung.listVorlesungByQuery("StudiengangKuerzel = '"+studiengangs[i].getKuerzel() +"'", null);
            int length = Math.min(vorlesungs.length, ROW_COUNT);
            int countMyStuff = 0;
            for (int b = 0; b < length; b++) {
                sameVorlesung.add(vorlesungs[b].getName());
                System.out.println(vorlesungs[b] + " " + vorlesungs[b].getName() + " " + vorlesungs[b].getEcts() + " " + vorlesungs[b].get_studiengang().getName());
                countMyStuff += vorlesungs[b].getEcts();
            }
            System.out.println(length + " record(s) retrieved. With ECTS: " + countMyStuff + " in " + studiengangs[i].getKuerzel());
        }
        System.out.println(lengthE + " record(s) retrieved.");
        ArrayList<String> tempVorlesung = new ArrayList<>();
        ArrayList<String> printDoubles = new ArrayList<>();
        for (int i = 0; i < sameVorlesung.size(); i++) {
            String s = sameVorlesung.get(i);
            for (String t: tempVorlesung) {
                if (s.equals(t)) {
                    //check if already in doubles if wanting to prevent multiple entries
                    printDoubles.add(t);
                }
            }
            tempVorlesung.add(s);
        }
        System.out.printf("print Doubles: %s", printDoubles.toString());


    }

    public static void main(String[] args) {
        try {
            TeilE listUnbenanntData = new TeilE();
            try {
                listUnbenanntData.listEData();
            }
            finally {
                UnbenanntPersistentManager.instance().disposePersistentManager();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
