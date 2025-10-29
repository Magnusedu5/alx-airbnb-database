# Database Schema - DDL Scripts

## Overview
This directory contains the SQL Data Definition Language (DDL) scripts for creating the AirBnB database schema.

## File: schema.sql

### Tables Created
1. **User** - Platform users (guests, hosts, admins)
2. **Property** - Rental listings
3. **Booking** - Reservation records
4. **Payment** - Payment transactions
5. **Review** - Property reviews and ratings
6. **Message** - User-to-user messages

### Key Features

#### Primary Keys
- All tables use UUID (CHAR(36)) as primary keys
- Automatically indexed for fast lookups

#### Foreign Keys
- Proper referential integrity with CASCADE options
- Ensures data consistency across related tables

#### Constraints
- NOT NULL on required fields
- UNIQUE constraint on User.email
- CHECK constraints on ratings (1-5) and dates
- ENUM types for controlled values (role, status, payment_method)

#### Indexes
Created for optimal query performance:
- User: email
- Property: host_id, location
- Booking: property_id, user_id, date range
- Payment: booking_id
- Review: property_id, user_id
- Message: sender_id, recipient_id, sent_at

### How to Run

**For MySQL:**
```bash
mysql -u your_username -p your_database < schema.sql
```

**For PostgreSQL:**
```bash
psql -U your_username -d your_database -f schema.sql
```

### Notes
- Adjust UUID implementation based on your database system
- For PostgreSQL, uncomment the uuid-ossp extension line
- For MySQL 5.7+, ENUM and ON UPDATE CURRENT_TIMESTAMP are supported