-- Create the database
CREATE DATABASE train_network;
USE train_network;

-- Table: train_station
CREATE TABLE train_station (
    id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(255) NOT NULL
);

-- Table: schedule
CREATE TABLE schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table: carriage_class
CREATE TABLE carriage_class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(255) NOT NULL,
    seating_capacity INT NOT NULL
);

-- Table: train_journey
CREATE TABLE train_journey (
    id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES schedule(id)
);

-- Table: journey_station
CREATE TABLE journey_station (
    journey_id INT NOT NULL,
    station_id INT NOT NULL,
    stop_order INT NOT NULL,
    departure_time DATETIME NOT NULL,
    PRIMARY KEY (journey_id, station_id),
    FOREIGN KEY (journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (station_id) REFERENCES train_station(id)
);

-- Table: journey_carriage
CREATE TABLE journey_carriage (
    journey_id INT NOT NULL,
    carriage_class_id INT NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (journey_id, carriage_class_id),
    FOREIGN KEY (journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (carriage_class_id) REFERENCES carriage_class(id)
);

-- Table: carriage_price
CREATE TABLE carriage_price (
    schedule_id INT NOT NULL,
    carriage_class_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (schedule_id, carriage_class_id),
    FOREIGN KEY (schedule_id) REFERENCES schedule(id),
    FOREIGN KEY (carriage_class_id) REFERENCES carriage_class(id)
);

-- Table: passenger
CREATE TABLE passenger (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Table: booking_status
CREATE TABLE booking_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table: booking
CREATE TABLE booking (
    id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    position INT NOT NULL,
    status_id INT NOT NULL,
    booking_date DATE NOT NULL,
    starting_station_id INT NOT NULL,
    ending_station_id INT NOT NULL,
    train_journey_id INT NOT NULL,
    ticket_class_id INT NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    ticket_no INT NOT NULL,
    seat_no INT NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES passenger(id),
    FOREIGN KEY (status_id) REFERENCES booking_status(id),
    FOREIGN KEY (starting_station_id) REFERENCES train_station(id),
    FOREIGN KEY (ending_station_id) REFERENCES train_station(id),
    FOREIGN KEY (train_journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (ticket_class_id) REFERENCES carriage_class(id)
);

-- Populate train_station table
INSERT INTO train_station (station_name)
VALUES 
    ('Penn Station'),
    ('South Station'),
    ('Union Station'),
    ('Grand Central Station');

-- Populate schedule table
INSERT INTO schedule (name)
VALUES 
    ('Weekday'),
    ('Weekend'),
    ('Public Holiday');

-- Populate carriage_class table
INSERT INTO carriage_class (class_name, seating_capacity)
VALUES 
    ('First Class', 20),
    ('Business', 100),
    ('Economy', 200);

-- Populate train_journey table
INSERT INTO train_journey (schedule_id, name)
VALUES 
    (1, '9:05 Penn Station to Boston South Station'),
    (2, '12:45 Chicago to Washington DC'),
    (3, '6:30 New York to Los Angeles');

-- Populate journey_station table
INSERT INTO journey_station (journey_id, station_id, stop_order, departure_time)
VALUES 
    (1, 1, 1, '2025-01-09 09:10:00'),
    (1, 2, 2, '2025-01-09 11:15:00'),
    (2, 3, 1, '2025-01-09 12:45:00'),
    (2, 4, 2, '2025-01-09 16:21:00');

-- Populate journey_carriage table
INSERT INTO journey_carriage (journey_id, carriage_class_id, position)
VALUES 
    (1, 1, 1),
    (1, 2, 2),
    (2, 2, 1),
    (2, 3, 3);

-- Populate carriage_price table
INSERT INTO carriage_price (schedule_id, carriage_class_id, price)
VALUES 
    (1, 1, 100.00),
    (1, 2, 50.00),
    (2, 3, 30.00);

-- Populate passenger table
INSERT INTO passenger (first_name, last_name, email_address, password)
VALUES 
    ('John', 'Smith', 'john.smith@mail.com', 'encrypted_pass1'),
    ('Sandip', 'Kumar', 'sandip.kumar@mail.com', 'encrypted_pass2'),
    ('Stephanie', 'Jones', 'stephanie.jones@mail.com', 'encrypted_pass3');

-- Populate booking_status table
INSERT INTO booking_status (name)
VALUES 
    ('Active'),
    ('Cancelled'),
    ('Pending');

-- Populate booking table
INSERT INTO booking (passenger_id, position, status_id, booking_date, starting_station_id, ending_station_id, train_journey_id, ticket_class_id, amount_paid, ticket_no, seat_no)
VALUES 
    (1, 1, 1, '2025-01-08', 1, 2, 1, 1, 100.00, 15, 3),
    (2, 2, 2, '2025-01-07', 3, 4, 2, 2, 50.00, 80, 15),
    (3, 3, 3, '2025-01-06', 2, 3, 1, 3, 30.00, 231, 29);