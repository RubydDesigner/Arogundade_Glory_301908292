-- Show related attendance, member, activity records (up to 20).
SELECT t0."attendance_id" AS "attendance_attendance_id",
       t0."session_date" AS "attendance_session_date",
       t1."member_id" AS "member_member_id",
       t1."first_name" AS "member_first_name",
       t2."activity_id" AS "activity_activity_id",
       t2."title" AS "activity_title"
FROM portfolio."attendance" t0
JOIN portfolio."member" t1 ON t0."member_id" = t1."member_id"
JOIN portfolio."activity" t2 ON t0."activity_id" = t2."activity_id"
ORDER BY t0."attendance_id", t1."member_id", t2."activity_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."attendance_id" AS "attendance_attendance_id",
       t0."session_date" AS "attendance_session_date",
       t1."member_id" AS "member_member_id",
       t1."first_name" AS "member_first_name",
       t2."activity_id" AS "activity_activity_id",
       t2."title" AS "activity_title"
FROM portfolio."attendance" t0
JOIN portfolio."member" t1 ON t0."member_id" = t1."member_id"
JOIN portfolio."activity" t2 ON t0."activity_id" = t2."activity_id"
ORDER BY t0."attendance_id", t1."member_id", t2."activity_id"
LIMIT 20;

-- Find attendance records where session_date matches "2026-02-01" (up to 20).
SELECT * FROM portfolio."attendance"
WHERE "session_date" IS NOT DISTINCT FROM '2026-02-01'
ORDER BY "attendance_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."attendance"
WHERE "session_date" IS NOT DISTINCT FROM '2026-02-01'
ORDER BY "attendance_id"
LIMIT 20;

-- Count attendance records for each member_id (up to 20 groups).
SELECT "member_id", count(*) AS record_count
FROM portfolio."attendance"
GROUP BY "member_id"
ORDER BY record_count DESC, "member_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "member_id", count(*) AS record_count
FROM portfolio."attendance"
GROUP BY "member_id"
ORDER BY record_count DESC, "member_id" NULLS LAST
LIMIT 20;
