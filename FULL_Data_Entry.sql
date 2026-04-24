USE neudahl2130_MovingLLC;


-- ============================================================
-- CLEAN RESET OF DATA
-- This clears the MovingLLC transaction/customer data before inserting fresh rows.
-- It preserves Employee and Truck rows because the inserts below reference employee_id 1-5
-- and truck_id 1-4.
-- ============================================================
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM Job_Truck;
DELETE FROM Job_Employee;
DELETE FROM Location;
DELETE FROM Job;
DELETE FROM Quote;
DELETE FROM Customer;
DELETE FROM Employee;
DELETE FROM Truck;

ALTER TABLE Customer AUTO_INCREMENT = 1;
ALTER TABLE Quote AUTO_INCREMENT = 1;
ALTER TABLE Job AUTO_INCREMENT = 1;
ALTER TABLE Location AUTO_INCREMENT = 1;
ALTER TABLE Job_Employee AUTO_INCREMENT = 1;
ALTER TABLE Job_Truck AUTO_INCREMENT = 1;
ALTER TABLE Employee AUTO_INCREMENT = 1;
ALTER TABLE Truck AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;

-- ============================================================
-- 50 Customers (customer_id 1–50 after AUTO_INCREMENT reset)
-- ============================================================
INSERT INTO Customer
(first_name, last_name, phone, email, billing_street, billing_city, billing_state, billing_zip)
VALUES
('Brittany', 'Hayes',      '6085551016', 'brittany.hayes@email.com',      '233 King St',           'La Crosse',  'WI', '54601'),
('Derek',    'Schultz',    '6085551017', 'derek.schultz@email.com',        '710 Caledonia St',      'La Crosse',  'WI', '54603'),
('Samantha', 'Turner',     '6085551018', 'samantha.turner@email.com',      '418 Market St',         'La Crosse',  'WI', '54601'),
('Ryan',     'Nelson',     '6085551019', 'ryan.nelson@email.com',          '2204 Weston St',        'Onalaska',   'WI', '54650'),
('Ashley',   'Cooper',     '6085551020', 'ashley.cooper@email.com',        '3301 Losey Blvd S',     'La Crosse',  'WI', '54601'),
('Brandon',  'Evans',      '6085551021', 'brandon.evans@email.com',        '1820 Redfield St',      'La Crosse',  'WI', '54603'),
('Jessica',  'Parker',     '6085551022', 'jessica.parker@email.com',       '907 Rose St',           'La Crosse',  'WI', '54601'),
('Kyle',     'Anderson',   '6085551023', 'kyle.anderson@email.com',        '545 Vine St',           'La Crosse',  'WI', '54601'),
('Lauren',   'Mitchell',   '6085551024', 'lauren.mitchell@email.com',      '2710 East Ave S',       'La Crosse',  'WI', '54601'),
('Travis',   'Roberts',    '6085551025', 'travis.roberts@email.com',       '1105 Cass St',          'La Crosse',  'WI', '54601'),
('Heather',  'Clark',      '6085551026', 'heather.clark@email.com',        '330 N 9th St',          'La Crosse',  'WI', '54601'),
('Nathan',   'White',      '6085551027', 'nathan.white@email.com',         '4412 Mormon Coulee Rd', 'La Crosse',  'WI', '54601'),
('Stephanie','Lewis',      '6085551028', 'stephanie.lewis@email.com',      '612 Birch St',          'Onalaska',   'WI', '54650'),
('Adam',     'Harris',     '6085551029', 'adam.harris@email.com',          '1501 Park Ave',         'La Crosse',  'WI', '54601'),
('Melissa',  'Walker',     '6085551030', 'melissa.walker@email.com',       '220 S 6th St',          'La Crosse',  'WI', '54601'),
('Justin',   'Hall',       '6085551031', 'justin.hall@email.com',          '3808 Oak Forest Dr',    'Onalaska',   'WI', '54650'),
('Amanda',   'Young',      '6085551032', 'amanda.young@email.com',         '714 Ferry St',          'La Crosse',  'WI', '54601'),
('Scott',    'Allen',      '6085551033', 'scott.allen@email.com',          '1928 Clinton St',       'La Crosse',  'WI', '54601'),
('Nicole',   'King',       '6085551034', 'nicole.king@email.com',          '503 Grandview Blvd',    'La Crosse',  'WI', '54601'),
('Patrick',  'Wright',     '6085551035', 'patrick.wright@email.com',       '2044 Farnam St',        'Onalaska',   'WI', '54650'),
('Rachel',   'Scott',      '6085551036', 'rachel.scott@email.com',         '817 Pine St',           'La Crosse',  'WI', '54601'),
('Eric',     'Green',      '6085551037', 'eric.green@email.com',           '1312 Loomis St',        'La Crosse',  'WI', '54603'),
('Megan',    'Adams',      '6085551038', 'megan.adams@email.com',          '2218 Charles St',       'La Crosse',  'WI', '54601'),
('Kevin',    'Baker',      '6085551039', 'kevin.baker@email.com',          '409 Jay St',            'La Crosse',  'WI', '54601'),
('Danielle', 'Gonzalez',   '6085551040', 'danielle.gonzalez@email.com',    '1614 Wilson St',        'Onalaska',   'WI', '54650'),
('Cody',     'Perez',      '6085551041', 'cody.perez@email.com',           '733 Sill St',           'La Crosse',  'WI', '54601'),
('Kayla',    'Campbell',   '6085551042', 'kayla.campbell@email.com',       '2905 S 28th St',        'La Crosse',  'WI', '54601'),
('Zachary',  'Carter',     '6085551043', 'zachary.carter@email.com',       '1108 Market St',        'La Crosse',  'WI', '54601'),
('Brittney', 'Stewart',    '6085551044', 'brittney.stewart@email.com',     '316 N 5th St',          'La Crosse',  'WI', '54601'),
('Alex',     'Morris',     '6085551045', 'alex.morris@email.com',          '4210 Bainbridge St',    'Onalaska',   'WI', '54650'),
('Tiffany',  'Rogers',     '6085551046', 'tiffany.rogers@email.com',       '625 Badger St',         'La Crosse',  'WI', '54601'),
('Dustin',   'Reed',       '6085551047', 'dustin.reed@email.com',          '1721 Kane St',          'La Crosse',  'WI', '54603'),
('Courtney', 'Cook',       '6085551048', 'courtney.cook@email.com',        '882 Wilder St',         'La Crosse',  'WI', '54601'),
('Shane',    'Morgan',     '6085551049', 'shane.morgan@email.com',         '2530 Liberty St',       'Onalaska',   'WI', '54650'),
('Kimberly', 'Bell',       '6085551050', 'kimberly.bell@email.com',        '1044 Ferry St',         'La Crosse',  'WI', '54601'),
('Trevor',   'Murphy',     '6085551051', 'trevor.murphy@email.com',        '3107 Hillview Dr',      'La Crosse',  'WI', '54601'),
('Amber',    'Bailey',     '6085551052', 'amber.bailey@email.com',         '456 N Front St',        'La Crosse',  'WI', '54601'),
('Garrett',  'Rivera',     '6085551053', 'garrett.rivera@email.com',       '1890 State Rd 33',      'Onalaska',   'WI', '54650'),
('Lindsey',  'Cooper',     '6085551054', 'lindsey.cooper2@email.com',      '723 Division St',       'La Crosse',  'WI', '54603'),
('Marcus',   'Flores',     '6085551055', 'marcus.flores@email.com',        '2414 West Ave N',       'La Crosse',  'WI', '54601'),
('Vanessa',  'Hughes',     '6085551056', 'vanessa.hughes@email.com',       '517 Copeland Ave',      'La Crosse',  'WI', '54603'),
('Blake',    'Washington', '6085551057', 'blake.washington@email.com',     '3629 Oak St',           'Onalaska',   'WI', '54650'),
('Sierra',   'Sanders',    '6085551058', 'sierra.sanders@email.com',       '1203 Hood St',          'La Crosse',  'WI', '54601'),
('Dillon',   'Price',      '6085551059', 'dillon.price@email.com',         '844 George St',         'La Crosse',  'WI', '54603'),
('Miranda',  'Bennett',    '6085551060', 'miranda.bennett@email.com',      '2701 W Avenue S',       'La Crosse',  'WI', '54601'),
('Hunter',   'Coleman',    '6085551061', 'hunter.coleman@email.com',       '1336 Cameron Ave',      'La Crosse',  'WI', '54601'),
('Paige',    'Jenkins',    '6085551062', 'paige.jenkins@email.com',        '415 Denton St',         'Onalaska',   'WI', '54650'),
('Colton',   'Perry',      '6085551063', 'colton.perry@email.com',         '2008 Market St',        'La Crosse',  'WI', '54601'),
('Alexis',   'Patterson',  '6085551064', 'alexis.patterson@email.com',     '913 Jackson St',        'La Crosse',  'WI', '54601'),
('Bryce',    'Long',       '6085551065', 'bryce.long@email.com',           '3322 Losey Blvd N',     'La Crosse',  'WI', '54601');


