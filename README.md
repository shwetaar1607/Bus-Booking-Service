# 🚌 Online Bus Booking Service

## 📌 Project Overview
This project is an online bus ticket booking platform that allows users to book city-to-city bus travel tickets across Texas — including Dallas, Austin, Houston, and San Antonio. The platform is optimized for both mobile and desktop users, and provides strategic business insights to improve operations and revenue generation.

## 🗂️ Key Features
- Passenger and driver management with detailed personal and contact information
- Bus allocation and route planning
- Ticket booking with date, time, price, and seat details
- City and route analytics for business decision-making
- Insights such as top cities, booking trends, and underbooked trips

## 🧠 Business Goals Implemented
- Top 5 buses traveling to Dallas
- Driver assignment analytics
- City-wise and month-wise booking totals
- Total passenger spending by city
- Ticket demand by age group and price
- Underbooked buses detection

## 🧰 Tech Stack
- **Database:** MySQL
- **Languages:** SQL
- **Concepts:** ER Modeling, Normalization (up to 3NF), Functional Dependencies

## 🗃️ Schema Overview
- **Entities:** Passenger, Driver, City, Route, Bus, Ticket
- **Relationships:** Assigned_to, Ticketing
- Proper enforcement of PKs, FKs, Candidate Keys, and Data Integrity

## 🚀 How to Run
1. Clone the repo
2. Import `projectDBcreate.sql` into MySQL to create the schema
3. Populate data using `projectDBinsert.sql`
4. Use `projectDBqueries.sql` to execute business goal queries
5. Modify or remove data using `projectDBupdate.sql` and `projectDBdrop.sql`

## 📈 Sample Queries
- Cities with highest ticket sales
- Drivers assigned to all buses
- Age group-wise booking trends for low-price tickets

## 📄 License
This project is part of a university-level database systems coursework.

