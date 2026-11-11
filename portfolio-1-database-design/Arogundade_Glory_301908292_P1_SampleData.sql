-- Fictional sample records for Church Management System Database Exercise.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."department" ("department_id", "name", "description", "created_date") VALUES (101, 'Community Care', 'Synthetic department for member support.', '2026-01-10');
INSERT INTO portfolio."member" ("member_id", "first_name", "last_name", "email", "membership_status", "joined_date") VALUES (201, 'Alex', 'Morgan', 'alex.morgan@example.test', 'active', '2026-01-15');
INSERT INTO portfolio."member" ("member_id", "first_name", "last_name", "email", "membership_status", "joined_date") VALUES (202, 'Sam', 'Taylor', 'sam.taylor@example.test', 'active', '2026-01-20');
INSERT INTO portfolio."worker" ("worker_id", "department_id", "first_name", "last_name", "role", "start_date") VALUES (301, 101, 'Jamie', 'Lee', 'coordinator', '2026-01-12');
INSERT INTO portfolio."activity" ("activity_id", "department_id", "title", "activity_date", "location", "status") VALUES (401, 101, 'Community Gathering', '2026-02-01', 'Hall A', 'scheduled');
INSERT INTO portfolio."activity" ("activity_id", "department_id", "title", "activity_date", "location", "status") VALUES (402, 101, 'Service Workshop', '2026-02-08', 'Hall B', 'scheduled');
INSERT INTO portfolio."attendance" ("attendance_id", "member_id", "activity_id", "session_date", "status", "recorded_at") VALUES (501, 201, 401, '2026-02-01', 'present', '2026-02-01T10:15:00Z');
COMMIT;
