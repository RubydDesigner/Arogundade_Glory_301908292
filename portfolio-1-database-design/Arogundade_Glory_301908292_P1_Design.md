# Church Management System Database Exercise — database design

My case study records department, member, worker, activity, attendance.

## Users

- Church administrators maintaining member and department records
- Activity coordinators scheduling activities and reviewing attendance
- Workers supporting administration and activity operations

## Main operations

- Register members and assign workers to departments
- Schedule department activities and record member attendance
- Review attendance by activity, date, and department

## Entities

| Entity | Information stored |
| --- | --- |
| department | A church department that organizes activities and may have assigned workers. |
| member | A person registered as a member of the church. |
| worker | A church worker assigned to a department, with a role and start date. |
| activity | A scheduled church activity organized by one department. |
| attendance | A member's attendance status for an activity on a session date. |

## department

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| department_id | BIGINT | PK | Yes |
| name | TEXT | Unique | Yes |
| description | TEXT |  | No |
| created_date | DATE |  | Yes |
- Unique key: (name).

## member

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| member_id | BIGINT | PK | Yes |
| first_name | TEXT |  | Yes |
| last_name | TEXT |  | Yes |
| email | TEXT | Unique | No |
| membership_status | TEXT |  | Yes |
| joined_date | DATE |  | Yes |
- Unique key: (email).

## worker

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| worker_id | BIGINT | PK | Yes |
| department_id | BIGINT | FK | Yes |
| first_name | TEXT |  | Yes |
| last_name | TEXT |  | Yes |
| role | TEXT |  | Yes |
| start_date | DATE |  | Yes |
- department_id → department.department_id

## activity

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| activity_id | BIGINT | PK | Yes |
| department_id | BIGINT | FK | Yes |
| title | TEXT |  | Yes |
| activity_date | DATE |  | Yes |
| location | TEXT |  | Yes |
| status | TEXT |  | Yes |
- department_id → department.department_id

## attendance

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| attendance_id | BIGINT | PK | Yes |
| member_id | BIGINT | FK | Yes |
| activity_id | BIGINT | FK | Yes |
| session_date | DATE |  | Yes |
| status | TEXT |  | Yes |
| recorded_at | TIMESTAMPTZ |  | Yes |
- member_id → member.member_id
- activity_id → activity.activity_id
- Unique key: (member_id, activity_id, session_date).

## Relationships and business rules

- Each department name must be unique.
- Every worker must reference an existing department.
- Every activity must reference an existing department.
- Every attendance record must reference an existing member.
- Every attendance record must reference an existing activity.
- A member may have only one attendance record for an activity on a session date, enforced by a unique key across member_id, activity_id, and session_date.
- Attendance status must be present, absent, or excused.

## Assumptions

- Members and workers are modelled as distinct roles; a worker does not need a member record.
- Each activity belongs to one department and has one activity_date; recurring sessions are represented as separate activities.
- A member can have at most one attendance record per activity and session_date.
- Attendance status is limited to present, absent, or excused.
- Use a worked normalisation example rooted at Attendance: keep the attendance fact and its member_id and activity_id foreign keys in Attendance, member details in Member, and activity details in Activity, rather than repeating ancestor details in the attendance record.
- All identifiers and example records are synthetic; use globally unique values for each entity's single-column primary key.

