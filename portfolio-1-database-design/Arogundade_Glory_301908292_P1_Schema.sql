-- Church Management System Database Exercise: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."department" (
  "department_id" bigint NOT NULL,
  "name" text NOT NULL,
  "description" text,
  "created_date" date NOT NULL,
  CONSTRAINT "pk_department" PRIMARY KEY ("department_id"),
  CONSTRAINT "uq_department_0" UNIQUE ("name")
);
CREATE TABLE portfolio."member" (
  "member_id" bigint NOT NULL,
  "first_name" text NOT NULL,
  "last_name" text NOT NULL,
  "email" text,
  "membership_status" text NOT NULL,
  "joined_date" date NOT NULL,
  CONSTRAINT "pk_member" PRIMARY KEY ("member_id"),
  CONSTRAINT "uq_member_0" UNIQUE ("email")
);
CREATE TABLE portfolio."worker" (
  "worker_id" bigint NOT NULL,
  "department_id" bigint NOT NULL,
  "first_name" text NOT NULL,
  "last_name" text NOT NULL,
  "role" text NOT NULL,
  "start_date" date NOT NULL,
  CONSTRAINT "pk_worker" PRIMARY KEY ("worker_id")
);
CREATE TABLE portfolio."activity" (
  "activity_id" bigint NOT NULL,
  "department_id" bigint NOT NULL,
  "title" text NOT NULL,
  "activity_date" date NOT NULL,
  "location" text NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_activity" PRIMARY KEY ("activity_id")
);
CREATE TABLE portfolio."attendance" (
  "attendance_id" bigint NOT NULL,
  "member_id" bigint NOT NULL,
  "activity_id" bigint NOT NULL,
  "session_date" date NOT NULL,
  "status" text NOT NULL,
  "recorded_at" timestamptz NOT NULL,
  CONSTRAINT "pk_attendance" PRIMARY KEY ("attendance_id"),
  CONSTRAINT "uq_attendance_0" UNIQUE ("member_id", "activity_id", "session_date")
);
ALTER TABLE portfolio."worker" ADD CONSTRAINT "fk_worker_0" FOREIGN KEY ("department_id") REFERENCES portfolio."department" ("department_id");
ALTER TABLE portfolio."activity" ADD CONSTRAINT "fk_activity_0" FOREIGN KEY ("department_id") REFERENCES portfolio."department" ("department_id");
ALTER TABLE portfolio."attendance" ADD CONSTRAINT "fk_attendance_0" FOREIGN KEY ("member_id") REFERENCES portfolio."member" ("member_id");
ALTER TABLE portfolio."attendance" ADD CONSTRAINT "fk_attendance_1" FOREIGN KEY ("activity_id") REFERENCES portfolio."activity" ("activity_id");
ALTER TABLE portfolio."attendance" ADD CONSTRAINT "attendance_status_check" CHECK (("status" IS NULL) OR ("status" = 'present') OR ("status" = 'absent') OR ("status" = 'excused'));
COMMIT;
