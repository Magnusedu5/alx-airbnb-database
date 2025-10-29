-- AirBnB Database Sample Data
-- DML Script for inserting realistic sample data

-- =====================================================
-- INSERT USERS
-- =====================================================
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Doe', 'john.doe@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeXJH34f.oXhNqxHi', '+1234567890', 'guest', '2024-01-15 10:00:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Jane', 'Smith', 'jane.smith@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeXJH34f.oXhNqxHi', '+1234567891', 'host', '2024-01-16 11:30:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Admin', 'User', 'admin@airbnb.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeXJH34f.oXhNqxHi', '+1234567892', 'admin', '2024-01-01 09:00:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Alice', 'Johnson', 'alice.j@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeXJH34f.oXhNqxHi', '+1234567893', 'host', '2024-02-10 14:20:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Bob', 'Williams', 'bob.w@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeXJH34f.oXhNqxHi', NULL, 'guest', '2024-03-05 16:45:00');

-- =====================================================
-- INSERT PROPERTIES
-- =====================================================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'Cozy Downtown Apartment', 'Beautiful 2-bedroom apartment in the heart of downtown with amazing city views', 'New York, NY', 150.00, '2024-01-20 12:00:00', '2024-01-20 12:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'Beach House Paradise', 'Stunning beachfront property with private access to the beach', 'Miami, FL', 300.00, '2024-01-25 13:30:00', '2024-01-25 13:30:00'),
('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', 'Mountain Cabin Retreat', 'Peaceful cabin in the mountains, perfect for nature lovers', 'Aspen, CO', 200.00, '2024-02-15 10:15:00', '2024-02-15 10:15:00'),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', 'Modern Loft Studio', 'Stylish loft in trendy neighborhood, ideal for solo travelers', 'Los Angeles, CA', 120.00, '2024-03-01 09:30:00', '2024-03-01 09:30:00');

-- =====================================================
-- INSERT BOOKINGS
-- =====================================================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '2024-06-01', '2024-06-05', 600.00, 'confirmed', '2024-05-15 14:20:00'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005', '2024-07-10', '2024-07-15', 1500.00, 'confirmed', '2024-06-20 11:45:00'),
('750e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', '2024-08-01', '2024-08-07', 1200.00, 'pending', '2024-07-25 16:30:00'),
('750e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', '2024-05-10', '2024-05-12', 300.00, 'canceled', '2024-05-01 10:00:00');

-- =====================================================
-- INSERT PAYMENTS
-- =====================================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 600.00, '2024-05-15 14:25:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 1500.00, '2024-06-20 11:50:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440004', 300.00, '2024-05-01 10:05:00', 'stripe');

-- =====================================================
-- INSERT REVIEWS
-- =====================================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('950e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 5, 'Absolutely loved this place! Perfect location and very clean.', '2024-06-06 10:00:00'),
('950e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005', 4, 'Great beach house, enjoyed our stay. Only minor issue was WiFi speed.', '2024-07-16 12:30:00'),
('950e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', 3, 'Good location but a bit noisy at night.', '2024-05-13 09:15:00');

-- =====================================================
-- INSERT MESSAGES
-- =====================================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('a50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'Hi! Is the apartment available for June?', '2024-05-10 14:30:00'),
('a50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Yes, it is! Feel free to book.', '2024-05-10 15:00:00'),
('a50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440004', 'Does the cabin have WiFi?', '2024-07-20 11:20:00'),
('a50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440005', 'Yes, we have high-speed internet available.', '2024-07-20 11:45:00');