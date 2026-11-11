-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. reject pk department. Expected: pk_department, SQLSTATE 23505.
INSERT INTO portfolio."department" ("department_id", "name", "description", "created_date")
VALUES (101, 'Different Department', 'Synthetic duplicate primary key test.', '2026-03-01');

-- 2. reject uq department. Expected: uq_department_0, SQLSTATE 23505.
INSERT INTO portfolio."department" ("department_id", "name", "description", "created_date")
VALUES (1001, 'Community Care', 'Synthetic duplicate department name test.', '2026-03-02');

-- 3. reject nn department name. Expected: name, SQLSTATE 23502.
INSERT INTO portfolio."department" ("department_id", "name", "description", "created_date")
VALUES (1002, NULL, 'Synthetic not-null test.', '2026-03-03');

-- 4. reject pk member. Expected: pk_member, SQLSTATE 23505.
INSERT INTO portfolio."member" ("member_id", "first_name", "last_name", "email", "membership_status", "joined_date")
VALUES (201, 'Robin', 'Reed', 'robin.reed@example.test', 'active', '2026-03-01');

-- 5. reject uq member. Expected: uq_member_0, SQLSTATE 23505.
INSERT INTO portfolio."member" ("member_id", "first_name", "last_name", "email", "membership_status", "joined_date")
VALUES (1003, 'Robin', 'Reed', 'alex.morgan@example.test', 'active', '2026-03-02');

-- 6. reject pk worker. Expected: pk_worker, SQLSTATE 23505.
INSERT INTO portfolio."worker" ("worker_id", "department_id", "first_name", "last_name", "role", "start_date")
VALUES (301, 101, 'Robin', 'Reed', 'assistant', '2026-03-01');

-- 7. reject fk worker. Expected: fk_worker_0, SQLSTATE 23503.
INSERT INTO portfolio."worker" ("worker_id", "department_id", "first_name", "last_name", "role", "start_date")
VALUES (1004, 999001, 'Robin', 'Reed', 'assistant', '2026-03-02');

-- 8. reject pk activity. Expected: pk_activity, SQLSTATE 23505.
INSERT INTO portfolio."activity" ("activity_id", "department_id", "title", "activity_date", "location", "status")
VALUES (401, 101, 'Different Activity', '2026-03-01', 'Room C', 'scheduled');

-- 9. reject fk activity. Expected: fk_activity_0, SQLSTATE 23503.
INSERT INTO portfolio."activity" ("activity_id", "department_id", "title", "activity_date", "location", "status")
VALUES (1005, 999002, 'Unlinked Activity', '2026-03-02', 'Room D', 'scheduled');

-- 10. reject pk attendance. Expected: pk_attendance, SQLSTATE 23505.
INSERT INTO portfolio."attendance" ("attendance_id", "member_id", "activity_id", "session_date", "status", "recorded_at")
VALUES (501, 202, 402, '2026-02-08', 'absent', '2026-02-08T10:15:00Z');

-- 11. reject uq attendance. Expected: uq_attendance_0, SQLSTATE 23505.
INSERT INTO portfolio."attendance" ("attendance_id", "member_id", "activity_id", "session_date", "status", "recorded_at")
VALUES (1006, 201, 401, '2026-02-01', 'absent', '2026-02-01T11:00:00Z');

-- 12. reject fk attendance member. Expected: fk_attendance_0, SQLSTATE 23503.
INSERT INTO portfolio."attendance" ("attendance_id", "member_id", "activity_id", "session_date", "status", "recorded_at")
VALUES (1007, 999003, 401, '2026-02-02', 'present', '2026-02-02T10:15:00Z');

-- 13. reject fk attendance activity. Expected: fk_attendance_1, SQLSTATE 23503.
INSERT INTO portfolio."attendance" ("attendance_id", "member_id", "activity_id", "session_date", "status", "recorded_at")
VALUES (1008, 201, 999004, '2026-02-03', 'present', '2026-02-03T10:15:00Z');

-- 14. reject check attendance status. Expected: attendance_status_check, SQLSTATE 23514.
INSERT INTO portfolio."attendance" ("attendance_id", "member_id", "activity_id", "session_date", "status", "recorded_at")
VALUES (1009, 202, 402, '2026-02-09', 'pending', '2026-02-09T10:15:00Z');
