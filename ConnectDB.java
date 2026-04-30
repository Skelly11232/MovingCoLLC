import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {

    public static void main(String[] args) {

        //String url = "jdbc:mysql://138.49.184.123:3306/neudahl2130_MovingLLC";
        //String username = "skelton3801";
        //String password = "qH3wcHuC7UBLwvdQ!";

        //String url = "jdbc:mysql://138.49.184.123:3306/neudahl2130_MovingLLC";
        //String username = "thomsen4642";
        //String password = "HJEksarADW7DtQq3-";

        String url = "jdbc:mysql://138.49.184.123:3306/neudahl2130_MovingLLC";
        String username = "neudahl2130";
        String password = "LKg4fJrW5G3Bdb5!j";

        try {
            Connection conn = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to database!");

        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
        }
    }
}
