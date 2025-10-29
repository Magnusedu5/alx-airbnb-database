# Database Seeding - Sample Data

## Overview
This directory contains SQL DML (Data Manipulation Language) scripts to populate the AirBnB database with realistic sample data.

## File: seed.sql

### Sample Data Summary

#### Users (5 records)
- 2 Guests: John Doe, Bob Williams
- 2 Hosts: Jane Smith, Alice Johnson
- 1 Admin: Admin User

#### Properties (4 records)
- Urban apartments
- Beach house
- Mountain cabin
- Modern loft

#### Bookings (4 records)
- Mix of confirmed, pending, and canceled bookings
- Date ranges from May to August 2024

#### Payments (3 records)
- Different payment methods: credit card, PayPal, Stripe
- Linked to confirmed bookings

#### Reviews (3 records)
- Ratings from 3-5 stars
- Realistic comments from guests

#### Messages (4 records)
- Communication between users
- Inquiry and response patterns

### Data Characteristics

**Realistic Scenarios:**
- Multiple bookings per user
- Multiple properties per host
- Reviews after checkout dates
- Messages before bookings
- Mix of booking statuses

**Data Integrity:**
- All foreign keys reference existing records
- Dates follow logical sequences
- Prices calculated correctly
- UUIDs follow standard format

### How to Run

**After creating the schema:**
```bash
mysql -u your_username -p your_database < seed.sql
```

**To verify data:**
```sql
SELECT COUNT(*) FROM User;
SELECT COUNT(*) FROM Property;
SELECT COUNT(*) FROM Booking;
```

### Notes
- Password hashes are bcrypt examples (not real passwords)
- UUIDs are generated following standard format
- Dates are set in 2024 for testing purposes
- Adjust dates as needed for your testing scenarios
```

---
