/**
 * Licensee: Chris(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class CreateUnbenanntDatabaseSchema {
	public static void main(String[] args) {
		try {
			ORMDatabaseInitiator.createSchema(UnbenanntPersistentManager.instance());
			UnbenanntPersistentManager.instance().disposePersistentManager();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
