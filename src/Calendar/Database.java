package Calendar;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Database {

    String url = "jdbc:mysql://138.49.184.123:3306/neudahl2130_MovingLLC";
    String user = "neudahl2130";
    String pass = "LKg4fJrW5G3Bdb5!j";

    private Connection connection;

    public Database() {
        try {
            System.out.println("Attempting database connection...");

            Class.forName("com.mysql.cj.jdbc.Driver");

            connection = DriverManager.getConnection(url, user, pass);

            System.out.println("Database connected successfully!");

        } catch (ClassNotFoundException e) {
            System.out.println("MySQL driver not found.");
            e.printStackTrace();

        } catch (SQLException e) {
            System.out.println("Database connection failed.");
            e.printStackTrace();
        }
    }

    private LocalDate parseUiDate(String date) {
        return LocalDate.parse(date, DateTimeFormatter.ofPattern("dd-MM-yyyy"));
    }

    private LocalTime parseUiTime(String time) {
        if (time == null || time.isBlank()) {
            return LocalTime.of(0, 0);
        }
        return LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm"));
    }

    public ArrayList<Event> getEvents(String date) {
        ArrayList<Event> events = new ArrayList<>();

        if (connection == null) {
            return events;
        }

        String select =
            "SELECT " +
            "j.job_id, j.customer_id, j.quote_id, j.move_date, j.start_time, j.job_status, " +
            "j.crew_size AS job_crew_size, j.hourly_rate, j.estimated_hours AS job_estimated_hours, " +
            "j.actual_hours, j.notes AS job_notes, " +
            "c.first_name, c.last_name, c.phone, c.email, " +
            "q.quoted_hourly_rate, q.estimated_hours AS quote_estimated_hours, " +
            "q.crew_size AS quote_crew_size, q.estimated_cost, q.notes AS quote_notes, " +
            "origin.street AS origin_street, origin.city AS origin_city, " +
            "origin.state AS origin_state, origin.zip_code AS origin_zip, " +
            "dest.street AS destination_street, dest.city AS destination_city, " +
            "dest.state AS destination_state, dest.zip_code AS destination_zip, " +
            "jt.truck_id, " +
            "GROUP_CONCAT(je.employee_id ORDER BY je.employee_id SEPARATOR ',') AS employee_ids " +
            "FROM Job j " +
            "JOIN Customer c ON j.customer_id = c.customer_id " +
            "LEFT JOIN Quote q ON j.quote_id = q.quote_id " +
            "LEFT JOIN Location origin ON j.job_id = origin.job_id AND origin.location_type = 'Origin' " +
            "LEFT JOIN Location dest ON j.job_id = dest.job_id AND dest.location_type = 'Destination' " +
            "LEFT JOIN Job_Truck jt ON j.job_id = jt.job_id " +
            "LEFT JOIN Job_Employee je ON j.job_id = je.job_id " +
            "WHERE j.move_date = ? " +
            "GROUP BY j.job_id, j.customer_id, j.quote_id, j.move_date, j.start_time, j.job_status, " +
            "j.crew_size, j.hourly_rate, j.estimated_hours, j.actual_hours, j.notes, " +
            "c.first_name, c.last_name, c.phone, c.email, " +
            "q.quoted_hourly_rate, q.estimated_hours, q.crew_size, q.estimated_cost, q.notes, " +
            "origin.street, origin.city, origin.state, origin.zip_code, " +
            "dest.street, dest.city, dest.state, dest.zip_code, jt.truck_id " +
            "ORDER BY j.start_time;";

        try (PreparedStatement ps = connection.prepareStatement(select)) {
            ps.setDate(1, Date.valueOf(parseUiDate(date)));

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event e = new Event();

                e.setID(rs.getInt("job_id"));
                e.setCustomerId(rs.getInt("customer_id"));
                e.setQuoteId(rs.getInt("quote_id"));

                e.setDateTimeFromSql(
                    rs.getString("move_date"),
                    rs.getString("start_time")
                );

                e.setCustomerFirstName(rs.getString("first_name"));
                e.setCustomerLastName(rs.getString("last_name"));
                e.setCustomerPhone(rs.getString("phone"));
                e.setCustomerEmail(rs.getString("email"));

                e.setJobStatus(rs.getString("job_status"));
                e.setCrewSize(rs.getInt("job_crew_size"));
                e.setQuotedHourlyRate(rs.getDouble("quoted_hourly_rate"));
                e.setEstimatedHours(rs.getDouble("job_estimated_hours"));
                e.setActualHours(rs.getDouble("actual_hours"));
                e.setEstimatedCost(rs.getDouble("estimated_cost"));
                e.setQuoteNotes(rs.getString("quote_notes"));
                e.setJobNotes(rs.getString("job_notes"));

                e.setOriginStreet(rs.getString("origin_street"));
                e.setOriginCity(rs.getString("origin_city"));
                e.setOriginState(rs.getString("origin_state"));
                e.setOriginZip(rs.getString("origin_zip"));

                e.setDestinationStreet(rs.getString("destination_street"));
                e.setDestinationCity(rs.getString("destination_city"));
                e.setDestinationState(rs.getString("destination_state"));
                e.setDestinationZip(rs.getString("destination_zip"));

                e.setTruckId(rs.getInt("truck_id"));
                e.setEmployeeIdsCsv(rs.getString("employee_ids"));

                e.setTitle("Move for " + e.getCustomerFirstName() + " " + e.getCustomerLastName());
                e.setDescription(e.getJobNotes());

                events.add(e);
            }

        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        return events;
    }

    public boolean hasEvent(String date) {
        if (connection == null) {
            return false;
        }

        String select = "SELECT 1 FROM Job WHERE move_date = ? LIMIT 1;";

        try (PreparedStatement ps = connection.prepareStatement(select)) {
            ps.setDate(1, Date.valueOf(parseUiDate(date)));

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        return false;
    }

    public void createEvent(Event e) {
        if (connection == null) {
            return;
        }

        try {
            connection.setAutoCommit(false);

            int customerId = insertCustomer(e);
            int quoteId = insertQuote(e, customerId);
            int jobId = insertJob(e, customerId, quoteId);

            insertLocation(
                jobId,
                "Origin",
                e.getOriginStreet(),
                e.getOriginCity(),
                e.getOriginState(),
                e.getOriginZip()
            );

            insertLocation(
                jobId,
                "Destination",
                e.getDestinationStreet(),
                e.getDestinationCity(),
                e.getDestinationState(),
                e.getDestinationZip()
            );

            insertTruckAssignment(jobId, e.getTruckId());
            insertEmployeeAssignments(jobId, e.getEmployeeIdsCsv());

            connection.commit();

        } catch (SQLException exception) {
            rollback();
            exception.printStackTrace();

        } finally {
            resetAutoCommit();
        }
    }

    public void updateEvent(Event e) {
        if (connection == null) {
            return;
        }

        try {
            connection.setAutoCommit(false);

            updateCustomer(e);
            updateQuote(e);
            updateJob(e);

            deleteLocations(e.getID());

            insertLocation(
                e.getID(),
                "Origin",
                e.getOriginStreet(),
                e.getOriginCity(),
                e.getOriginState(),
                e.getOriginZip()
            );

            insertLocation(
                e.getID(),
                "Destination",
                e.getDestinationStreet(),
                e.getDestinationCity(),
                e.getDestinationState(),
                e.getDestinationZip()
            );

            deleteTruckAssignment(e.getID());
            insertTruckAssignment(e.getID(), e.getTruckId());

            deleteEmployeeAssignments(e.getID());
            insertEmployeeAssignments(e.getID(), e.getEmployeeIdsCsv());

            connection.commit();

        } catch (SQLException exception) {
            rollback();
            exception.printStackTrace();

        } finally {
            resetAutoCommit();
        }
    }

    public void deleteEvent(int ID) {
        if (connection == null) {
            return;
        }

        try {
            connection.setAutoCommit(false);

            deleteEmployeeAssignments(ID);
            deleteTruckAssignment(ID);
            deleteLocations(ID);

            String deleteJob = "DELETE FROM Job WHERE job_id = ?;";

            try (PreparedStatement ps = connection.prepareStatement(deleteJob)) {
                ps.setInt(1, ID);
                ps.executeUpdate();
            }

            connection.commit();

        } catch (SQLException exception) {
            rollback();
            exception.printStackTrace();

        } finally {
            resetAutoCommit();
        }
    }

    private int insertCustomer(Event e) throws SQLException {
        String sql =
            "INSERT INTO Customer " +
            "(first_name, last_name, phone, email, billing_street, billing_city, billing_state, billing_zip) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, e.getCustomerFirstName());
            ps.setString(2, e.getCustomerLastName());
            ps.setString(3, e.getCustomerPhone());
            ps.setString(4, blankToNull(e.getCustomerEmail()));
            ps.setString(5, e.getOriginStreet());
            ps.setString(6, e.getOriginCity());
            ps.setString(7, e.getOriginState());
            ps.setString(8, e.getOriginZip());

            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();

            if (keys.next()) {
                return keys.getInt(1);
            }
        }

        throw new SQLException("Could not create customer.");
    }

    private int insertQuote(Event e, int customerId) throws SQLException {
        String sql =
            "INSERT INTO Quote " +
            "(customer_id, quote_date, quoted_hourly_rate, estimated_hours, crew_size, estimated_cost, notes) " +
            "VALUES (?, CURDATE(), ?, ?, ?, ?, ?);";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setDouble(2, e.getQuotedHourlyRate());
            ps.setDouble(3, e.getEstimatedHours());
            ps.setInt(4, e.getCrewSize());
            ps.setDouble(5, e.getEstimatedCost());
            ps.setString(6, e.getQuoteNotes());

            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();

            if (keys.next()) {
                return keys.getInt(1);
            }
        }

        throw new SQLException("Could not create quote.");
    }

    private int insertJob(Event e, int customerId, int quoteId) throws SQLException {
        String sql =
            "INSERT INTO Job " +
            "(customer_id, quote_id, move_date, start_time, job_status, crew_size, hourly_rate, estimated_hours, actual_hours, notes) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setInt(2, quoteId);
            ps.setDate(3, Date.valueOf(e.getSqlDateToString()));
            ps.setTime(4, Time.valueOf(parseUiTime(e.getTimeToString())));
            ps.setString(5, e.getJobStatus().isBlank() ? "Scheduled" : e.getJobStatus());
            ps.setInt(6, e.getCrewSize());
            ps.setDouble(7, e.getQuotedHourlyRate());
            ps.setDouble(8, e.getEstimatedHours());
            ps.setDouble(9, e.getActualHours());
            ps.setString(10, e.getJobNotes());

            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();

            if (keys.next()) {
                return keys.getInt(1);
            }
        }

        throw new SQLException("Could not create job.");
    }

    private void insertLocation(
        int jobId,
        String type,
        String street,
        String city,
        String state,
        String zip
    ) throws SQLException {
        if (street == null || street.isBlank()) {
            return;
        }

        String sql =
            "INSERT INTO Location " +
            "(job_id, location_type, street, city, state, zip_code) " +
            "VALUES (?, ?, ?, ?, ?, ?);";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setString(2, type);
            ps.setString(3, street);
            ps.setString(4, city);
            ps.setString(5, state);
            ps.setString(6, zip);

            ps.executeUpdate();
        }
    }

    private void insertTruckAssignment(int jobId, int truckId) throws SQLException {
        if (truckId <= 0) {
            return;
        }

        String sql =
            "INSERT INTO Job_Truck " +
            "(job_id, truck_id, miles, fuel_cost) " +
            "VALUES (?, ?, 0, 0);";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, truckId);

            ps.executeUpdate();
        }

        String updateTruck =
            "UPDATE Truck SET status = 'In Use' WHERE truck_id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(updateTruck)) {
            ps.setInt(1, truckId);

            ps.executeUpdate();
        }
    }

    private void insertEmployeeAssignments(int jobId, String employeeIdsCsv) throws SQLException {
        if (employeeIdsCsv == null || employeeIdsCsv.isBlank()) {
            return;
        }

        String sql =
            "INSERT INTO Job_Employee " +
            "(job_id, employee_id, hours_worked, position_on_job) " +
            "VALUES (?, ?, 0, 'Mover');";

        String[] ids = employeeIdsCsv.split(",");

        for (String idText : ids) {
            if (idText.trim().isBlank()) {
                continue;
            }

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, jobId);
                ps.setInt(2, Integer.parseInt(idText.trim()));

                ps.executeUpdate();
            }
        }
    }

    private void updateCustomer(Event e) throws SQLException {
        String sql =
            "UPDATE Customer SET " +
            "first_name = ?, last_name = ?, phone = ?, email = ?, " +
            "billing_street = ?, billing_city = ?, billing_state = ?, billing_zip = ? " +
            "WHERE customer_id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, e.getCustomerFirstName());
            ps.setString(2, e.getCustomerLastName());
            ps.setString(3, e.getCustomerPhone());
            ps.setString(4, blankToNull(e.getCustomerEmail()));
            ps.setString(5, e.getOriginStreet());
            ps.setString(6, e.getOriginCity());
            ps.setString(7, e.getOriginState());
            ps.setString(8, e.getOriginZip());
            ps.setInt(9, e.getCustomerId());

            ps.executeUpdate();
        }
    }

    private void updateQuote(Event e) throws SQLException {
        String sql =
            "UPDATE Quote SET " +
            "quoted_hourly_rate = ?, estimated_hours = ?, crew_size = ?, estimated_cost = ?, notes = ? " +
            "WHERE quote_id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, e.getQuotedHourlyRate());
            ps.setDouble(2, e.getEstimatedHours());
            ps.setInt(3, e.getCrewSize());
            ps.setDouble(4, e.getEstimatedCost());
            ps.setString(5, e.getQuoteNotes());
            ps.setInt(6, e.getQuoteId());

            ps.executeUpdate();
        }
    }

    private void updateJob(Event e) throws SQLException {
        String sql =
            "UPDATE Job SET " +
            "move_date = ?, start_time = ?, job_status = ?, crew_size = ?, " +
            "hourly_rate = ?, estimated_hours = ?, actual_hours = ?, notes = ? " +
            "WHERE job_id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(e.getSqlDateToString()));
            ps.setTime(2, Time.valueOf(parseUiTime(e.getTimeToString())));
            ps.setString(3, e.getJobStatus().isBlank() ? "Scheduled" : e.getJobStatus());
            ps.setInt(4, e.getCrewSize());
            ps.setDouble(5, e.getQuotedHourlyRate());
            ps.setDouble(6, e.getEstimatedHours());
            ps.setDouble(7, e.getActualHours());
            ps.setString(8, e.getJobNotes());
            ps.setInt(9, e.getID());

            ps.executeUpdate();
        }
    }

    private void deleteLocations(int jobId) throws SQLException {
        String sql = "DELETE FROM Location WHERE job_id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.executeUpdate();
        }
    }

    private void deleteTruckAssignment(int jobId) throws SQLException {
        String sql = "DELETE FROM Job_Truck WHERE job_id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.executeUpdate();
        }
    }

    private void deleteEmployeeAssignments(int jobId) throws SQLException {
        String sql = "DELETE FROM Job_Employee WHERE job_id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.executeUpdate();
        }
    }

    private String blankToNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }

        return value.trim();
    }

    private void rollback() {
        try {
            if (connection != null) {
                connection.rollback();
            }
        } catch (SQLException rollbackException) {
            rollbackException.printStackTrace();
        }
    }

    private void resetAutoCommit() {
        try {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
        } catch (SQLException autoCommitException) {
            autoCommitException.printStackTrace();
        }
    }
}