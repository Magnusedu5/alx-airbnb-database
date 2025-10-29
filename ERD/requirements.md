# Entity-Relationship Diagram - AirBnB Database

## Overview
This document describes the database design for an AirBnB-like application, including all entities, their attributes, relationships, and constraints.

## Entities

### 1. User
**Purpose:** Stores information about all platform users (guests, hosts, and administrators)

**Attributes:**
- `user_id` (Primary Key, UUID, Indexed) - Unique identifier for each user
- `first_name` (VARCHAR, NOT NULL) - User's first name
- `last_name` (VARCHAR, NOT NULL) - User's last name
- `email` (VARCHAR, UNIQUE, NOT NULL) - User's email address for login
- `password_hash` (VARCHAR, NOT NULL) - Hashed password for security
- `phone_number` (VARCHAR, NULL) - Optional contact number
- `role` (ENUM: 'guest', 'host', 'admin', NOT NULL) - User's role in the system
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Account creation date

**Constraints:**
- Email must be unique across all users
- Role must be one of: guest, host, or admin

### 2. Property
**Purpose:** Represents rental listings/properties available on the platform

**Attributes:**
- `property_id` (Primary Key, UUID, Indexed) - Unique identifier for each property
- `host_id` (Foreign Key → User.user_id, UUID) - References the host who owns the property
- `name` (VARCHAR, NOT NULL) - Property title/name
- `description` (TEXT, NOT NULL) - Detailed property description
- `location` (VARCHAR, NOT NULL) - Property address/location
- `pricepernight` (DECIMAL, NOT NULL) - Nightly rental price
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Listing creation date
- `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP) - Last modification date

**Constraints:**
- host_id must reference a valid user with 'host' role
- Price must be positive

### 3. Booking
**Purpose:** Tracks reservation/booking information for properties

**Attributes:**
- `booking_id` (Primary Key, UUID, Indexed) - Unique identifier for each booking
- `property_id` (Foreign Key → Property.property_id, UUID) - Property being booked
- `user_id` (Foreign Key → User.user_id, UUID) - Guest making the booking
- `start_date` (DATE, NOT NULL) - Check-in date
- `end_date` (DATE, NOT NULL) - Check-out date
- `total_price` (DECIMAL, NOT NULL) - Total cost of the booking
- `status` (ENUM: 'pending', 'confirmed', 'canceled', NOT NULL) - Current booking status
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Booking creation date

**Constraints:**
- end_date must be after start_date
- Status must be one of: pending, confirmed, or canceled
- total_price should reflect (end_date - start_date) × pricepernight

### 4. Payment
**Purpose:** Records payment transactions for bookings

**Attributes:**
- `payment_id` (Primary Key, UUID, Indexed) - Unique identifier for each payment
- `booking_id` (Foreign Key → Booking.booking_id, UUID, UNIQUE) - Associated booking
- `amount` (DECIMAL, NOT NULL) - Payment amount
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - When payment was made
- `payment_method` (ENUM: 'credit_card', 'paypal', 'stripe', NOT NULL) - Payment method used

**Constraints:**
- Each booking can have only one payment (one-to-one relationship)
- Amount must be positive
- booking_id must reference a valid booking

### 5. Review
**Purpose:** Stores guest reviews and ratings for properties

**Attributes:**
- `review_id` (Primary Key, UUID, Indexed) - Unique identifier for each review
- `property_id` (Foreign Key → Property.property_id, UUID) - Property being reviewed
- `user_id` (Foreign Key → User.user_id, UUID) - User who wrote the review
- `rating` (INTEGER, NOT NULL, CHECK: rating >= 1 AND rating <= 5) - Star rating
- `comment` (TEXT, NOT NULL) - Written review text
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - Review submission date

**Constraints:**
- Rating must be between 1 and 5 (inclusive)
- User must have completed a booking at the property to review
- One user can write multiple reviews for different properties

### 6. Message
**Purpose:** Facilitates communication between users (guests and hosts)

**Attributes:**
- `message_id` (Primary Key, UUID, Indexed) - Unique identifier for each message
- `sender_id` (Foreign Key → User.user_id, UUID) - User sending the message
- `recipient_id` (Foreign Key → User.user_id, UUID) - User receiving the message
- `message_body` (TEXT, NOT NULL) - Content of the message
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) - When message was sent

**Constraints:**
- sender_id and recipient_id must be different (cannot message yourself)
- Both sender and recipient must be valid users

---

## Relationships

### 1. User (Host) → Property: One-to-Many
**Relationship:** "hosts"
- **Cardinality:** 1:N
- **Description:** A single host (user with role='host') can list multiple properties on the platform
- **Foreign Key:** Property.host_id references User.user_id
- **Business Rule:** When a host account is deleted, their properties should be deleted (CASCADE) or reassigned

### 2. User (Guest) → Booking: One-to-Many
**Relationship:** "makes"
- **Cardinality:** 1:N
- **Description:** A user can make multiple bookings over time
- **Foreign Key:** Booking.user_id references User.user_id
- **Business Rule:** Users can book multiple properties but cannot double-book dates

### 3. Property → Booking: One-to-Many
**Relationship:** "has" / "receives bookings for"
- **Cardinality:** 1:N
- **Description:** A property can be booked multiple times (by different users or at different times)
- **Foreign Key:** Booking.property_id references Property.property_id
- **Business Rule:** Properties cannot have overlapping confirmed bookings for the same dates

### 4. Booking → Payment: One-to-One
**Relationship:** "requires"
- **Cardinality:** 1:1
- **Description:** Each booking has exactly one payment transaction associated with it
- **Foreign Key:** Payment.booking_id references Booking.booking_id (UNIQUE constraint)
- **Business Rule:** A payment must be completed before a booking is confirmed

### 5. User → Review: One-to-Many
**Relationship:** "writes"
- **Cardinality:** 1:N
- **Description:** A user can write multiple reviews for different properties they've stayed at
- **Foreign Key:** Review.user_id references User.user_id
- **Business Rule:** Users should only review properties after completing their stay

### 6. Property → Review: One-to-Many
**Relationship:** "receives"
- **Cardinality:** 1:N
- **Description:** A property can receive multiple reviews from different guests
- **Foreign Key:** Review.property_id references Property.property_id
- **Business Rule:** Average rating can be calculated from all reviews for reporting

### 7. User (Sender) → Message: One-to-Many
**Relationship:** "sends"
- **Cardinality:** 1:N
- **Description:** A user can send multiple messages to different recipients
- **Foreign Key:** Message.sender_id references User.user_id
- **Business Rule:** Message history is maintained for user reference

### 8. User (Recipient) → Message: One-to-Many
**Relationship:** "receives"
- **Cardinality:** 1:N
- **Description:** A user can receive multiple messages from different senders
- **Foreign Key:** Message.recipient_id references User.user_id
- **Business Rule:** Messages should be retrievable by both sender and recipient

---

## Entity Relationship Summary Table

| Relationship | Entity 1 | Entity 2 | Cardinality | Relationship Type |
|--------------|----------|----------|-------------|-------------------|
| Hosts | User | Property | 1:N | One-to-Many |
| Makes | User | Booking | 1:N | One-to-Many |
| Has Bookings | Property | Booking | 1:N | One-to-Many |
| Requires | Booking | Payment | 1:1 | One-to-One |
| Writes | User | Review | 1:N | One-to-Many |
| Receives | Property | Review | 1:N | One-to-Many |
| Sends | User | Message | 1:N | One-to-Many |
| Receives | User | Message | 1:N | One-to-Many |

---

## Indexing Strategy

### Primary Key Indexes (Automatic)
- User.user_id
- Property.property_id
- Booking.booking_id
- Payment.payment_id
- Review.review_id
- Message.message_id

### Additional Indexes for Performance
1. **User.email** - For login queries and uniqueness checks
2. **Property.host_id** - For finding all properties by a host
3. **Property.location** - For location-based searches
4. **Booking.property_id** - For finding all bookings for a property
5. **Booking.user_id** - For finding all bookings by a user
6. **Booking.start_date, Booking.end_date** - For date range queries and availability checks
7. **Payment.booking_id** - For payment lookup by booking
8. **Review.property_id** - For fetching all reviews for a property
9. **Review.user_id** - For fetching all reviews by a user
10. **Message.sender_id** - For sent messages lookup
11. **Message.recipient_id** - For inbox queries
12. **Message.sent_at** - For chronological message ordering

---

## Key Design Decisions

### 1. UUID Primary Keys
**Decision:** Use UUID (CHAR(36)) instead of auto-increment integers
**Rationale:**
- Better for distributed systems
- Prevents ID enumeration attacks
- Enables offline ID generation
- Facilitates data merging across systems

### 2. ENUM Data Types
**Decision:** Use ENUM for role, status, and payment_method
**Rationale:**
- Enforces data integrity at database level
- Better performance than CHECK constraints
- Clear documentation of allowed values
- Prevents invalid data entry

### 3. Separate Payment Table
**Decision:** Keep Payment as separate entity instead of embedding in Booking
**Rationale:**
- Supports complex payment scenarios (refunds, partial payments in future)
- Maintains financial audit trail
- Allows different payment methods per booking
- Better separation of concerns

### 4. Denormalized total_price in Booking
**Decision:** Store calculated total_price despite it being derivable
**Rationale:**
- Preserves historical price at time of booking
- Handles promotional discounts and dynamic pricing
- Improves query performance
- Common practice in e-commerce systems

### 5. Timestamps
**Decision:** Include created_at on all entities, updated_at where relevant
**Rationale:**
- Audit trail for data changes
- Enables time-based analytics
- Supports data synchronization
- Required for compliance in many jurisdictions

---

## Diagram

### ERD Visual Representation

**Note:** The complete Entity-Relationship Diagram has been created using Draw.io and shows:
- All 6 entities (User, Property, Booking, Payment, Review, Message)
- Primary keys marked with 🔑 symbol
- Foreign keys indicated with arrows
- Cardinality notation (1:1, 1:N) on relationship lines
- Data types for each attribute
- Key constraints (UNIQUE, NOT NULL, CHECK)



### Relationship Diagram 
![alt text](<Final Year Project (1).jpg>)

## Database Characteristics

### Scalability Considerations
- UUID primary keys support horizontal partitioning
- Indexed foreign keys enable efficient JOIN operations
- Normalized design minimizes data redundancy
- Strategic denormalization (total_price) balances performance

### Data Integrity
- Foreign key constraints enforce referential integrity
- CHECK constraints validate data ranges
- UNIQUE constraints prevent duplicates
- NOT NULL constraints ensure required data

### Performance Optimization
- Comprehensive indexing strategy
- Appropriate data types (DECIMAL for money, ENUM for categories)
- Timestamp fields for temporal queries
- Composite indexes for common query patterns

---

## Next Steps

1. **Normalization Review** - Verify the design meets 3NF requirements (see normalization.md)
2. **Schema Implementation** - Create SQL DDL scripts (see database-script-0x01/schema.sql)
3. **Data Seeding** - Populate with sample data (see database-script-0x02/seed.sql)
4. **Testing** - Verify constraints, relationships, and query performance
5. **Documentation** - Update as design evolves

---

## Additional Notes

- This design supports the core functionality of an AirBnB-like platform
- Future enhancements could include: amenities, availability calendar, favorites/wishlists, multi-currency support
- Security considerations: password hashing, SQL injection prevention, access control
- Consider adding soft deletes (deleted_at) instead of hard deletes for audit purposes

---
