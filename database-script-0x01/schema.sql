-- AirBnB Database Schema
-- DDL Script for creating all tables with constraints and indexes

-- Enable UUID extension (for PostgreSQL)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- USER TABLE
-- =====================================================
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY, -- UUID format
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index on email for faster lookups
CREATE INDEX idx_user_email ON User(email);

-- =====================================================
-- PROPERTY TABLE
-- =====================================================
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign key constraint
    FOREIGN KEY (host_id) REFERENCES User(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Indexes for performance
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);

-- =====================================================
-- BOOKING TABLE
-- =====================================================
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) 
        ON DELETE CASCADE,
    
    -- Check constraint: end_date must be after start_date
    CHECK (end_date > start_date)
);

-- Indexes for performance
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- =====================================================
-- PAYMENT TABLE
-- =====================================================
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL UNIQUE, -- One payment per booking
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    -- Foreign key constraint
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) 
        ON DELETE CASCADE
);

-- Index on booking_id
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

-- =====================================================
-- REVIEW TABLE
-- =====================================================
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) 
        ON DELETE CASCADE,
    
    -- Check constraint: rating must be between 1 and 5
    CHECK (rating >= 1 AND rating <= 5)
);

-- Indexes for performance
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);

-- =====================================================
-- MESSAGE TABLE
-- =====================================================
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (sender_id) REFERENCES User(user_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) 
        ON DELETE CASCADE,
    
    -- Check: sender and recipient must be different
    CHECK (sender_id != recipient_id)
);

-- Indexes for performance
CREATE INDEX idx_message_sender_id ON Message(sender_id);
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);
CREATE INDEX idx_message_sent_at ON Message(sent_at);