DROP DATABASE IF EXISTS MovingLLC;
CREATE DATABASE MovingLLC;
USE MovingLLC;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    billing_street VARCHAR(255),
    billing_city VARCHAR(100),
    billing_state VARCHAR(50),
    billing_zip VARCHAR(10)
);

CREATE TABLE Quote (
    quote_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    quote_date DATE NOT NULL,
    quoted_hourly_rate DECIMAL(8,2),
    estimated_hours DECIMAL(5,2),
    crew_size INT,
    estimated_cost DECIMAL(10,2),
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Job (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    quote_id INT,
    move_date DATE NOT NULL,
    start_time TIME,
    job_status VARCHAR(30) NOT NULL CHECK (
        job_status IN ('Scheduled', 'In Progress', 'Completed', 'Cancelled')),
    crew_size INT,
    hourly_rate DECIMAL(8,2),
    estimated_hours DECIMAL(5,2),
    actual_hours DECIMAL(5,2),
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (quote_id) REFERENCES Quote(quote_id)
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    location_type VARCHAR(20) NOT NULL CHECK (
        location_type IN ('Origin', 'Destination', 'Storage')),
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    FOREIGN KEY (job_id) REFERENCES Job(job_id)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    role VARCHAR(50),
    hourly_rate DECIMAL(6,2),
    hire_date DATE,
    status VARCHAR(30) NOT NULL CHECK (
        status IN ('Active', 'Inactive', 'On Leave'))
);

CREATE TABLE Truck (
    truck_id INT PRIMARY KEY AUTO_INCREMENT,
    plate_num VARCHAR(20) NOT NULL UNIQUE,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT,
    truck_size_ft INT,
    max_load_lbs INT,
    status VARCHAR(30) NOT NULL CHECK (
        status IN ('Available', 'In Use', 'Maintenance', 'Out of Service'))
);

CREATE TABLE Job_Employee (
    job_id INT NOT NULL,
    employee_id INT NOT NULL,
    hours_worked DECIMAL(5,2),
    position_on_job VARCHAR(50),
    PRIMARY KEY (job_id, employee_id),
    FOREIGN KEY (job_id) REFERENCES Job(job_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Job_Truck (
    job_id INT NOT NULL,
    truck_id INT NOT NULL,
    miles DECIMAL(8,2),
    fuel_cost DECIMAL(8,2),
    PRIMARY KEY (job_id, truck_id),
    FOREIGN KEY (job_id) REFERENCES Job(job_id),
    FOREIGN KEY (truck_id) REFERENCES Truck(truck_id)
);

