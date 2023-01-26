/**
 * Licensee: Chris(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class RetrieveAndUpdateUnbenanntData {
	public void retrieveAndUpdateTestData() throws PersistentException {
		PersistentTransaction t = UnbenanntPersistentManager.instance().getSession().beginTransaction();
		try {
			Studiengang studiengang = Studiengang.loadStudiengangByQuery(null, null);
			// Update the properties of the persistent object
			studiengang.save();
			Vorlesung vorlesung = Vorlesung.loadVorlesungByQuery(null, null);
			// Update the properties of the persistent object
			vorlesung.save();
			t.commit();
		}
		catch (Exception e) {
			t.rollback();
		}
		
	}
	
	public static void main(String[] args) {
		try {
			RetrieveAndUpdateUnbenanntData retrieveAndUpdateUnbenanntData = new RetrieveAndUpdateUnbenanntData();
			try {
				retrieveAndUpdateUnbenanntData.retrieveAndUpdateTestData();
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
