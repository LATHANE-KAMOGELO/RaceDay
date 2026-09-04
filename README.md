# RaceDay – Part 1
 
## System Description

RaceDay is a full-stack web-based event management system designed specifically for the South African road running, walking, and cycling community.

The system supports two main user roles: **Organiser** and **Participant**.

Organisers can create and manage events, categories, route information, participant enrolments, and race results. Participants can create accounts, browse upcoming events, enter events by selecting a category, view their enrolments, and track their personal results and performance history.

Part 1 focuses on planning the system before API development begins. It establishes the database design, Entity Relationship Diagram (ERD), RESTful API endpoint plan, SQL database script, repository structure, and initial CI/CD validation.

Live weather information is planned as an external API integration for a later part of the project and therefore does not require a separate database entity in the Part 1 relational model.

---

## User Roles

### Organiser

Organisers can:

- Create events.
- Edit events.
- Delete events.
- Manage event categories.
- Add and update route information.
- View participant enrolments for their events.
- Capture participant results.

### Participant

Participants can:

- Create an account.
- Log in to the system.
- Browse upcoming events.
- View event details.
- View event categories.
- View route information.
- Enter an event by selecting a category.
- View their own enrolments.
- Track their personal results and performance history.
- View live weather information for event preparation.

---

## Part 1 Database Design

The RaceDay database contains six main entities:

| Entity | Purpose |
|---|---|
| **Users** | Stores Organiser and Participant account information. |
| **Events** | Stores events created and managed by Organisers. |
| **Categories** | Stores the categories available for each event. |
| **Routes** | Stores route information for each event. |
| **Enrolments** | Records Participant entries into events and their selected categories. |
| **Results** | Stores race results linked to participant enrolments. |

The database uses primary keys, foreign keys, `NOT NULL`, `UNIQUE`, `DEFAULT`, and `CHECK` constraints to maintain data integrity.

### Main Relationships

- One **User** can organise many **Events**.
- One **Event** can have many **Categories**.
- One **Event** has one **Route**.
- One **Participant** can have many **Enrolments**.
- One **Event** can have many **Enrolments**.
- One **Category** can be selected by many **Enrolments**.
- One **Enrolment** can have zero or one **Result**.

The `Enrolments` table resolves the relationship between Participants and Events while also recording the category selected by the Participant.

---

## Part 1 Documents

All required Part 1 documents are stored inside the `/docs` folder.

### ERD

`docs/RaceDay-ERD.png`

The ERD shows the six database entities, their attributes, primary keys, foreign keys, and relationships.

### API Endpoint Plan

`docs/RaceDay-Endpoint-Plan.md`

The endpoint plan defines the RESTful API that will be implemented in Part 2.

### SQL Database Script

`docs/RaceDay.sql`

The SQL script creates and populates the RaceDay database using Microsoft SQL Server.

---

## Video Presentation

The Part 1 video presentation demonstrates and explains:

1. The purpose of the RaceDay system.
2. The Organiser role.
3. The Participant role.
4. The ERD and database relationships.
5. The database design decisions.
6. The RESTful API endpoint plan.
7. The SQL database structure.
8. The SQL script running successfully in SSMS.

### YouTube Presentation

**YouTube Video:** https://youtu.be/WzSAIiT8X4Y
## API Endpoint Planning

The RESTful API was planned during Part 1 before API implementation.

The endpoint plan covers the required RaceDay functionality:

- Authentication and registration.
- User profile management.
- Event management.
- Category management.
- Route management.
- Event enrolments.
- Participant results.
- Live weather information.

The Part 2 API implementation will follow the endpoint plan as closely as possible. Any necessary deviations will be documented and explained.

---

## SQL Database

The RaceDay database is designed for **Microsoft SQL Server** and was tested using **SQL Server Management Studio (SSMS)**.

The SQL script includes:

- Creation of the `RaceDayDB` database.
- Six relational database tables.
- Primary keys.
- Foreign keys.
- `NOT NULL` constraints.
- `UNIQUE` constraints.
- `DEFAULT` values.
- `CHECK` constraints.
- Two Organiser records.
- Two Participant records.
- Three sample events.
- Categories for each event.
- Route information for each event.
- Sample participant enrolments.
- Sample participant results.
- Verification queries.

### SQL Testing

The SQL script was executed successfully in SSMS.

The verification queries were used to confirm that the seeded data was inserted correctly into:

- `Users`
- `Events`
- `Categories`
- `Routes`
- `Enrolments`
- `Results`

---

## CI/CD

GitHub Actions is used to validate the required Part 1 repository structure.

The workflow checks that the required documentation files exist inside the `/docs` folder.

The required files are:

```text
docs/RaceDay-ERD.png
docs/RaceDay-Endpoint-Plan.md
docs/RaceDay.sql
