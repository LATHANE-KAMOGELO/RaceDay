# RaceDay – Part 1

## System Description

RaceDay is a web-based event management system designed specifically for the South African road running, walking and cycling community.

The system allows Event Organisers** to create and manage events, categories and route information, view participant enrolments and capture race results. **Participants** can create accounts, browse upcoming events, enter events by selecting a category, view their own enrolments and track their personal performance history.

The Part 1 design provides the database and REST API foundation required for Parts 2 and 3. Live weather information is planned as an external service integration and does not require a separate database entity in the Part 1 relational model.

## User Roles

### Organiser

Organisers can:

- Create, edit and delete events.
- Manage event categories.
- Add and update route information.
- View enrolments for their events.
- Capture participant results.

### Participant

Participants can:

- Create an account and log in.
- Browse upcoming events.
- View event categories and route information.
- Enter an event by selecting a category.
- View their own enrolments.
- Track their personal results and performance history.
- View live weather information for event preparation.

## Part 1 Database Design

The RaceDay relational database contains six main entities:

1. **Users** – stores Organiser and Participant accounts.
2. **Events** – stores events created by Organisers.
3. **Categories** – stores categories available for each event.
4. **Routes** – stores route information for each event.
5. **Enrolments** – records Participant entries into events and selected categories.
6. **Results** – stores race results linked to enrolments.

The database uses primary keys, foreign keys, unique constraints, default values and check constraints to maintain data integrity.

## Part 1 Documents

The `/docs` folder contains the following planning and database documents:

- `docs/RaceDay-ERD.png` – Entity Relationship Diagram showing the six database entities, keys and relationships.
- `docs/RaceDay-Endpoint-Plan.md` – RESTful API endpoint plan for the Part 2 API.
- `docs/RaceDay.sql` – SQL Server database creation script, constraints and sample seed data.

## API Planning

The planned REST API covers the required RaceDay functionality:

- Authentication and registration.
- User profile management.
- Event management.
- Event category management.
- Route management.
- Participant enrolments.
- Participant results.
- Live weather information.

The API endpoint plan was completed during Part 1 before API implementation begins in Part 2. The Part 2 implementation should closely follow the planned routes and request/response structure.

## SQL Database

The SQL script is designed for **Microsoft SQL Server** and can be executed using **SQL Server Management Studio (SSMS)**.

The script includes:

- Database creation.
- Six relational database tables.
- Primary and foreign keys.
- `NOT NULL`, `UNIQUE`, `DEFAULT` and `CHECK` constraints.
- Two Organiser accounts.
- Two Participant accounts.
- Three sample events.
- Categories for each event.
- Route information for each event.
- Sample participant enrolments.
- Sample participant results.
- Verification queries.

## CI/CD

GitHub Actions is used to validate the Part 1 repository structure and required documentation.

The workflow should confirm that:

- The `/docs` folder exists.
- The ERD file exists.
- The API endpoint plan exists.
- The SQL script exists.
- The repository contains the required project files.

A successful workflow run must display a **green check mark** before submission.

Add the screenshot of the successful GitHub Actions run below:

```markdown
![Successful GitHub Actions build](docs/ci-success.png)
```

## Video Presentation

An unlisted YouTube video must be submitted for Part 1.

The presentation should demonstrate and explain:

- The RaceDay system purpose.
- The two user roles.
- The ERD and database relationships.
- The API endpoint planning decisions.
- The SQL database script.
- The SQL script running successfully in SSMS.

**YouTube:** LINK.

## Part 1 Submission Checklist

- [ ] ERD committed to `/docs`.
- [ ] API endpoint plan committed to `/docs`.
- [ ] SQL script committed to `/docs`.
- [ ] ERD relationships match the SQL database.
- [ ] API endpoint plan matches the planned Part 2 functionality.
- [ ] SQL script tested successfully in SSMS on a clean database.
- [ ] At least 20 meaningful commits completed.
- [ ] GitHub Actions workflow is successful.
- [ ] Green-build screenshot added to the README.
- [ ] Part 1 YouTube presentation uploaded as unlisted.
- [ ] YouTube link added to the README.
- [ ] GitHub repository link submitted on ARC.

## Project Structure


RaceDay/
│
├── docs/
│   ├── RaceDay-ERD.png
│   ├── RaceDay-Endpoint-Plan.md
│   └── RaceDay.sql
│
├── .github/
│   └── workflows/
│       └── docs-check.yml
│
└── README.md
## Part 1 Status

**Planning and database phase:** In progress

The project will proceed to Part 2 after the Part 1 ERD, API endpoint plan, SQL script, GitHub Actions workflow and documentation have been reviewed and tested.
