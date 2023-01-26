/**
 * "Visual Paradigm: DO NOT MODIFY THIS FILE!"
 * 
 * This is an automatic generated file. It will be regenerated every time 
 * you generate persistence class.
 * 
 * Modifying its content may cause the program not work, or your work may lost.
 */

/**
 * Licensee: Chris(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
import org.hibernate.Query;
import org.hibernate.LockMode;
import java.util.List;

public class Studiengang {
	public Studiengang() {
	}
	
	public static Studiengang loadStudiengangByORMID(String kuerzel) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return loadStudiengangByORMID(session, kuerzel);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang getStudiengangByORMID(String kuerzel) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return getStudiengangByORMID(session, kuerzel);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang loadStudiengangByORMID(String kuerzel, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return loadStudiengangByORMID(session, kuerzel, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang getStudiengangByORMID(String kuerzel, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return getStudiengangByORMID(session, kuerzel, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang loadStudiengangByORMID(PersistentSession session, String kuerzel) throws PersistentException {
		try {
			return (Studiengang) session.load(Studiengang.class, kuerzel);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang getStudiengangByORMID(PersistentSession session, String kuerzel) throws PersistentException {
		try {
			return (Studiengang) session.get(Studiengang.class, kuerzel);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang loadStudiengangByORMID(PersistentSession session, String kuerzel, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			return (Studiengang) session.load(Studiengang.class, kuerzel, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang getStudiengangByORMID(PersistentSession session, String kuerzel, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			return (Studiengang) session.get(Studiengang.class, kuerzel, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static List queryStudiengang(String condition, String orderBy) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return queryStudiengang(session, condition, orderBy);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static List queryStudiengang(String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return queryStudiengang(session, condition, orderBy, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang[] listStudiengangByQuery(String condition, String orderBy) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return listStudiengangByQuery(session, condition, orderBy);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang[] listStudiengangByQuery(String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return listStudiengangByQuery(session, condition, orderBy, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static List queryStudiengang(PersistentSession session, String condition, String orderBy) throws PersistentException {
		StringBuffer sb = new StringBuffer("From Studiengang as Studiengang");
		if (condition != null)
			sb.append(" Where ").append(condition);
		if (orderBy != null)
			sb.append(" Order By ").append(orderBy);
		try {
			Query query = session.createQuery(sb.toString());
			return query.list();
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static List queryStudiengang(PersistentSession session, String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		StringBuffer sb = new StringBuffer("From Studiengang as Studiengang");
		if (condition != null)
			sb.append(" Where ").append(condition);
		if (orderBy != null)
			sb.append(" Order By ").append(orderBy);
		try {
			Query query = session.createQuery(sb.toString());
			query.setLockMode("Studiengang", lockMode);
			return query.list();
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang[] listStudiengangByQuery(PersistentSession session, String condition, String orderBy) throws PersistentException {
		try {
			List list = queryStudiengang(session, condition, orderBy);
			return (Studiengang[]) list.toArray(new Studiengang[list.size()]);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang[] listStudiengangByQuery(PersistentSession session, String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			List list = queryStudiengang(session, condition, orderBy, lockMode);
			return (Studiengang[]) list.toArray(new Studiengang[list.size()]);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang loadStudiengangByQuery(String condition, String orderBy) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return loadStudiengangByQuery(session, condition, orderBy);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang loadStudiengangByQuery(String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return loadStudiengangByQuery(session, condition, orderBy, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static Studiengang loadStudiengangByQuery(PersistentSession session, String condition, String orderBy) throws PersistentException {
		Studiengang[] studiengangs = listStudiengangByQuery(session, condition, orderBy);
		if (studiengangs != null && studiengangs.length > 0)
			return studiengangs[0];
		else
			return null;
	}
	
	public static Studiengang loadStudiengangByQuery(PersistentSession session, String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		Studiengang[] studiengangs = listStudiengangByQuery(session, condition, orderBy, lockMode);
		if (studiengangs != null && studiengangs.length > 0)
			return studiengangs[0];
		else
			return null;
	}
	
	public static java.util.Iterator iterateStudiengangByQuery(String condition, String orderBy) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return iterateStudiengangByQuery(session, condition, orderBy);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static java.util.Iterator iterateStudiengangByQuery(String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		try {
			PersistentSession session = UnbenanntPersistentManager.instance().getSession();
			return iterateStudiengangByQuery(session, condition, orderBy, lockMode);
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static java.util.Iterator iterateStudiengangByQuery(PersistentSession session, String condition, String orderBy) throws PersistentException {
		StringBuffer sb = new StringBuffer("From Studiengang as Studiengang");
		if (condition != null)
			sb.append(" Where ").append(condition);
		if (orderBy != null)
			sb.append(" Order By ").append(orderBy);
		try {
			Query query = session.createQuery(sb.toString());
			return query.iterate();
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public static java.util.Iterator iterateStudiengangByQuery(PersistentSession session, String condition, String orderBy, org.hibernate.LockMode lockMode) throws PersistentException {
		StringBuffer sb = new StringBuffer("From Studiengang as Studiengang");
		if (condition != null)
			sb.append(" Where ").append(condition);
		if (orderBy != null)
			sb.append(" Order By ").append(orderBy);
		try {
			Query query = session.createQuery(sb.toString());
			query.setLockMode("Studiengang", lockMode);
			return query.iterate();
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public boolean equals(Object aObj) {
		if (aObj == this)
			return true;
		if (!(aObj instanceof Studiengang))
			return false;
		Studiengang studiengang = (Studiengang)aObj;
		if ((getKuerzel() != null && !getKuerzel().equals(studiengang.getKuerzel())) || (getKuerzel() == null && studiengang.getKuerzel() != null))
			return false;
		return true;
	}
	
	public int hashCode() {
		int hashcode = 0;
		hashcode = hashcode + (getKuerzel() == null ? 0 : getKuerzel().hashCode());
		return hashcode;
	}
	
	public static Studiengang createStudiengang() {
		return new Studiengang();
	}
	
	public boolean save() throws PersistentException {
		try {
			UnbenanntPersistentManager.instance().saveObject(this);
			return true;
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public boolean delete() throws PersistentException {
		try {
			UnbenanntPersistentManager.instance().deleteObject(this);
			return true;
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public boolean refresh() throws PersistentException {
		try {
			UnbenanntPersistentManager.instance().getSession().refresh(this);
			return true;
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public boolean evict() throws PersistentException {
		try {
			UnbenanntPersistentManager.instance().getSession().evict(this);
			return true;
		}
		catch (Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public boolean deleteAndDissociate()throws PersistentException {
		try {
			Vorlesung[] l_vorlesungs = _vorlesung.toArray();
			for(int i = 0; i < l_vorlesungs.length; i++) {
				l_vorlesungs[i].set_studiengang(null);
			}
			return delete();
		}
		catch(Exception e) {
			throw new PersistentException(e);
		}
	}
	
	public boolean deleteAndDissociate(org.orm.PersistentSession session)throws PersistentException {
		try {
			Vorlesung[] l_vorlesungs = _vorlesung.toArray();
			for(int i = 0; i < l_vorlesungs.length; i++) {
				l_vorlesungs[i].set_studiengang(null);
			}
			try {
				session.delete(this);
				return true;
			} catch (Exception e) {
				return false;
			}
		}
		catch(Exception e) {
			throw new PersistentException(e);
		}
	}
	
	private java.util.Set this_getSet (int key) {
		if (key == ORMConstants.KEY_STUDIENGANG__VORLESUNG) {
			return ORM__vorlesung;
		}
		
		return null;
	}
	
	org.orm.util.ORMAdapter _ormAdapter = new org.orm.util.AbstractORMAdapter() {
		public java.util.Set getSet(int key) {
			return this_getSet(key);
		}
		
	};
	
	private String kuerzel;
	
	private String name;
	
	private String abschluss;
	
	private java.util.Set ORM__vorlesung = new java.util.HashSet();
	
	public void setKuerzel(String value) {
		this.kuerzel = value;
	}
	
	public String getKuerzel() {
		return kuerzel;
	}
	
	public String getORMID() {
		return getKuerzel();
	}
	
	public void setName(String value) {
		this.name = value;
	}
	
	public String getName() {
		return name;
	}
	
	public void setAbschluss(String value) {
		this.abschluss = value;
	}
	
	public String getAbschluss() {
		return abschluss;
	}
	
	private void setORM__vorlesung(java.util.Set value) {
		this.ORM__vorlesung = value;
	}
	
	private java.util.Set getORM__vorlesung() {
		return ORM__vorlesung;
	}
	
	public final VorlesungSetCollection _vorlesung = new VorlesungSetCollection(this, _ormAdapter, ORMConstants.KEY_STUDIENGANG__VORLESUNG, ORMConstants.KEY_VORLESUNG__STUDIENGANG, ORMConstants.KEY_MUL_ONE_TO_MANY);
	
	public String toString() {
		return String.valueOf(getKuerzel());
	}
	
}
