import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/yourDatabaseName";
        String username = "root";
        String password = "yourPassword";

        try {
            Connection conn = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to database!");

        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
        }
    }
}
