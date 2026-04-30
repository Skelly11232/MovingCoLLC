package Calendar;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridLayout;
import java.time.LocalDate;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class Main {

    public static void main(String[] args) {
        System.out.println("MAIN STARTED");

        JFrame frame = new JFrame("MovingLLC Calendar");
        frame.setSize(1000, 600);
        frame.setLocationRelativeTo(null);
        frame.getContentPane().setBackground(Color.white);

        Database database = new Database();

        JPanel outerPanel = new JPanel(new BorderLayout());
        outerPanel.setBackground(Color.white);

        JButton inquiryButton = new JButton("Owner Inquiry Menu");
        inquiryButton.setBackground(Color.decode("#00d1e8"));
        inquiryButton.addActionListener(e -> new InquiryMenu(database));

        outerPanel.add(inquiryButton, BorderLayout.NORTH);

        JPanel mainPanel = new JPanel(new GridLayout(1, 2));

        LocalDate date = LocalDate.of(2026, 4, 1);

        mainPanel.add(new Calendar(date.getYear(), date.getMonthValue(), date, mainPanel, database));
        mainPanel.add(new Events(date, database, mainPanel));

        outerPanel.add(mainPanel, BorderLayout.CENTER);

        frame.getContentPane().add(outerPanel);
        frame.setVisible(true);
    }
}