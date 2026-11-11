# Church Management System Database Exercise — SQL queries

## 1. Show related attendance, member, activity records (up to 20).

```sql
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
```

| attendance_attendance_id | attendance_session_date | member_member_id | member_first_name | activity_activity_id | activity_title |
| --- | --- | --- | --- | --- | --- |
| 501 | 2026-02-01 | 201 | Alex | 401 | Community Gathering |

## 2. Find attendance records where session_date matches "2026-02-01" (up to 20).

```sql
SELECT * FROM portfolio."attendance"
WHERE "session_date" IS NOT DISTINCT FROM '2026-02-01'
ORDER BY "attendance_id"
LIMIT 20;
```

| attendance_id | member_id | activity_id | session_date | status | recorded_at |
| --- | --- | --- | --- | --- | --- |
| 501 | 201 | 401 | 2026-02-01 | present | 2026-02-01T10:15:00+00:00 |

## 3. Count attendance records for each member_id (up to 20 groups).

```sql
SELECT "member_id", count(*) AS record_count
FROM portfolio."attendance"
GROUP BY "member_id"
ORDER BY record_count DESC, "member_id" NULLS LAST
LIMIT 20;
```

| member_id | record_count |
| --- | --- |
| 201 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.941 | 0.941, 0.932, 1.124 | Sort → Seq Scan | 112 |
| After index | 0.167 | 0.165, 0.183, 0.167 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.941 ms to 0.167 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.916..0.917 rows=20 loops=1)
  Seq Scan on attendance (actual time=0.016..0.88 rows=20 loops=1)
Planning Time: 0.342 ms
Execution Time: 0.941 ms
```

### Before index, run 2

```text
Sort (actual time=0.907..0.908 rows=20 loops=1)
  Seq Scan on attendance (actual time=0.016..0.873 rows=20 loops=1)
Planning Time: 0.336 ms
Execution Time: 0.932 ms
```

### Before index, run 3

```text
Sort (actual time=1.095..1.097 rows=20 loops=1)
  Seq Scan on attendance (actual time=0.022..1.05 rows=20 loops=1)
Planning Time: 0.434 ms
Execution Time: 1.124 ms
```

### After index, run 1

```text
Sort (actual time=0.123..0.125 rows=20 loops=1)
  Bitmap Heap Scan on attendance (actual time=0.027..0.089 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.013 rows=20 loops=1)
Planning Time: 0.548 ms
Execution Time: 0.165 ms
```

### After index, run 2

```text
Sort (actual time=0.138..0.139 rows=20 loops=1)
  Bitmap Heap Scan on attendance (actual time=0.026..0.102 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.012 rows=20 loops=1)
Planning Time: 0.54 ms
Execution Time: 0.183 ms
```

### After index, run 3

```text
Sort (actual time=0.123..0.125 rows=20 loops=1)
  Bitmap Heap Scan on attendance (actual time=0.025..0.089 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.013 rows=20 loops=1)
Planning Time: 0.558 ms
Execution Time: 0.167 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Arogundade_Glory_301908292_P2_Queries.sql, then Arogundade_Glory_301908292_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Arogundade_Glory_301908292_P2_QueryResults.png) · [Index comparison](screenshots/Arogundade_Glory_301908292_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

