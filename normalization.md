# Database Normalization Analysis

## Overview
This document explains the normalization process applied to the AirBnB database to ensure it meets Third Normal Form (3NF) requirements.

## Normalization Forms Applied

### First Normal Form (1NF)
**Requirements:**
- All columns contain atomic values
- No repeating groups

**Analysis:**
✅ All tables meet 1NF:
- Each attribute contains single values
- No multi-valued attributes exist
- Each table has a primary key (UUID)

### Second Normal Form (2NF)
**Requirements:**
- Must be in 1NF
- All non-key attributes fully dependent on primary key

**Analysis:**
✅ All tables meet 2NF:
- All tables use single-column primary keys (UUIDs)
- No partial dependencies exist

### Third Normal Form (3NF)
**Requirements:**
- Must be in 2NF
- No transitive dependencies

**Analysis:**

#### User Table ✅
- All attributes directly depend on user_id
- No transitive dependencies

#### Property Table ✅
- All attributes directly depend on property_id
- host_id is a foreign key, not a transitive dependency

#### Booking Table ⚠️
**Consideration:** `total_price` could be calculated
- Formula: (end_date - start_date) × Property.pricepernight
- **Decision:** Keep total_price (controlled denormalization)
- **Justification:**
  1. Performance: Avoids JOIN operations for price queries
  2. Historical accuracy: Preserves price at booking time
  3. Business logic: Handles discounts/promotions
  4. Common practice in e-commerce systems

#### Payment Table ✅
- All attributes depend only on payment_id
- amount could theoretically match booking.total_price, but may differ (partial payments)

#### Review Table ✅
- No transitive dependencies
- All attributes depend on review_id

#### Message Table ✅
- Clean design with no transitive dependencies

## Conclusion
The database design is in Third Normal Form (3NF) with one intentional denormalization (Booking.total_price) for legitimate performance and business reasons. This represents industry best practices for transactional systems.

## Additional Improvements Considered
1. **Indexing Strategy:** Applied to foreign keys for JOIN performance
2. **UUID Primary Keys:** Better for distributed systems
3. **ENUM Types:** Constrain values at database level