-- ============================================================
-- Quotes (quote_id 1–50, one per customer)
-- Rates: 2-person=$145, 3-person=$185, 4-person=$225
-- ============================================================
INSERT INTO Quote
(customer_id, quote_date, quoted_hourly_rate, estimated_hours, crew_size, estimated_cost, notes)
VALUES
(1,  '2026-04-08', 145.00, 3.00, 2,  435.00,  '1-bedroom apartment, local move'),
(2,  '2026-04-08', 185.00, 5.50, 3,  1017.50, '2-bedroom house across town'),
(3,  '2026-04-09', 145.00, 4.00, 2,  580.00,  'Studio to 1-bedroom upgrade'),
(4,  '2026-04-09', 185.00, 6.50, 3,  1202.50, '3-bedroom home, Onalaska to La Crosse'),
(5, '2026-04-10', 225.00, 9.00, 4,  2025.00, 'Large 4-bedroom family move'),
(6, '2026-04-10', 145.00, 3.50, 2,  507.50,  '1-bedroom apartment to duplex'),
(7, '2026-04-11', 185.00, 7.00, 3,  1295.00, '3-bedroom home with lots of boxes'),
(8, '2026-04-11', 145.00, 4.50, 2,  652.50,  '2-bedroom apartment local move'),
(9, '2026-04-12', 185.00, 5.00, 3,  925.00,  '2-bedroom home, La Crosse to Onalaska'),
(10, '2026-04-12', 225.00, 8.50, 4,  1912.50, 'Full home move, large appliances included'),
(11, '2026-04-13', 145.00, 2.50, 2,  362.50,  'Small apartment, minimal furniture'),
(12, '2026-04-13', 185.00, 6.00, 3,  1110.00, '3-bedroom home, same city'),
(13, '2026-04-14', 145.00, 4.00, 2,  580.00,  '2-bedroom apartment, cross-town move'),
(14, '2026-04-14', 185.00, 5.50, 3,  1017.50, '2-bedroom home with garage contents'),
(15, '2026-04-15', 225.00, 10.00,4,  2250.00, '5-bedroom home, heavy specialty items'),
(16, '2026-04-15', 145.00, 3.00, 2,  435.00,  '1-bedroom apartment, local'),
(17, '2026-04-16', 185.00, 6.50, 3,  1202.50, '3-bedroom home, Onalaska to La Crosse'),
(18, '2026-04-16', 145.00, 3.50, 2,  507.50,  'Duplex move, moderate furniture'),
(19, '2026-04-17', 145.00, 4.00, 2,  580.00,  '1-bedroom with home office equipment'),
(20, '2026-04-17', 185.00, 7.50, 3,  1387.50, '3-bedroom home, includes greenhouse items'),
(21, '2026-04-18', 145.00, 2.50, 2,  362.50,  'Small studio apartment'),
(22, '2026-04-18', 185.00, 5.00, 3,  925.00,  '2-bedroom apartment, La Crosse'),
(23, '2026-04-19', 225.00, 8.00, 4,  1800.00, '4-bedroom home, includes workshop tools'),
(24, '2026-04-20', 145.00, 3.00, 2,  435.00,  '1-bedroom condo move'),
(25, '2026-04-20', 185.00, 6.00, 3,  1110.00, '3-bedroom home across town'),
(26, '2026-04-21', 145.00, 4.50, 2,  652.50,  '2-bedroom apartment'),
(27, '2026-04-21', 185.00, 5.50, 3,  1017.50, '2-bedroom home, La Crosse to Onalaska'),
(28, '2026-04-22', 225.00, 9.50, 4,  2137.50, 'Large home move with antiques'),
(29, '2026-04-22', 145.00, 3.50, 2,  507.50,  '1-bedroom apartment'),
(30, '2026-04-23', 185.00, 6.50, 3,  1202.50, '3-bedroom home, same city'),
(31, '2026-04-23', 145.00, 4.00, 2,  580.00,  '2-bedroom apartment, local move'),
(32, '2026-04-24', 185.00, 7.00, 3,  1295.00, '3-bedroom home with two flights of stairs'),
(33, '2026-04-24', 145.00, 3.00, 2,  435.00,  '1-bedroom apartment to duplex'),
(34, '2026-04-25', 225.00, 8.50, 4,  1912.50, '4-bedroom family home, piano included'),
(35, '2026-04-25', 145.00, 2.50, 2,  362.50,  'Small studio, minimal belongings'),
(36, '2026-04-26', 185.00, 6.00, 3,  1110.00, '3-bedroom home, Onalaska'),
(37, '2026-04-26', 145.00, 4.00, 2,  580.00,  '2-bedroom apartment'),
(38, '2026-04-27', 185.00, 5.50, 3,  1017.50, '2-bedroom home, La Crosse'),
(39, '2026-04-27', 225.00, 9.00, 4,  2025.00, 'Full large home move'),
(40, '2026-04-28', 145.00, 3.50, 2,  507.50,  '1-bedroom apartment'),
(41, '2026-04-28', 185.00, 6.50, 3,  1202.50, '3-bedroom home'),
(42, '2026-04-29', 145.00, 4.50, 2,  652.50,  '2-bedroom apartment with storage unit'),
(43, '2026-04-29', 185.00, 5.00, 3,  925.00,  '2-bedroom home across town'),
(44, '2026-04-30', 225.00, 10.00,4,  2250.00, '5-bedroom home, large specialty furniture'),
(45, '2026-04-30', 145.00, 3.00, 2,  435.00,  '1-bedroom local move'),
(46, '2026-05-01', 185.00, 7.00, 3,  1295.00, '3-bedroom home, La Crosse to Onalaska'),
(47, '2026-05-01', 145.00, 3.50, 2,  507.50,  '1-bedroom apartment'),
(48, '2026-05-02', 185.00, 6.00, 3,  1110.00, '2-bedroom home with garage'),
(49, '2026-05-02', 145.00, 4.00, 2,  580.00,  '2-bedroom apartment'),
(50, '2026-05-03', 225.00, 8.00, 4,  1800.00, '4-bedroom family move');


