# Church Management System Database Exercise — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| member_id | attendance records (list) |
| --- | --- |
| 201 | [501] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| attendance.attendance_id | attendance.member_id | attendance.activity_id | attendance.status | member.member_id | member.first_name | activity.activity_id | activity.department_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 501 | 201 | 401 | present | 201 | Alex | 401 | 101 |

Key: attendance_id.

## 2NF: depend on the whole key

attendance: member_id is a proper part of candidate key (member_id, activity_id, session_date), and determines member details. attendance: activity_id is a proper part of candidate key (member_id, activity_id, session_date), and determines activity details.

## member_example

| member.member_id | member.first_name |
| --- | --- |
| 201 | Alex |

## activity_example

| activity.activity_id | activity.department_id |
| --- | --- |
| 401 | 101 |

## attendance_example

| attendance.attendance_id | attendance.member_id | attendance.activity_id | attendance.status |
| --- | --- | --- | --- |
| 501 | 201 | 401 | present |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## department

| department_id | name | description | created_date |
| --- | --- | --- | --- |
| 101 | Community Care | Synthetic department for member support. | 2026-01-10 |

## member

| member_id | first_name | last_name | email | membership_status | joined_date |
| --- | --- | --- | --- | --- | --- |
| 201 | Alex | Morgan | alex.morgan@example.test | active | 2026-01-15 |
| 202 | Sam | Taylor | sam.taylor@example.test | active | 2026-01-20 |

## worker

| worker_id | department_id | first_name | last_name | role | start_date |
| --- | --- | --- | --- | --- | --- |
| 301 | 101 | Jamie | Lee | coordinator | 2026-01-12 |

## activity

| activity_id | department_id | title | activity_date | location | status |
| --- | --- | --- | --- | --- | --- |
| 401 | 101 | Community Gathering | 2026-02-01 | Hall A | scheduled |
| 402 | 101 | Service Workshop | 2026-02-08 | Hall B | scheduled |

## attendance

| attendance_id | member_id | activity_id | session_date | status | recorded_at |
| --- | --- | --- | --- | --- | --- |
| 501 | 201 | 401 | 2026-02-01 | present | 2026-02-01T10:15:00+00:00 |

## Dependencies

- department: (department_id) → name, description, created_date
- member: (member_id) → first_name, last_name, email, membership_status, joined_date
- worker: (worker_id) → department_id, first_name, last_name, role, start_date
- activity: (activity_id) → department_id, title, activity_date, location, status
- attendance: (attendance_id) → member_id, activity_id, session_date, status, recorded_at

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
