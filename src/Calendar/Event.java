package Calendar;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class Event {

    private int ID; // Job ID
    private String title;
    private String description;
    private LocalDateTime dateTime;

    private int customerId;
    private String customerFirstName = "";
    private String customerLastName = "";
    private String customerPhone = "";
    private String customerEmail = "";

    private int quoteId;
    private double quotedHourlyRate;
    private double estimatedHours;
    private int crewSize;
    private double estimatedCost;
    private String quoteNotes = "";

    private String jobStatus = "Scheduled";
    private double actualHours;
    private String jobNotes = "";

    private String originStreet = "";
    private String originCity = "";
    private String originState = "";
    private String originZip = "";

    private String destinationStreet = "";
    private String destinationCity = "";
    private String destinationState = "";
    private String destinationZip = "";

    private int truckId;
    private String employeeIdsCsv = "";

    public Event(LocalDate date) {
        dateTime = LocalDateTime.of(date, LocalTime.now().withSecond(0).withNano(0));
    }

    public Event() {}

    public int getID() {
        return ID;
    }

    public void setID(int iD) {
        ID = iD;
    }

    public String getTitle() {
        if (title == null || title.isBlank()) {
            String name = (customerFirstName + " " + customerLastName).trim();
            if (!name.isBlank()) return "Move for " + name;
            if (ID > 0) return "Move Job #" + ID;
            return "New Move Job";
        }
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        if (description == null || description.isBlank()) {
            return jobNotes;
        }
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public String getDateTimeToString() {
        return dateTime.format(DateTimeFormatter.ofPattern("dd-MM-yyyy | HH:mm"));
    }

    public String getDateToString() {
        return dateTime.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
    }

    public String getSqlDateToString() {
        return dateTime.toLocalDate().format(DateTimeFormatter.ISO_LOCAL_DATE);
    }

    public String getTimeToString() {
        return dateTime.format(DateTimeFormatter.ofPattern("HH:mm"));
    }

    public void setDateTimeFromSql(String sqlDate, String sqlTime) {
        if (sqlTime == null || sqlTime.isBlank()) {
            sqlTime = "00:00";
        }

        if (sqlTime.length() >= 5) {
            sqlTime = sqlTime.substring(0, 5);
        }

        this.dateTime = LocalDateTime.of(
            LocalDate.parse(sqlDate, DateTimeFormatter.ISO_LOCAL_DATE),
            LocalTime.parse(sqlTime, DateTimeFormatter.ofPattern("HH:mm"))
        );
    }

    public void setTime(String time) {
        this.dateTime = LocalDateTime.of(
            dateTime.toLocalDate(),
            LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm"))
        );
    }

    public LocalDate getDate() {
        return dateTime.toLocalDate();
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerFirstName() {
        return customerFirstName;
    }

    public void setCustomerFirstName(String customerFirstName) {
        this.customerFirstName = safe(customerFirstName);
    }

    public String getCustomerLastName() {
        return customerLastName;
    }

    public void setCustomerLastName(String customerLastName) {
        this.customerLastName = safe(customerLastName);
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = safe(customerPhone);
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = safe(customerEmail);
    }

    public int getQuoteId() {
        return quoteId;
    }

    public void setQuoteId(int quoteId) {
        this.quoteId = quoteId;
    }

    public double getQuotedHourlyRate() {
        return quotedHourlyRate;
    }

    public void setQuotedHourlyRate(double quotedHourlyRate) {
        this.quotedHourlyRate = quotedHourlyRate;
    }

    public double getEstimatedHours() {
        return estimatedHours;
    }

    public void setEstimatedHours(double estimatedHours) {
        this.estimatedHours = estimatedHours;
    }

    public int getCrewSize() {
        return crewSize;
    }

    public void setCrewSize(int crewSize) {
        this.crewSize = crewSize;
    }

    public double getEstimatedCost() {
        return estimatedCost;
    }

    public void setEstimatedCost(double estimatedCost) {
        this.estimatedCost = estimatedCost;
    }

    public String getQuoteNotes() {
        return quoteNotes;
    }

    public void setQuoteNotes(String quoteNotes) {
        this.quoteNotes = safe(quoteNotes);
    }

    public String getJobStatus() {
        return jobStatus;
    }

    public void setJobStatus(String jobStatus) {
        this.jobStatus = safe(jobStatus);
    }

    public double getActualHours() {
        return actualHours;
    }

    public void setActualHours(double actualHours) {
        this.actualHours = actualHours;
    }

    public String getJobNotes() {
        return jobNotes;
    }

    public void setJobNotes(String jobNotes) {
        this.jobNotes = safe(jobNotes);
        this.description = this.jobNotes;
    }

    public String getOriginStreet() {
        return originStreet;
    }

    public void setOriginStreet(String originStreet) {
        this.originStreet = safe(originStreet);
    }

    public String getOriginCity() {
        return originCity;
    }

    public void setOriginCity(String originCity) {
        this.originCity = safe(originCity);
    }

    public String getOriginState() {
        return originState;
    }

    public void setOriginState(String originState) {
        this.originState = safe(originState);
    }

    public String getOriginZip() {
        return originZip;
    }

    public void setOriginZip(String originZip) {
        this.originZip = safe(originZip);
    }

    public String getDestinationStreet() {
        return destinationStreet;
    }

    public void setDestinationStreet(String destinationStreet) {
        this.destinationStreet = safe(destinationStreet);
    }

    public String getDestinationCity() {
        return destinationCity;
    }

    public void setDestinationCity(String destinationCity) {
        this.destinationCity = safe(destinationCity);
    }

    public String getDestinationState() {
        return destinationState;
    }

    public void setDestinationState(String destinationState) {
        this.destinationState = safe(destinationState);
    }

    public String getDestinationZip() {
        return destinationZip;
    }

    public void setDestinationZip(String destinationZip) {
        this.destinationZip = safe(destinationZip);
    }

    public int getTruckId() {
        return truckId;
    }

    public void setTruckId(int truckId) {
        this.truckId = truckId;
    }

    public String getEmployeeIdsCsv() {
        return employeeIdsCsv;
    }

    public void setEmployeeIdsCsv(String employeeIdsCsv) {
        this.employeeIdsCsv = safe(employeeIdsCsv);
    }

    private String safe(String value) {
        return value == null ? "" : value.trim();
    }
}