-- ============================================================
-- Jobs (job_id 1–50)
-- Statuses spread across: Completed, Scheduled, In Progress, Cancelled
-- ============================================================
INSERT INTO Job
(customer_id, quote_id, move_date, start_time, job_status, crew_size, hourly_rate, estimated_hours, actual_hours, notes)
VALUES
(1,  1,  '2026-04-22', '08:00:00', 'Completed',   2, 145.00, 3.00,  3.25,  'Smooth move, no issues'),
(2,  2,  '2026-04-22', '09:00:00', 'Completed',   3, 185.00, 5.50,  5.75,  'Took slightly longer due to narrow stairwell'),
(3,  3,  '2026-04-23', '08:00:00', 'Completed',   2, 145.00, 4.00,  3.75,  'Finished early, customer very satisfied'),
(4,  4,  '2026-04-23', '07:30:00', 'Completed',   3, 185.00, 6.50,  6.25,  'Piano moved without damage'),
(5, 5, '2026-04-24', '07:00:00', 'Completed',   4, 225.00, 9.00,  9.50,  'Extra box count added time'),
(6, 6, '2026-04-24', '08:30:00', 'Completed',   2, 145.00, 3.50,  3.50,  'Right on estimate'),
(7, 7, '2026-04-25', '08:00:00', 'Completed',   3, 185.00, 7.00,  6.75,  'Crew worked efficiently'),
(8, 8, '2026-04-25', '09:00:00', 'Completed',   2, 145.00, 4.50,  4.50,  'No issues'),
(9, 9, '2026-04-26', '08:00:00', 'Completed',   3, 185.00, 5.00,  5.25,  'Minor delay due to elevator wait'),
(10, 10, '2026-04-26', '07:00:00', 'Completed',   4, 225.00, 8.50,  8.00,  'Large crew handled appliances well'),
(11, 11, '2026-04-27', '09:00:00', 'Completed',   2, 145.00, 2.50,  2.25,  'Fast move, minimal items'),
(12, 12, '2026-04-27', '08:00:00', 'Completed',   3, 185.00, 6.00,  6.50,  'Customer requested extra care for artwork'),
(13, 13, '2026-04-28', '08:30:00', 'Completed',   2, 145.00, 4.00,  4.25,  'Cross-town move, light traffic'),
(14, 14, '2026-04-28', '08:00:00', 'Completed',   3, 185.00, 5.50,  5.00,  'Efficient crew'),
(15, 15, '2026-04-29', '07:00:00', 'Completed',   4, 225.00, 10.00, 10.50, 'Long day, specialty furniture required extra care'),
(16, 16, '2026-04-30', '08:00:00', 'Completed',   2, 145.00, 3.00,  3.00,  'Smooth and fast'),
(17, 17, '2026-04-30', '09:00:00', 'Completed',   3, 185.00, 6.50,  6.00,  'Finished under estimate'),
(18, 18, '2026-05-01', '08:00:00', 'Completed',   2, 145.00, 3.50,  3.75,  'Slight delay finding parking'),
(19, 19, '2026-05-01', '09:00:00', 'Completed',   2, 145.00, 4.00,  4.00,  'On-time, customer happy'),
(20, 20, '2026-05-02', '07:30:00', 'Completed',   3, 185.00, 7.50,  7.25,  'Greenhouse items required extra wrapping'),
(21, 21, '2026-05-02', '09:00:00', 'Completed',   2, 145.00, 2.50,  2.50,  'Quick move'),
(22, 22, '2026-05-03', '08:00:00', 'Completed',   3, 185.00, 5.00,  5.25,  'Building elevator caused brief delay'),
(23, 23, '2026-05-03', '07:00:00', 'Completed',   4, 225.00, 8.00,  8.50,  'Workshop tools added significant weight'),
(24, 24, '2026-05-04', '08:30:00', 'Completed',   2, 145.00, 3.00,  3.00,  'Clean easy move'),
(25, 25, '2026-05-04', '08:00:00', 'Completed',   3, 185.00, 6.00,  6.25,  'Good communication with customer'),
-- In Progress jobs
(26, 26, '2026-05-05', '08:00:00', 'In Progress', 2, 145.00, 4.50,  2.50,  'Crew currently at origin loading'),
(27, 27, '2026-05-05', '07:30:00', 'In Progress', 3, 185.00, 5.50,  3.00,  'En route to destination'),
(28, 28, '2026-05-05', '07:00:00', 'In Progress', 4, 225.00, 9.50,  5.00,  'Antiques being wrapped with extra care'),
-- Scheduled jobs
(29, 29, '2026-05-06', '09:00:00', 'Scheduled',   2, 145.00, 3.50,  NULL,  '1-bedroom apartment'),
(30, 30, '2026-05-06', '08:00:00', 'Scheduled',   3, 185.00, 6.50,  NULL,  '3-bedroom home'),
(31, 31, '2026-05-07', '08:30:00', 'Scheduled',   2, 145.00, 4.00,  NULL,  'Customer confirmed pickup window'),
(32, 32, '2026-05-07', '08:00:00', 'Scheduled',   3, 185.00, 7.00,  NULL,  'Stairs noted, bring extra dollies'),
(33, 33, '2026-05-08', '09:00:00', 'Scheduled',   2, 145.00, 3.00,  NULL,  'Early morning requested'),
(34, 34, '2026-05-08', '07:00:00', 'Scheduled',   4, 225.00, 8.50,  NULL,  'Piano to be moved to second floor'),
(35, 35, '2026-05-09', '09:30:00', 'Scheduled',   2, 145.00, 2.50,  NULL,  'Small load'),
(36, 36, '2026-05-09', '08:00:00', 'Scheduled',   3, 185.00, 6.00,  NULL,  'Customer wants crew by 8 AM sharp'),
(37, 37, '2026-05-10', '08:30:00', 'Scheduled',   2, 145.00, 4.00,  NULL,  'Standard 2-bedroom'),
(38, 38, '2026-05-10', '09:00:00', 'Scheduled',   3, 185.00, 5.50,  NULL,  'Customer packing own boxes'),
(39, 39, '2026-05-11', '07:00:00', 'Scheduled',   4, 225.00, 9.00,  NULL,  'Large home, long haul within city'),
(40, 40, '2026-05-11', '09:00:00', 'Scheduled',   2, 145.00, 3.50,  NULL,  'Apartment on 3rd floor, no elevator'),
(41, 41, '2026-05-12', '08:00:00', 'Scheduled',   3, 185.00, 6.50,  NULL,  '3-bedroom home'),
(42, 42, '2026-05-12', '08:30:00', 'Scheduled',   2, 145.00, 4.50,  NULL,  'Includes storage unit pickup'),
(43, 43, '2026-05-13', '09:00:00', 'Scheduled',   3, 185.00, 5.00,  NULL,  'Cross-town move'),
-- Cancelled jobs
(44, 44, '2026-05-13', '07:00:00', 'Cancelled',   4, 225.00, 10.00, NULL,  'Customer cancelled — closing delayed'),
(45, 45, '2026-05-14', '09:00:00', 'Cancelled',   2, 145.00, 3.00,  NULL,  'Customer found alternate mover'),
(46, 46, '2026-05-14', '08:00:00', 'Cancelled',   3, 185.00, 7.00,  NULL,  'Move postponed indefinitely'),
(47, 47, '2026-05-15', '09:00:00', 'Scheduled',   2, 145.00, 3.50,  NULL,  '1-bedroom apartment'),
(48, 48, '2026-05-15', '08:00:00', 'Scheduled',   3, 185.00, 6.00,  NULL,  '2-bedroom home with garage'),
(49, 49, '2026-05-16', '08:30:00', 'Scheduled',   2, 145.00, 4.00,  NULL,  'Standard apartment move'),
(50, 50, '2026-05-16', '07:00:00', 'Scheduled',   4, 225.00, 8.00,  NULL,  '4-bedroom, customer has gym equipment');


