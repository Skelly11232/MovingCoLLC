DROP DATABASE MovingLLC;
CREATE DATABASE MovingLLC;
USE MovingLLC;

CREATE TABLE Customer (
	customer_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    billing_address VARCHAR(255)
);

CREATE TABLE Quote (
	quote_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    quote_date DATE,
    estimated_cost DECIMAL(10,2),
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Job (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    quote_id INT,
    move_date DATE,
    start_time TIME,
    estimated_cost DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (quote_id) REFERENCES Quote(quote_id)
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    FOREIGN KEY (job_id) REFERENCES Job(job_id)
);

CREATE TABLE Invoice (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    date DATE,
    subtotal DECIMAL(10,2),
    tax DECIMAL(10,2),
    total DECIMAL(10,2),
    FOREIGN KEY (job_id) REFERENCES Job(job_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    date DATE,
    amount DECIMAL(10,2),
    payment_status VARCHAR(50),
    FOREIGN KEY (job_id) REFERENCES Job(job_id)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    role VARCHAR(50),
    hourly_rate DECIMAL(6,2),
    hire_date DATE,
    status VARCHAR(50)
);

CREATE TABLE Truck (
    truck_id INT PRIMARY KEY AUTO_INCREMENT,
    plate_num VARCHAR(20),
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    capacity INT
);

CREATE TABLE Job_Employee (
    job_employee_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    employee_id INT,
    hours_worked DECIMAL(5,2),
    position_on_job VARCHAR(50),
    FOREIGN KEY (job_id) REFERENCES Job(job_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    UNIQUE (job_id, employee_id)
);

CREATE TABLE Job_Truck (
    job_truck_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    truck_id INT,
    miles_used DECIMAL(8,2),
    fuel_cost DECIMAL(8,2),
    FOREIGN KEY (job_id) REFERENCES Job(job_id),
    FOREIGN KEY (truck_id) REFERENCES Truck(truck_id),
    UNIQUE (job_id, truck_id)
);

INSERT INTO Customer VALUES
(1, 'John', 'Doe', '1112223333', 'john@email.com', '123 Main St'),
(2, 'Sarah', 'Smith', '2223334444', 'sarah@email.com', '456 Oak Ave'),
(3, 'Mike', 'Johnson', '3334445555', 'mike@email.com', '789 Pine Rd'),
(4, 'Emily', 'Davis', '4445556666', 'emily@email.com', '321 Birch Ln'),
(5, 'Chris', 'Brown', '5556667777', 'chris@email.com', '654 Cedar St');

INSERT INTO Employee VALUES
(1, 'Jake', 'Miller', '1111111111', 'jake@email.com', 'Mover', 18.50, '2023-01-10', 'Active'),
(2, 'Tom', 'Wilson', '2222222222', 'tom@email.com', 'Driver', 22.00, '2022-06-15', 'Active'),
(3, 'Ryan', 'Moore', '3333333333', 'ryan@email.com', 'Mover', 17.75, '2024-02-20', 'Active'),
(4, 'Alex', 'Taylor', '4444444444', 'alex@email.com', 'Supervisor', 25.00, '2021-09-01', 'Active'),
(5, 'Nick', 'Anderson', '5555555555', 'nick@email.com', 'Mover', 18.00, '2023-07-12', 'Active');

INSERT INTO Truck VALUES
(1, 'ABC123', 'Ford', 'E-Series', 2018, 1000),
(2, 'DEF456', 'Chevy', 'Express', 2020, 1200),
(3, 'GHI789', 'GMC', 'Savana', 2019, 1100),
(4, 'JKL321', 'Ford', 'Transit', 2021, 1300),
(5, 'MNO654', 'Ram', 'ProMaster', 2022, 1250);

INSERT INTO Quote VALUES
(1, 1, '2026-03-01', 800.00, 'Local move'),
(2, 2, '2026-03-02', 1200.00, '2-bedroom move'),
(3, 3, '2026-03-03', 600.00, 'Small apartment'),
(4, 4, '2026-03-04', 1500.00, 'Long distance'),
(5, 5, '2026-03-05', 900.00, 'Standard move');

INSERT INTO Job VALUES
(1, 1, 1, '2026-03-10', '08:00:00', 800.00),
(2, 2, 2, '2026-03-11', '09:00:00', 1200.00),
(3, 3, 3, '2026-03-12', '10:00:00', 600.00),
(4, 4, 4, '2026-03-13', '07:30:00', 1500.00),
(5, 5, 5, '2026-03-14', '08:30:00', 900.00);

INSERT INTO Location VALUES
(1, 1, '100 A St', 'Davenport', 'IA', '52801'),
(2, 2, '200 B St', 'Bettendorf', 'IA', '52722'),
(3, 3, '300 C St', 'Moline', 'IL', '61265'),
(4, 4, '400 D St', 'Rock Island', 'IL', '61201'),
(5, 5, '500 E St', 'Davenport', 'IA', '52803');

INSERT INTO Invoice VALUES
(1, 1, '2026-03-10', 750.00, 50.00, 800.00),
(2, 2, '2026-03-11', 1100.00, 100.00, 1200.00),
(3, 3, '2026-03-12', 550.00, 50.00, 600.00),
(4, 4, '2026-03-13', 1400.00, 100.00, 1500.00),
(5, 5, '2026-03-14', 850.00, 50.00, 900.00);

INSERT INTO Payment VALUES
(1, 1, '2026-03-10', 800.00, 'Paid'),
(2, 2, '2026-03-11', 1200.00, 'Paid'),
(3, 3, '2026-03-12', 600.00, 'Pending'),
(4, 4, '2026-03-13', 1500.00, 'Paid'),
(5, 5, '2026-03-14', 900.00, 'Pending');

INSERT INTO Job_Employee VALUES
(1, 1, 1, 5.0, 'Mover'),
(2, 1, 2, 5.0, 'Driver'),
(3, 2, 3, 6.0, 'Mover'),
(4, 3, 4, 4.5, 'Supervisor'),
(5, 4, 5, 6.5, 'Mover');

INSERT INTO Job_Truck VALUES
(1, 1, 1, 20.5, 50.00),
(2, 2, 2, 35.0, 70.00),
(3, 3, 3, 15.0, 30.00),
(4, 4, 4, 60.0, 120.00),
(5, 5, 5, 25.0, 55.00);

