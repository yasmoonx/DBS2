import java.io.*;
import java.sql.*;

public class Notenabfrage {

    public static void main(String args[]) {

        String name = null;
        String passwd = null;
        String vorlesungsname = null;
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;

        try {
            System.out.println("DB-Account: ");
            name = in.readLine();
            System.out.println("Passwort:");
            passwd = in.readLine();
            System.out.println("Vorlesungsname:");
            vorlesungsname = in.readLine();
        } catch (IOException e) {
            System.out.println("Fehler beim Lesen der Eingabe: " + e);
            System.exit(-1);
        }

        System.out.println("");

        try {
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver()); 				// Treiber laden
            String url = "jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c"; // String für DB-Connection
            conn = DriverManager.getConnection(url, name, passwd); 						// Verbindung erstellen

            conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            conn.setAutoCommit(false);

            stmt = conn.createStatement();
            String matrikel = "123456";   // Wird normal aus den Anmeldedaten ermittelt


            //UNSICHER
            
            /*String mySelectQuery = "SELECT matrikelnummer, vorlesungsname, note FROM eck.Noten " +
                    "WHERE matrikelnummer = '" + matrikel + "' AND vorlesungsname = '" + vorlesungsname + "'"; 

            rset = stmt.executeQuery(mySelectQuery);*/

            //SICHER

            PreparedStatement ps = conn.prepareStatement("SELECT matrikelnummer, vorlesungsname, note FROM eck.Noten " +
            "WHERE matrikelnummer = '" + matrikel + "' AND vorlesungsname = ?");

            ps.setString(1,vorlesungsname);

            rset = ps.executeQuery();

              while(rset.next())
                System.out.println(rset.getString("matrikelnummer") + ", "
                        + rset.getString("vorlesungsname") + ", Note = "
                        + rset.getFloat("note")
                );

            stmt.close();																// Verbindung trennen
            conn.commit();
            conn.close();
        } catch (SQLException se) {														// SQL-Fehler abfangen
            System.out.println();
            System.out
                    .println("SQL Exception occurred while establishing connection to DBS: "
                            + se.getMessage());
            System.out.println("- SQL state  : " + se.getSQLState());
            System.out.println("- Message    : " + se.getMessage());
            System.out.println("- Vendor code: " + se.getErrorCode());
            System.out.println();
            System.out.println("EXITING WITH FAILURE ... !!!");
            System.out.println();
            try {
                conn.rollback();														// Rollback durchführen
            } catch (SQLException e) {
                e.printStackTrace();
            }
            System.exit(-1);
        }
    }
}