-- ============================================================
-- Locations (Origin + Destination for each of the 50 jobs)
-- job_id 1–50
-- ============================================================
INSERT INTO Location
(job_id, location_type, street, city, state, zip_code)
VALUES
(1,  'Origin',      '233 King St',           'La Crosse', 'WI', '54601'),
(1,  'Destination', '812 Division St',        'La Crosse', 'WI', '54601'),
(2,  'Origin',      '710 Caledonia St',       'La Crosse', 'WI', '54603'),
(2,  'Destination', '1520 South Ave',         'La Crosse', 'WI', '54601'),
(3,  'Origin',      '418 Market St',          'La Crosse', 'WI', '54601'),
(3,  'Destination', '930 Ferry St',           'La Crosse', 'WI', '54601'),
(4,  'Origin',      '2204 Weston St',         'Onalaska',  'WI', '54650'),
(4,  'Destination', '3601 South Ave',         'La Crosse', 'WI', '54601'),
(5, 'Origin',      '3301 Losey Blvd S',      'La Crosse', 'WI', '54601'),
(5, 'Destination', '4002 Oak Forest Dr',     'Onalaska',  'WI', '54650'),
(6, 'Origin',      '1820 Redfield St',       'La Crosse', 'WI', '54603'),
(6, 'Destination', '2116 Redfield St',       'La Crosse', 'WI', '54603'),
(7, 'Origin',      '907 Rose St',            'La Crosse', 'WI', '54601'),
(7, 'Destination', '1711 Cass St',           'La Crosse', 'WI', '54601'),
(8, 'Origin',      '545 Vine St',            'La Crosse', 'WI', '54601'),
(8, 'Destination', '1031 Avon St',           'La Crosse', 'WI', '54603'),
(9, 'Origin',      '2710 East Ave S',        'La Crosse', 'WI', '54601'),
(9, 'Destination', '2318 Green Bay St',      'Onalaska',  'WI', '54650'),
(10, 'Origin',      '1105 Cass St',           'La Crosse', 'WI', '54601'),
(10, 'Destination', '3711 Mormon Coulee Rd',  'La Crosse', 'WI', '54601'),
(11, 'Origin',      '330 N 9th St',           'La Crosse', 'WI', '54601'),
(11, 'Destination', '512 N 14th St',          'La Crosse', 'WI', '54601'),
(12, 'Origin',      '4412 Mormon Coulee Rd',  'La Crosse', 'WI', '54601'),
(12, 'Destination', '1908 Losey Blvd S',      'La Crosse', 'WI', '54601'),
(13, 'Origin',      '612 Birch St',           'Onalaska',  'WI', '54650'),
(13, 'Destination', '1219 King St',           'La Crosse', 'WI', '54601'),
(14, 'Origin',      '1501 Park Ave',          'La Crosse', 'WI', '54601'),
(14, 'Destination', '3023 Bainbridge St',     'Onalaska',  'WI', '54650'),
(15, 'Origin',      '220 S 6th St',           'La Crosse', 'WI', '54601'),
(15, 'Destination', '4415 Oak Forest Dr',     'Onalaska',  'WI', '54650'),
(16, 'Origin',      '3808 Oak Forest Dr',     'Onalaska',  'WI', '54650'),
(16, 'Destination', '4100 State Rd 33',       'Onalaska',  'WI', '54650'),
(17, 'Origin',      '714 Ferry St',           'La Crosse', 'WI', '54601'),
(17, 'Destination', '3512 South Ave',         'La Crosse', 'WI', '54601'),
(18, 'Origin',      '1928 Clinton St',        'La Crosse', 'WI', '54601'),
(18, 'Destination', '2204 Clinton St',        'La Crosse', 'WI', '54601'),
(19, 'Origin',      '503 Grandview Blvd',     'La Crosse', 'WI', '54601'),
(19, 'Destination', '718 Grandview Blvd',     'La Crosse', 'WI', '54601'),
(20, 'Origin',      '2044 Farnam St',         'Onalaska',  'WI', '54650'),
(20, 'Destination', '3315 Farnam St',         'Onalaska',  'WI', '54650'),
(21, 'Origin',      '817 Pine St',            'La Crosse', 'WI', '54601'),
(21, 'Destination', '1004 Pine St',           'La Crosse', 'WI', '54601'),
(22, 'Origin',      '1312 Loomis St',         'La Crosse', 'WI', '54603'),
(22, 'Destination', '2019 West Ave N',        'La Crosse', 'WI', '54601'),
(23, 'Origin',      '2218 Charles St',        'La Crosse', 'WI', '54601'),
(23, 'Destination', '3901 Liberty St',        'Onalaska',  'WI', '54650'),
(24, 'Origin',      '409 Jay St',             'La Crosse', 'WI', '54601'),
(24, 'Destination', '620 Jay St',             'La Crosse', 'WI', '54601'),
(25, 'Origin',      '1614 Wilson St',         'Onalaska',  'WI', '54650'),
(25, 'Destination', '2701 Green Bay St',      'Onalaska',  'WI', '54650'),
(26, 'Origin',      '733 Sill St',            'La Crosse', 'WI', '54601'),
(26, 'Destination', '1122 Hood St',           'La Crosse', 'WI', '54601'),
(27, 'Origin',      '2905 S 28th St',         'La Crosse', 'WI', '54601'),
(27, 'Destination', '1806 Green Bay St',      'Onalaska',  'WI', '54650'),
(28, 'Origin',      '1108 Market St',         'La Crosse', 'WI', '54601'),
(28, 'Destination', '3304 Sunnyside Dr',      'La Crosse', 'WI', '54601'),
(29, 'Origin',      '316 N 5th St',           'La Crosse', 'WI', '54601'),
(29, 'Destination', '510 N 9th St',           'La Crosse', 'WI', '54601'),
(30, 'Origin',      '4210 Bainbridge St',     'Onalaska',  'WI', '54650'),
(30, 'Destination', '2012 South Ave',         'La Crosse', 'WI', '54601'),
(31, 'Origin',      '625 Badger St',          'La Crosse', 'WI', '54601'),
(31, 'Destination', '1407 Badger St',         'La Crosse', 'WI', '54601'),
(32, 'Origin',      '1721 Kane St',           'La Crosse', 'WI', '54603'),
(32, 'Destination', '3010 Kane St',           'La Crosse', 'WI', '54603'),
(33, 'Origin',      '882 Wilder St',          'La Crosse', 'WI', '54601'),
(33, 'Destination', '1514 Wilder St',         'La Crosse', 'WI', '54601'),
(34, 'Origin',      '2530 Liberty St',        'Onalaska',  'WI', '54650'),
(34, 'Destination', '4001 Liberty St',        'Onalaska',  'WI', '54650'),
(35, 'Origin',      '1044 Ferry St',          'La Crosse', 'WI', '54601'),
(35, 'Destination', '1208 Ferry St',          'La Crosse', 'WI', '54601'),
(36, 'Origin',      '3107 Hillview Dr',       'La Crosse', 'WI', '54601'),
(36, 'Destination', '2444 Hillview Dr',       'La Crosse', 'WI', '54601'),
(37, 'Origin',      '456 N Front St',         'La Crosse', 'WI', '54601'),
(37, 'Destination', '913 N Front St',         'La Crosse', 'WI', '54601'),
(38, 'Origin',      '1890 State Rd 33',       'Onalaska',  'WI', '54650'),
(38, 'Destination', '3201 Sand Lake Rd',      'Onalaska',  'WI', '54650'),
(39, 'Origin',      '723 Division St',        'La Crosse', 'WI', '54603'),
(39, 'Destination', '4108 Sunnyside Dr',      'La Crosse', 'WI', '54601'),
(40, 'Origin',      '2414 West Ave N',        'La Crosse', 'WI', '54601'),
(40, 'Destination', '1604 Redfield St',       'La Crosse', 'WI', '54603'),
(41, 'Origin',      '517 Copeland Ave',       'La Crosse', 'WI', '54603'),
(41, 'Destination', '2800 East Ave S',        'La Crosse', 'WI', '54601'),
(42, 'Origin',      '3629 Oak St',            'Onalaska',  'WI', '54650'),
(42, 'Destination', '1940 Oak St',            'Onalaska',  'WI', '54650'),
(42, 'Storage',     '3001 Industrial Dr',     'Onalaska',  'WI', '54650'),
(43, 'Origin',      '1203 Hood St',           'La Crosse', 'WI', '54601'),
(43, 'Destination', '2707 George St',         'La Crosse', 'WI', '54603'),
(44, 'Origin',      '844 George St',          'La Crosse', 'WI', '54603'),
(44, 'Destination', '4301 State Rd 16',       'Onalaska',  'WI', '54650'),
(45, 'Origin',      '2701 W Avenue S',        'La Crosse', 'WI', '54601'),
(45, 'Destination', '1012 Clinton St',        'La Crosse', 'WI', '54601'),
(46, 'Origin',      '1336 Cameron Ave',       'La Crosse', 'WI', '54601'),
(46, 'Destination', '3506 Sand Lake Rd',      'Onalaska',  'WI', '54650'),
(47, 'Origin',      '415 Denton St',          'Onalaska',  'WI', '54650'),
(47, 'Destination', '810 Denton St',          'Onalaska',  'WI', '54650'),
(48, 'Origin',      '2008 Market St',         'La Crosse', 'WI', '54601'),
(48, 'Destination', '3304 South Ave',         'La Crosse', 'WI', '54601'),
(49, 'Origin',      '913 Jackson St',         'La Crosse', 'WI', '54601'),
(49, 'Destination', '1717 Cass St',           'La Crosse', 'WI', '54601'),
(50, 'Origin',      '3322 Losey Blvd N',      'La Crosse', 'WI', '54601'),
(50, 'Destination', '4200 Mormon Coulee Rd',  'La Crosse', 'WI', '54601');



