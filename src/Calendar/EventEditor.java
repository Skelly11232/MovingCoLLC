package Calendar;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JComboBox;

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
        frame.setSize(950, 800);
        frame.setLocationRelativeTo(parent);
        frame.getContentPane().setBackground(Color.white);

        JPanel mainPanel = new JPanel(new BorderLayout(20, 20));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(25, 25, 20, 25));
        mainPanel.setBackground(Color.white);

        JLabel heading = new JLabel(e.getID() > 0 ? "Edit Moving Job" : "Create Moving Job");
        heading.setFont(new Font("Helvetica", Font.BOLD, 28));
        heading.setHorizontalAlignment(JLabel.CENTER);
        heading.setForeground(Color.decode("#0ecf78"));
        mainPanel.add(heading, BorderLayout.NORTH);

        JPanel form = new JPanel(new GridLayout(0, 2, 12, 10));
        form.setBackground(Color.white);

        addSection(form, "Customer Information");
        JTextField firstName = addField(form, "First Name:", e.getCustomerFirstName());
        JTextField lastName = addField(form, "Last Name:", e.getCustomerLastName());
        JTextField phone = addField(form, "Phone Number:", e.getCustomerPhone());
        JTextField email = addField(form, "Email Address:", e.getCustomerEmail());

        addSection(form, "Move Schedule");
        JTextField time = addField(form, "Start Time (HH:mm):", e.getTimeToString());
        JComboBox<String> status = addSimpleDropdown(
                form,
                "Job Status:",
                new String[] {"Scheduled", "In Progress", "Completed", "Cancelled"},
                e.getJobStatus().isBlank() ? "Scheduled" : e.getJobStatus()
        );
        
        addSection(form, "Quote / Pricing");
        JTextField quotedRate = addField(form, "Hourly Rate:", doubleToText(e.getQuotedHourlyRate()));
        JTextField estimatedHours = addField(form, "Estimated Hours:", doubleToText(e.getEstimatedHours()));
        JTextField crewSize = addField(form, "Crew Size:", intToText(e.getCrewSize()));
        JTextField estimatedCost = addField(form, "Estimated Cost:", doubleToText(e.getEstimatedCost()));
        JTextField actualHours = addField(form, "Actual Hours:", doubleToText(e.getActualHours()));

        addSection(form, "Origin Address");
        JTextField originStreet = addField(form, "Pickup Street:", e.getOriginStreet());
        JTextField originCity = addField(form, "Pickup City:", e.getOriginCity());
        JTextField originState = addField(form, "Pickup State:", e.getOriginState());
        JTextField originZip = addField(form, "Pickup Zip:", e.getOriginZip());

        addSection(form, "Destination Address");
        JTextField destinationStreet = addField(form, "Drop-off Street:", e.getDestinationStreet());
        JTextField destinationCity = addField(form, "Drop-off City:", e.getDestinationCity());
        JTextField destinationState = addField(form, "Drop-off State:", e.getDestinationState());
        JTextField destinationZip = addField(form, "Drop-off Zip:", e.getDestinationZip());

        addSection(form, "Truck / Employee Assignment");
        JComboBox<String> truckDropdown = addDropdown(
                form,
                "Truck:",
                database.getTruckOptions(),
                e.getTruckId()
        );

        JComboBox<String> employee1 = addDropdown(
                form,
                "Employee 1:",
                database.getEmployeeOptions(),
                0
        );

        JComboBox<String> employee2 = addDropdown(
                form,
                "Employee 2:",
                database.getEmployeeOptions(),
                0
        );

        JComboBox<String> employee3 = addDropdown(
                form,
                "Employee 3:",
                database.getEmployeeOptions(),
                0
        );
        addSection(form, "Notes");
        JTextField quoteNotes = addField(form, "Quote Notes:", e.getQuoteNotes());
        JTextField jobNotes = addField(form, "Job Notes:", e.getJobNotes());

        JScrollPane scrollPane = new JScrollPane(form);
        scrollPane.setBorder(BorderFactory.createLineBorder(Color.decode("#f0f0f0")));
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        JPanel bottom = new JPanel(new GridLayout(1, 2, 20, 20));
        bottom.setBackground(Color.white);

        JButton delete = new JButton("Delete Job");
        delete.setFont(new Font("Helvetica", Font.PLAIN, 20));
        delete.setBackground(Color.decode("#f90069"));
        delete.setForeground(Color.white);
        delete.setBorder(BorderFactory.createEmptyBorder(12, 10, 12, 10));

        JButton save = new JButton(e.getID() > 0 ? "Update Job" : "Create Job");
        save.setFont(new Font("Helvetica", Font.PLAIN, 20));
        save.setBackground(Color.decode("#00d1e8"));
        save.setForeground(Color.black);
        save.setBorder(BorderFactory.createEmptyBorder(12, 10, 12, 10));

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
                    JOptionPane.showMessageDialog(null, "Pickup and drop-off street are required.");
                    return;
                }

                try {
                    e.setTime(time.getText());

                    e.setCustomerFirstName(firstName.getText());
                    e.setCustomerLastName(lastName.getText());
                    e.setCustomerPhone(phone.getText());
                    e.setCustomerEmail(email.getText());

                    e.setJobStatus(status.getSelectedItem().toString());
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

                    e.setTruckId(getSelectedId(truckDropdown));

                    String selectedEmployees = buildEmployeeCsv(employee1, employee2, employee3);
                    e.setEmployeeIdsCsv(selectedEmployees);
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
                parent.repaint();

                frame.dispose();
            }
        });

        delete.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent event) {
                int confirm = JOptionPane.showConfirmDialog(
                        null,
                        "Are you sure you want to delete this job?",
                        "Confirm Delete",
                        JOptionPane.YES_NO_OPTION
                );

                if (confirm != JOptionPane.YES_OPTION) {
                    return;
                }

                database.deleteEvent(e.getID());

                parent.removeAll();
                parent.add(new Calendar(year, month, e.getDate(), parent, database));
                parent.add(new Events(e.getDate(), database, parent));
                parent.revalidate();
                parent.repaint();

                frame.dispose();
            }
        });

        mainPanel.add(bottom, BorderLayout.SOUTH);

        frame.getContentPane().add(mainPanel);
        frame.setVisible(true);
    }

    private void addSection(JPanel panel, String title) {
        JLabel section = new JLabel(title);
        section.setFont(new Font("Helvetica", Font.BOLD, 20));
        section.setForeground(Color.decode("#0ecf78"));
        section.setBorder(BorderFactory.createEmptyBorder(15, 0, 5, 0));

        JLabel blank = new JLabel("");

        panel.add(section);
        panel.add(blank);
    }

    private JTextField addField(JPanel panel, String labelText, String value) {
        JLabel label = new JLabel(labelText);
        label.setFont(new Font("Helvetica", Font.PLAIN, 16));
        label.setHorizontalAlignment(JLabel.RIGHT);

        JTextField field = new JTextField(value == null ? "" : value);
        field.setFont(new Font("Helvetica", Font.PLAIN, 16));

        panel.add(label);
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
    private JComboBox<String> addDropdown(JPanel panel, String labelText, String[] options, int selectedId) {
        JLabel label = new JLabel(labelText);
        label.setFont(new Font("Helvetica", Font.PLAIN, 16));
        label.setHorizontalAlignment(JLabel.RIGHT);

        JComboBox<String> dropdown = new JComboBox<>(options);
        dropdown.setFont(new Font("Helvetica", Font.PLAIN, 16));

        if (selectedId > 0) {
            for (int i = 0; i < dropdown.getItemCount(); i++) {
                String item = dropdown.getItemAt(i);

                if (item.startsWith(selectedId + " -")) {
                    dropdown.setSelectedIndex(i);
                    break;
                }
            }
        }

        panel.add(label);
        panel.add(dropdown);

        return dropdown;
    }

    private JComboBox<String> addSimpleDropdown(JPanel panel, String labelText, String[] options, String selectedValue) {
        JLabel label = new JLabel(labelText);
        label.setFont(new Font("Helvetica", Font.PLAIN, 16));
        label.setHorizontalAlignment(JLabel.RIGHT);

        JComboBox<String> dropdown = new JComboBox<>(options);
        dropdown.setFont(new Font("Helvetica", Font.PLAIN, 16));
        dropdown.setSelectedItem(selectedValue);

        panel.add(label);
        panel.add(dropdown);

        return dropdown;
    }

    private int getSelectedId(JComboBox<String> dropdown) {
        Object selected = dropdown.getSelectedItem();

        if (selected == null) {
            return 0;
        }

        String value = selected.toString();

        if (value.isBlank()) {
            return 0;
        }

        return Integer.parseInt(value.split(" - ")[0]);
    }

    private String buildEmployeeCsv(JComboBox<String> employee1, JComboBox<String> employee2, JComboBox<String> employee3) {
        StringBuilder csv = new StringBuilder();

        addEmployeeToCsv(csv, getSelectedId(employee1));
        addEmployeeToCsv(csv, getSelectedId(employee2));
        addEmployeeToCsv(csv, getSelectedId(employee3));

        return csv.toString();
    }

    private void addEmployeeToCsv(StringBuilder csv, int id) {
        if (id <= 0) {
            return;
        }

        if (csv.length() > 0) {
            csv.append(",");
        }

        csv.append(id);
    }
}