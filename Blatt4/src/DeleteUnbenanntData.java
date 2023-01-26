/**
 * Licensee: Chris(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class DeleteUnbenanntData {
	public void deleteTestData() throws PersistentException {
		PersistentTransaction t = UnbenanntPersistentManager.instance().getSession().beginTransaction();
		try {
			Studiengang studiengang = Studiengang.loadStudiengangByQuery(null, null);
			studiengang.delete();
			Vorlesung vorlesung = Vorlesung.loadVorlesungByQuery(null, null);
			vorlesung.delete();
			t.commit();
		}
		catch (Exception e) {
			t.rollback();
		}
		
	}
	
	public static void main(String[] args) {
		try {
			DeleteUnbenanntData deleteUnbenanntData = new DeleteUnbenanntData();
			try {
				deleteUnbenanntData.deleteTestData();
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
