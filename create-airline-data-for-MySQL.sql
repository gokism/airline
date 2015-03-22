
#-- Run this script directly in the MySQL server query window it will automatically create the database and all the database objects.


CREATE DATABASE Airline;

USE Airline;

CREATE TABLE AIRPORT (
	airport_code char(3) not null,
    airport_name varchar(75) not null,
    city varchar(20) not null,
    state char(2) not null,
    CONSTRAINT pk_airport primary key (airport_code)
);

#DROP TABLE FLIGHT;

CREATE TABLE FLIGHT (
	flight_number varchar(10) not null,
    airline char(2) not null,
    weekdays bit(7) not null,
    departure_airport_code char(3) not null,
    scheduled_departure_time time not null,
    arrival_airport_code char(3) not null,
    scheduled_arrival_time time not null,
    CONSTRAINT pk_flight primary key (flight_number),
    CONSTRAINT fk_flight_airport_dep foreign key (departure_airport_code) references AIRPORT(airport_code),
    CONSTRAINT fk_flight_airport_arr foreign key (arrival_airport_code) references AIRPORT(airport_code)
);

CREATE TABLE FLIGHT_INSTANCE (
	flight_number varchar(10) not null,
    flight_date date not null,
    number_of_available_seats int, -- reconsider for not null
    airplane_id varchar(10) not null,
    departure_time time, -- reconsider for not null
    arrival_time time,
    CONSTRAINT pk_flight_instance primary key (flight_number, flight_date),
    CONSTRAINT fk_flight_instance_flight foreign key (flight_number) references FLIGHT(flight_number)
);
    
CREATE TABLE FARE (
	flight_number varchar(10) not null,
    fare_code char(10) not null,
    amount decimal(10,2),
    restrictions decimal(10,2),
    CONSTRAINT pk_fare primary key (flight_number,fare_code),
    CONSTRAINT fk_fare_flight foreign key (flight_number) references FLIGHT(flight_number)
);
    
CREATE TABLE AIRPLANE_TYPE (
	airplane_type_name char(3) not null,
    max_seats int not null,
    company varchar(15) not null,
    CONSTRAINT pk_airplane_type primary key (airplane_type_name)
);

CREATE TABLE CAN_LAND (
	airplane_type_name char(3) not null,
    airport_code char(3) not null,
    CONSTRAINT pk_can_land primary key (airplane_type_name,airport_code),
    CONSTRAINT fk_can_land_airplane_type foreign key (airplane_type_name) references AIRPLANE_TYPE(airplane_type_name),
    CONSTRAINT fk_can_land_airport foreign key (airport_code) references AIRPORT(airport_code)
);


CREATE TABLE AIRPLANE (
	airplane_id varchar(10) not null,
    total_number_of_seats int,
    airplane_type char(3) not null,
    CONSTRAINT pk_airplane primary key (airplane_id),
    CONSTRAINT fk_airplane_airplane_type foreign key (airplane_type) references AIRPLANE_TYPE(airplane_type_name)
);
    
CREATE TABLE SEAT_RESERVATION (
	flight_number varchar(10) not null,
    r_date date not null,
    seat_number int not null,
    customer_name varchar(30),
    customer_phone char(10),
    CONSTRAINT pk_seat_reservation primary key (flight_number, r_date, seat_number),
    CONSTRAINT fk_seat_reservation_flight foreign key (flight_number,r_date) references FLIGHT_INSTANCE(flight_number, flight_date)
);