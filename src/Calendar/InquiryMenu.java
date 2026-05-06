package Calendar;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class InquiryMenu {

    public InquiryMenu(Database database) {
        JFrame frame = new JFrame("Owner Inquiry Menu");
        frame.setSize(1000, 700);
        frame.setLocationRelativeTo(null);

        JPanel mainPanel = new JPanel(new BorderLayout(20, 20));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        mainPanel.setBackground(Color.white);

        JPanel buttons = new JPanel(new GridLayout(10, 1, 10, 10));
        buttons.setBackground(Color.white);

        JTextArea output = new JTextArea();
        output.setFont(new Font("Monospaced", Font.PLAIN, 14));
        output.setEditable(false);
        output.setText("Choose an inquiry to view owner-level business information.");

        JScrollPane scrollPane = new JScrollPane(output);

        JButton q1 = makeButton("1. Employee Hours(14d) - USE ON FRIDAY");
        JButton q2 = makeButton("2. Jobs Scheduled - Next 7 Days");
        JButton q3 = makeButton("3. Revenue From Completed Jobs - Current Month");
        JButton q4 = makeButton("4. Current Scheduled Jobs");
        JButton q5 = makeButton("5. Truck Used");
        JButton q6 = makeButton("6. Customers That Have Jobs");
        JButton q7 = makeButton("7. # of Zip Codes");
        JButton q8 = makeButton("8. Avg Cost by Crew Size");
        JButton q9 = makeButton("9. Customers with Completed Jobs");
        JButton q10 = makeButton("10. Samantha Foley Job Info");

        q1.addActionListener(e -> output.setText(database.getEmployeeHoursLastTwoWeeks()));
        q2.addActionListener(e -> output.setText(database.getUpcomingJobsNextSevenDays()));
        q3.addActionListener(e -> output.setText(database.getMonthlyCompletedRevenue()));
        q4.addActionListener(e -> output.setText(database.getEmployeeCurrentJobs()));
        q5.addActionListener(e -> output.setText(database.getTruckUsed()));
        q6.addActionListener(e -> output.setText(database.getCustomersThatHaveJobs()));
        q7.addActionListener(e -> output.setText(database.getNumOfCUstomersByZIP()));
        q8.addActionListener(e -> output.setText(database.getEstimatedCostPerCrewSize()));
        q9.addActionListener(e -> output.setText(database.getCustomersWithCompleted()));
        q10.addActionListener(e -> output.setText(database.getFindSFoley()));

        buttons.add(q1);
        buttons.add(q2);
        buttons.add(q3);
        buttons.add(q4);
        buttons.add(q5);
        buttons.add(q6);
        buttons.add(q7);
        buttons.add(q8);
        buttons.add(q9);
        buttons.add(q10);

        mainPanel.add(buttons, BorderLayout.WEST);
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        frame.getContentPane().add(mainPanel);
        frame.setVisible(true);
    }

    private JButton makeButton(String text) {
        JButton button = new JButton(text);
        button.setFont(new Font("Helvetica", Font.PLAIN, 16));
        button.setBackground(Color.decode("#00d1e8"));
        button.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        return button;
    }
}