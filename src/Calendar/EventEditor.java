package Calendar;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

public class EventEditor {

    public EventEditor(Event e, Database database, JPanel parent) {
        int year = e.getDate().getYear();
        int month = e.getDate().getMonthValue();

        JFrame frame = new JFrame(e.getID() > 0 ? "Edit Moving Job" : "Create Moving Job");
        frame.setSize(850, 750);
        frame.setLocationRelativeTo(parent);
        frame.getContentPane().setBackground(Color.white);

        JPanel mainPanel = new JPanel(new BorderLayout(20, 20));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(25, 20, 20, 20));
        mainPanel.setBackground(Color.white);

        JLabel heading = new JLabel(e.getID() > 0 ? "Edit Moving Job" : "Create Moving Job");
        heading.setFont(new Font("Helvetica", Font.BOLD, 26));
        heading.setHorizontalAlignment(JLabel.CENTER);

        mainPanel.add(heading, BorderLayout.NORTH);

        JPanel center = new JPanel(new GridLayout(24, 2, 12, 10));
        center.setBackground(Color.white);

        JTextField firstName = addField(center, "Customer First Name:", e.getCustomerFirstName());
        JTextField lastName = addField(center, "Customer Last Name:", e.getCustomerLastName());
        JTextField phone = addField(center, "Customer Phone:", e.getCustomerPhone());
        JTextField email = addField(center, "Customer Email:", e.getCustomerEmail());

        JTextField time = addField(center, "Start Time (HH:mm):", e.getTimeToString());
        JTextField status = addField(center, "Job Status:", e.getJobStatus().isBlank() ? "Scheduled" : e.getJobStatus());

        JTextField quotedRate = addField(center, "Hourly Rate:", doubleToText(e.getQuotedHourlyRate()));
        JTextField estimatedHours = addField(center, "Estimated Hours:", doubleToText(e.getEstimatedHours()));
        JTextField crewSize = addField(center, "Crew Size:", intToText(e.getCrewSize()));
        JTextField estimatedCost = addField(center, "Estimated Cost:", doubleToText(e.getEstimatedCost()));
        JTextField actualHours = addField(center, "Actual Hours:", doubleToText(e.getActualHours()));

        JTextField originStreet = addField(center, "Origin Street:", e.getOriginStreet());
        JTextField originCity = addField(center, "Origin City:", e.getOriginCity());
        JTextField originState = addField(center, "Origin State:", e.getOriginState());
        JTextField originZip = addField(center, "Origin Zip:", e.getOriginZip());

        JTextField destinationStreet = addField(center, "Destination Street:", e.getDestinationStreet());
        JTextField destinationCity = addField(center, "Destination City:", e.getDestinationCity());
        JTextField destinationState = addField(center, "Destination State:", e.getDestinationState());
        JTextField destinationZip = addField(center, "Destination Zip:", e.getDestinationZip());

        JTextField truckId = addField(center, "Truck ID:", e.getTruckId() > 0 ? String.valueOf(e.getTruckId()) : "");
        JTextField employeeIds = addField(center, "Employee IDs CSV:", e.getEmployeeIdsCsv());

        JTextField quoteNotes = addField(center, "Quote Notes:", e.getQuoteNotes());
        JTextField jobNotes = addField(center, "Job Notes:", e.getJobNotes());

        JScrollPane scrollPane = new JScrollPane(center);
        scrollPane.setBorder(null);

        mainPanel.add(scrollPane, BorderLayout.CENTER);

        JPanel bottom = new JPanel(new GridLayout(1, 2, 20, 20));
        bottom.setBackground(null);

        JButton delete = new JButton("Delete");
        delete.setFont(new Font("Helvetica", Font.PLAIN, 20));
        delete.setBackground(Color.decode("#00d1e8"));
        delete.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        JButton save = new JButton("Save");
        save.setFont(new Font("Helvetica", Font.PLAIN, 20));
        save.setBackground(Color.decode("#00d1e8"));
        save.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        bottom.add(delete);
        bottom.add(save);

        if (e.getID() <= 0) {
            delete.setVisible(false);
        }

        save.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent event) {
                if (firstName.getText().isBlank() || lastName.getText().isBlank()) {
                    JOptionPane.showMessageDialog(null, "Customer first and last name are required.");
                    return;
                }

                if (originStreet.getText().isBlank() || destinationStreet.getText().isBlank()) {
                    JOptionPane.showMessageDialog(null, "Origin and destination street are required.");
                    return;
                }

                try {
                    e.setTime(time.getText());

                    e.setCustomerFirstName(firstName.getText());
                    e.setCustomerLastName(lastName.getText());
                    e.setCustomerPhone(phone.getText());
                    e.setCustomerEmail(email.getText());

                    e.setJobStatus(status.getText().isBlank() ? "Scheduled" : status.getText());

                    e.setQuotedHourlyRate(parseDouble(quotedRate.getText()));
                    e.setEstimatedHours(parseDouble(estimatedHours.getText()));
                    e.setCrewSize(parseInt(crewSize.getText()));
                    e.setEstimatedCost(parseDouble(estimatedCost.getText()));
                    e.setActualHours(parseDouble(actualHours.getText()));

                    e.setOriginStreet(originStreet.getText());
                    e.setOriginCity(originCity.getText());
                    e.setOriginState(originState.getText());
                    e.setOriginZip(originZip.getText());

                    e.setDestinationStreet(destinationStreet.getText());
                    e.setDestinationCity(destinationCity.getText());
                    e.setDestinationState(destinationState.getText());
                    e.setDestinationZip(destinationZip.getText());

                    e.setTruckId(parseInt(truckId.getText()));
                    e.setEmployeeIdsCsv(employeeIds.getText());

                    e.setQuoteNotes(quoteNotes.getText());
                    e.setJobNotes(jobNotes.getText());

                    e.setTitle("Move for " + e.getCustomerFirstName() + " " + e.getCustomerLastName());
                    e.setDescription(e.getJobNotes());

                } catch (Exception exception) {
                    JOptionPane.showMessageDialog(null, "Check number fields and time format HH:mm.");
                    return;
                }

                if (e.getID() > 0) {
                    database.updateEvent(e);
                } else {
                    database.createEvent(e);
                }

                parent.removeAll();
                parent.add(new Calendar(year, month, e.getDate(), parent, database));
                parent.add(new Events(e.getDate(), database, parent));
                parent.revalidate();

                frame.dispose();
            }
        });

        delete.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent event) {
                database.deleteEvent(e.getID());

                parent.removeAll();
                parent.add(new Calendar(year, month, e.getDate(), parent, database));
                parent.add(new Events(e.getDate(), database, parent));
                parent.revalidate();

                frame.dispose();
            }
        });

        mainPanel.add(bottom, BorderLayout.SOUTH);

        frame.getContentPane().add(mainPanel);
        frame.setVisible(true);
    }

    private JTextField addField(JPanel panel, String labelText, String value) {
        JLabel label = new JLabel(labelText);
        label.setFont(new Font("Helvetica", Font.PLAIN, 16));
        label.setHorizontalAlignment(JLabel.RIGHT);

        panel.add(label);

        JTextField field = new JTextField(value == null ? "" : value);
        field.setFont(new Font("Helvetica", Font.PLAIN, 16));

        panel.add(field);

        return field;
    }

    private String doubleToText(double value) {
        return value == 0 ? "" : String.valueOf(value);
    }

    private String intToText(int value) {
        return value == 0 ? "" : String.valueOf(value);
    }

    private double parseDouble(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }

        return Double.parseDouble(value.trim());
    }

    private int parseInt(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }

        return Integer.parseInt(value.trim());
    }
}