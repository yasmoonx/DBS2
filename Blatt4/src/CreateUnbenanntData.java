/**
 * Licensee: Chris(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class CreateUnbenanntData {
	public void createTestData() throws PersistentException {
		PersistentTransaction t = UnbenanntPersistentManager.instance().getSession().beginTransaction();
		try {
			Studiengang studiengang = Studiengang.createStudiengang();
			studiengang.setName("Angewandte Informatik");
			studiengang.setKuerzel("AIN");
			studiengang.setAbschluss("BACHELOR");
			studiengang.save();

			String[] vorlesungsnamen = {"DBSYS2", "DBSYS1", "Rechnernetze", "Sprachkonzepte", "BSYS"};
			for (String s : vorlesungsnamen) {
				Vorlesung vorlesung = Vorlesung.createVorlesung();
				vorlesung.setEcts(6);
				vorlesung.setSws(4);
				vorlesung.setName(s);
				vorlesung.set_studiengang(studiengang);
				vorlesung.save();
			}

			Studiengang studiengangB = Studiengang.createStudiengang();
			studiengangB.setName("Wirtschaftsinformatik");
			studiengangB.setKuerzel("WIN");
			studiengangB.setAbschluss("BACHELOR");
			studiengangB.save();
			String[] vorlesungsnamenWIN = {"DBSYS2", "DBSYS1", "Rechnernetze", "Sprachkonzepte", "BSYS"};
			for (String s : vorlesungsnamenWIN) {
				Vorlesung vorlesung = Vorlesung.createVorlesung();
				vorlesung.setEcts(6);
				vorlesung.setSws(4);
				vorlesung.setName(s);
				vorlesung.set_studiengang(studiengangB);
				vorlesung.save();
			}

			t.commit();
		}
		catch (Exception e) {
			t.rollback();
		}
		
	}
	
	public static void main(String[] args) {
		try {
			CreateUnbenanntData createUnbenanntData = new CreateUnbenanntData();
			try {
				createUnbenanntData.createTestData();
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