INSERT INTO Employee
(employee_id, first_name, last_name, phone, email, role, hourly_rate, status)
VALUES
(1, 'Mike', 'Johnson', '6085552001', 'mike.johnson@movingllc.com', 'Mover', 20.00, 'Active'),
(2, 'Chris', 'Brown', '6085552002', 'chris.brown@movingllc.com', 'Driver', 24.00, 'Active'),
(3, 'Alex', 'Wilson', '6085552003', 'alex.wilson@movingllc.com', 'Mover', 20.00, 'Active'),
(4, 'Jordan', 'Davis', '6085552004', 'jordan.davis@movingllc.com', 'Crew Lead', 28.00, 'Active'),
(5, 'Taylor', 'Martin', '6085552005', 'taylor.martin@movingllc.com', 'Mover', 20.00, 'Active');



-- ============================================================
-- Job_Employee assignments for jobs 1–50
-- Employees 1–5 (active); employee 6 is Inactive — not assigned
-- 2-person crews: employee_id 1 (Mover) + 2 (Driver)
-- 3-person crews: employee_id 1 (Mover) + 2 (Driver) + 4 (Crew Lead)
-- 4-person crews: employee_id 1,3 (Mover) + 2 (Driver) + 4 (Crew Lead)
-- Completed jobs have actual hours_worked; Scheduled/Cancelled = 0.00
-- ============================================================
INSERT INTO Job_Employee
(job_id, employee_id, hours_worked, position_on_job)
VALUES
-- Job 1 (Completed, 2-crew, actual 3.25)
(1,  1, 3.25, 'Mover'),
(1,  2, 3.25, 'Driver'),
-- Job 2 (Completed, 3-crew, actual 5.75)
(2,  1, 5.75, 'Mover'),
(2,  2, 5.75, 'Driver'),
(2,  4, 5.75, 'Crew Lead'),
-- Job 3 (Completed, 2-crew, actual 3.75)
(3,  1, 3.75, 'Mover'),
(3,  2, 3.75, 'Driver'),
-- Job 4 (Completed, 3-crew, actual 6.25)
(4,  1, 6.25, 'Mover'),
(4,  2, 6.25, 'Driver'),
(4,  4, 6.25, 'Crew Lead'),
-- Job 5 (Completed, 4-crew, actual 9.50)
(5, 1, 9.50, 'Mover'),
(5, 3, 9.50, 'Mover'),
(5, 2, 9.50, 'Driver'),
(5, 4, 9.50, 'Crew Lead'),
-- Job 6 (Completed, 2-crew, actual 3.50)
(6, 1, 3.50, 'Mover'),
(6, 2, 3.50, 'Driver'),
-- Job 7 (Completed, 3-crew, actual 6.75)
(7, 1, 6.75, 'Mover'),
(7, 2, 6.75, 'Driver'),
(7, 4, 6.75, 'Crew Lead'),
-- Job 8 (Completed, 2-crew, actual 4.50)
(8, 1, 4.50, 'Mover'),
(8, 2, 4.50, 'Driver'),
-- Job 9 (Completed, 3-crew, actual 5.25)
(9, 1, 5.25, 'Mover'),
(9, 2, 5.25, 'Driver'),
(9, 4, 5.25, 'Crew Lead'),
-- Job 10 (Completed, 4-crew, actual 8.00)
(10, 1, 8.00, 'Mover'),
(10, 3, 8.00, 'Mover'),
(10, 2, 8.00, 'Driver'),
(10, 4, 8.00, 'Crew Lead'),
-- Job 11 (Completed, 2-crew, actual 2.25)
(11, 1, 2.25, 'Mover'),
(11, 2, 2.25, 'Driver'),
-- Job 12 (Completed, 3-crew, actual 6.50)
(12, 1, 6.50, 'Mover'),
(12, 2, 6.50, 'Driver'),
(12, 4, 6.50, 'Crew Lead'),
-- Job 13 (Completed, 2-crew, actual 4.25)
(13, 1, 4.25, 'Mover'),
(13, 2, 4.25, 'Driver'),
-- Job 14 (Completed, 3-crew, actual 5.00)
(14, 1, 5.00, 'Mover'),
(14, 2, 5.00, 'Driver'),
(14, 4, 5.00, 'Crew Lead'),
-- Job 15 (Completed, 4-crew, actual 10.50)
(15, 1, 10.50, 'Mover'),
(15, 3, 10.50, 'Mover'),
(15, 2, 10.50, 'Driver'),
(15, 4, 10.50, 'Crew Lead'),
-- Job 16 (Completed, 2-crew, actual 3.00)
(16, 1, 3.00, 'Mover'),
(16, 2, 3.00, 'Driver'),
-- Job 17 (Completed, 3-crew, actual 6.00)
(17, 1, 6.00, 'Mover'),
(17, 2, 6.00, 'Driver'),
(17, 4, 6.00, 'Crew Lead'),
-- Job 18 (Completed, 2-crew, actual 3.75)
(18, 1, 3.75, 'Mover'),
(18, 2, 3.75, 'Driver'),
-- Job 19 (Completed, 2-crew, actual 4.00)
(19, 1, 4.00, 'Mover'),
(19, 2, 4.00, 'Driver'),
-- Job 20 (Completed, 3-crew, actual 7.25)
(20, 1, 7.25, 'Mover'),
(20, 2, 7.25, 'Driver'),
(20, 4, 7.25, 'Crew Lead'),
-- Job 21 (Completed, 2-crew, actual 2.50)
(21, 1, 2.50, 'Mover'),
(21, 2, 2.50, 'Driver'),
-- Job 22 (Completed, 3-crew, actual 5.25)
(22, 1, 5.25, 'Mover'),
(22, 2, 5.25, 'Driver'),
(22, 4, 5.25, 'Crew Lead'),
-- Job 23 (Completed, 4-crew, actual 8.50)
(23, 1, 8.50, 'Mover'),
(23, 3, 8.50, 'Mover'),
(23, 2, 8.50, 'Driver'),
(23, 4, 8.50, 'Crew Lead'),
-- Job 24 (Completed, 2-crew, actual 3.00)
(24, 1, 3.00, 'Mover'),
(24, 2, 3.00, 'Driver'),
-- Job 25 (Completed, 3-crew, actual 6.25)
(25, 1, 6.25, 'Mover'),
(25, 2, 6.25, 'Driver'),
(25, 4, 6.25, 'Crew Lead'),
-- Job 26 (In Progress, 2-crew)
(26, 1, 2.50, 'Mover'),
(26, 2, 2.50, 'Driver'),
-- Job 27 (In Progress, 3-crew)
(27, 1, 3.00, 'Mover'),
(27, 2, 3.00, 'Driver'),
(27, 4, 3.00, 'Crew Lead'),
-- Job 28 (In Progress, 4-crew)
(28, 1, 5.00, 'Mover'),
(28, 3, 5.00, 'Mover'),
(28, 2, 5.00, 'Driver'),
(28, 4, 5.00, 'Crew Lead'),
-- Job 29 (Scheduled, 2-crew)
(29, 1, 0.00, 'Mover'),
(29, 2, 0.00, 'Driver'),
-- Job 30 (Scheduled, 3-crew)
(30, 1, 0.00, 'Mover'),
(30, 2, 0.00, 'Driver'),
(30, 4, 0.00, 'Crew Lead'),
-- Job 31 (Scheduled, 2-crew)
(31, 1, 0.00, 'Mover'),
(31, 2, 0.00, 'Driver'),
-- Job 32 (Scheduled, 3-crew)
(32, 1, 0.00, 'Mover'),
(32, 2, 0.00, 'Driver'),
(32, 4, 0.00, 'Crew Lead'),
-- Job 33 (Scheduled, 2-crew)
(33, 1, 0.00, 'Mover'),
(33, 2, 0.00, 'Driver'),
-- Job 34 (Scheduled, 4-crew)
(34, 1, 0.00, 'Mover'),
(34, 3, 0.00, 'Mover'),
(34, 2, 0.00, 'Driver'),
(34, 4, 0.00, 'Crew Lead'),
-- Job 35 (Scheduled, 2-crew)
(35, 1, 0.00, 'Mover'),
(35, 2, 0.00, 'Driver'),
-- Job 36 (Scheduled, 3-crew)
(36, 1, 0.00, 'Mover'),
(36, 2, 0.00, 'Driver'),
(36, 4, 0.00, 'Crew Lead'),
-- Job 37 (Scheduled, 2-crew)
(37, 1, 0.00, 'Mover'),
(37, 2, 0.00, 'Driver'),
-- Job 38 (Scheduled, 3-crew)
(38, 3, 0.00, 'Mover'),
(38, 2, 0.00, 'Driver'),
(38, 4, 0.00, 'Crew Lead'),
-- Job 39 (Scheduled, 4-crew)
(39, 1, 0.00, 'Mover'),
(39, 3, 0.00, 'Mover'),
(39, 2, 0.00, 'Driver'),
(39, 4, 0.00, 'Crew Lead'),
-- Job 40 (Scheduled, 2-crew)
(40, 1, 0.00, 'Mover'),
(40, 2, 0.00, 'Driver'),
-- Job 41 (Scheduled, 3-crew)
(41, 1, 0.00, 'Mover'),
(41, 2, 0.00, 'Driver'),
(41, 4, 0.00, 'Crew Lead'),
-- Job 42 (Scheduled, 2-crew)
(42, 1, 0.00, 'Mover'),
(42, 2, 0.00, 'Driver'),
-- Job 43 (Scheduled, 3-crew)
(43, 3, 0.00, 'Mover'),
(43, 2, 0.00, 'Driver'),
(43, 4, 0.00, 'Crew Lead'),
-- Job 44 (Cancelled, 4-crew)
(44, 1, 0.00, 'Mover'),
(44, 3, 0.00, 'Mover'),
(44, 2, 0.00, 'Driver'),
(44, 4, 0.00, 'Crew Lead'),
-- Job 45 (Cancelled, 2-crew)
(45, 1, 0.00, 'Mover'),
(45, 2, 0.00, 'Driver'),
-- Job 46 (Cancelled, 3-crew)
(46, 1, 0.00, 'Mover'),
(46, 2, 0.00, 'Driver'),
(46, 4, 0.00, 'Crew Lead'),
-- Job 47 (Scheduled, 2-crew)
(47, 1, 0.00, 'Mover'),
(47, 2, 0.00, 'Driver'),
-- Job 48 (Scheduled, 3-crew)
(48, 1, 0.00, 'Mover'),
(48, 2, 0.00, 'Driver'),
(48, 4, 0.00, 'Crew Lead'),
-- Job 49 (Scheduled, 2-crew)
(49, 1, 0.00, 'Mover'),
(49, 2, 0.00, 'Driver'),
-- Job 50 (Scheduled, 4-crew)
(50, 1, 0.00, 'Mover'),
(50, 3, 0.00, 'Mover'),
(50, 2, 0.00, 'Driver'),
(50, 4, 0.00, 'Crew Lead');


