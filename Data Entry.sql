USE MovingLLC;

INSERT INTO Customer
(first_name, last_name, phone, email, billing_street, billing_city, billing_state, billing_zip)
VALUES
('Ethan', 'Carlson', '6085551011', 'ethan.carlson@email.com', '1017 7th St S', 'La Crosse', 'WI', '54601'),
('Megan', 'Hoffman', '6085551012', 'megan.hoffman@email.com', '1452 George St', 'La Crosse', 'WI', '54603'),
('Tyler', 'Brennan', '6085551013', 'tyler.brennan@email.com', '1303 Hagar St', 'La Crosse', 'WI', '54603'),
('Alyssa', 'Wright', '6085551014', 'alyssa.wright@email.com', '1059 La Crosse St', 'Onalaska', 'WI', '54650'),
('Jordan', 'Miller', '6085551015', 'jordan.miller@email.com', '1220 Green St', 'Onalaska', 'WI', '54650');


INSERT INTO Quote
(customer_id, quote_date, quoted_hourly_rate, estimated_hours, crew_size, estimated_cost, notes)
VALUES
(1, '2026-04-01', 145.00, 4.50, 2, 652.50, '1-bedroom apartment local move'),
(2, '2026-04-03', 185.00, 6.00, 3, 1110.00, '3-bedroom home move across town'),
(3, '2026-04-04', 145.00, 3.50, 2, 507.50, 'Small apartment to duplex'),
(4, '2026-04-06', 185.00, 7.00, 3, 1295.00, 'House move from Onalaska to La Crosse'),
(5, '2026-04-07', 225.00, 8.00, 4, 1800.00, 'Large family move with extra heavy furniture');


INSERT INTO Job
(customer_id, quote_id, move_date, start_time, job_status, crew_size, hourly_rate, estimated_hours, actual_hours, notes)
VALUES
(1, 1, '2026-04-15', '08:00:00', 'Completed',   2, 145.00, 4.50, 4.25, 'Completed without damage'),
(2, 2, '2026-04-16', '09:00:00', 'Scheduled',   3, 185.00, 6.00, NULL, 'Customer requested wardrobe boxes'),
(3, 3, '2026-04-17', '08:30:00', 'In Progress', 2, 145.00, 3.50, 2.00, 'Crew currently loading origin'),
(4, 4, '2026-04-18', '07:30:00', 'Scheduled',   3, 185.00, 7.00, NULL, 'Includes one piano'),
(5, 5, '2026-04-19', '07:00:00', 'Cancelled',   4, 225.00, 8.00, NULL, 'Customer rescheduled for next month');


INSERT INTO Location
(job_id, location_type, street, city, state, zip_code)
VALUES
(1, 'Origin',      '1017 7th St S',      'La Crosse', 'WI', '54601'),
(1, 'Destination', '1224 7th St S',      'La Crosse', 'WI', '54601'),

(2, 'Origin',      '1452 George St',     'La Crosse', 'WI', '54603'),
(2, 'Destination', '3144 25th St S',     'La Crosse', 'WI', '54601'),

(3, 'Origin',      '1303 Hagar St',      'La Crosse', 'WI', '54603'),
(3, 'Destination', '919 St Cloud St',    'La Crosse', 'WI', '54603'),

(4, 'Origin',      '1059 La Crosse St',  'Onalaska',  'WI', '54650'),
(4, 'Destination', '3810 Sunnyside Dr',  'La Crosse', 'WI', '54601'),

(5, 'Origin',      '1220 Green St',      'Onalaska',  'WI', '54650'),
(5, 'Destination', '404 4th Ave N',      'Onalaska',  'WI', '54650');


INSERT INTO Employee
(first_name, last_name, phone, email, role, hourly_rate, hire_date, status)
VALUES
('Jake',   'Morrison', '6085552011', 'jake.morrison@movingllc.com',   'Mover',      19.50, '2023-05-10', 'Active'),
('Luis',   'Ramirez',  '6085552012', 'luis.ramirez@movingllc.com',    'Driver',     23.00, '2022-08-14', 'Active'),
('Noah',   'Peterson', '6085552013', 'noah.peterson@movingllc.com',   'Mover',      18.75, '2024-01-22', 'Active'),
('Caleb',  'Jensen',   '6085552014', 'caleb.jensen@movingllc.com',    'Crew Lead',  25.50, '2021-11-03', 'Active'),
('Marcus', 'Lee',      '6085552015', 'marcus.lee@movingllc.com',      'Mover',      18.25, '2024-06-18', 'On Leave'),
('Owen',   'Schmidt',  '6085552016', 'owen.schmidt@movingllc.com',    'Driver',     22.50, '2023-02-27', 'Inactive');


INSERT INTO Truck
(plate_num, make, model, year, truck_size_ft, max_load_lbs, status)
VALUES
('MVC101', 'Ford',         'E-350 Box Truck',      2021, 10, 2800,  'Available'),
('MVC215', 'GMC',          'Savana Box Truck',     2020, 15, 6385,  'In Use'),
('MVC320', 'Isuzu',        'NPR HD Box Truck',     2022, 20, 5500,  'Available'),
('MVC426', 'International', 'MV Box Truck',        2023, 26, 12859, 'Maintenance');


INSERT INTO Job_Employee
(job_id, employee_id, hours_worked, position_on_job)
VALUES
(1, 1, 4.25, 'Mover'),
(1, 2, 4.25, 'Driver'),

(2, 1, 0.00, 'Mover'),
(2, 3, 0.00, 'Mover'),
(2, 4, 0.00, 'Crew Lead'),

(3, 2, 2.00, 'Driver'),
(3, 3, 2.00, 'Mover'),

(4, 1, 0.00, 'Mover'),
(4, 2, 0.00, 'Driver'),
(4, 4, 0.00, 'Crew Lead'),

(5, 1, 0.00, 'Mover'),
(5, 2, 0.00, 'Driver'),
(5, 3, 0.00, 'Mover'),
(5, 4, 0.00, 'Crew Lead');


INSERT INTO Job_Truck
(job_id, truck_id, miles, fuel_cost)
VALUES
(1, 1, 12.40, 18.75),
(2, 2, 0.00,  0.00),
(3, 2, 7.80,  11.20),
(4, 3, 0.00,  0.00),
(5, 4, 0.00,  0.00);