INSERT INTO Truck
(plate_num, make, model, year, truck_size_ft, max_load_lbs, status)
VALUES
('MVC101', 'Ford',         'E-350 Box Truck',      2021, 10, 2800,  'Available'),
('MVC215', 'GMC',          'Savana Box Truck',     2020, 15, 6385,  'In Use'),
('MVC320', 'Isuzu',        'NPR HD Box Truck',     2022, 20, 5500,  'Available'),
('MVC426', 'International', 'MV Box Truck',        2023, 26, 12859, 'Maintenance');

-- ============================================================
-- Job_Truck assignments for jobs 1–50
-- Truck reference: 1=MVC101(10ft), 2=MVC215(15ft), 3=MVC320(20ft), 4=MVC426(26ft)
-- 2-crew small moves  → truck 1 (10ft)
-- 2-crew medium moves → truck 2 (15ft)
-- 3-crew moves        → truck 2 (15ft) or 3 (20ft)
-- 4-crew large moves  → truck 3 (20ft)
-- Completed jobs have miles/fuel; Scheduled/Cancelled = 0.00
-- ============================================================
INSERT INTO Job_Truck
(job_id, truck_id, miles, fuel_cost)
VALUES
(1,  1,  8.20,  12.50),
(2,  2,  11.40, 17.25),
(3,  1,  6.50,  9.80),
(4,  3,  18.30, 27.60),
(5, 3,  14.70, 22.10),
(6, 1,  4.20,  6.30),
(7, 2,  9.80,  14.70),
(8, 1,  7.60,  11.40),
(9, 2,  16.20, 24.40),
(10, 3,  12.50, 18.80),
(11, 1,  3.80,  5.70),
(12, 2,  10.30, 15.50),
(13, 1,  13.60, 20.40),
(14, 2,  17.40, 26.10),
(15, 3,  15.90, 23.90),
(16, 1,  5.20,  7.80),
(17, 2,  11.80, 17.80),
(18, 1,  4.60,  6.90),
(19, 1,  3.10,  4.70),
(20, 2,  6.80,  10.20),
(21, 1,  2.90,  4.40),
(22, 2,  8.40,  12.60),
(23, 3,  19.20, 28.90),
(24, 1,  3.50,  5.30),
(25, 2,  7.10,  10.70),
(26, 1,  5.80,  8.70),
(27, 2,  14.30, 21.50),
(28, 3,  10.60, 15.90),
(29, 1,  0.00,  0.00),
(30, 3,  0.00,  0.00),
(31, 1,  0.00,  0.00),
(32, 2,  0.00,  0.00),
(33, 1,  0.00,  0.00),
(34, 3,  0.00,  0.00),
(35, 1,  0.00,  0.00),
(36, 2,  0.00,  0.00),
(37, 1,  0.00,  0.00),
(38, 2,  0.00,  0.00),
(39, 3,  0.00,  0.00),
(40, 1,  0.00,  0.00),
(41, 2,  0.00,  0.00),
(42, 1,  0.00,  0.00),
(43, 2,  0.00,  0.00),
(44, 3,  0.00,  0.00),
(45, 1,  0.00,  0.00),
(46, 2,  0.00,  0.00),
(47, 1,  0.00,  0.00),
(48, 2,  0.00,  0.00),
(49, 1,  0.00,  0.00),
(50, 3,  0.00,  0.00);