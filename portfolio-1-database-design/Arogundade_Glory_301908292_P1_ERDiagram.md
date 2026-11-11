# Church Management System Database Exercise — ER diagram

```mermaid
erDiagram
    direction LR
    department {
        bigint department_id PK
        text name UK
        text description "Optional"
        date created_date
    }
    member {
        bigint member_id PK
        text first_name
        text last_name
        text email UK "Optional"
        text membership_status
        date joined_date
    }
    worker {
        bigint worker_id PK
        bigint department_id FK
        text first_name
        text last_name
        text role
        date start_date
    }
    activity {
        bigint activity_id PK
        bigint department_id FK
        text title
        date activity_date
        text location
        text status
    }
    attendance {
        bigint attendance_id PK
        bigint member_id FK
        bigint activity_id FK
        date session_date
        text status
        timestamptz recorded_at
    }
    department ||--o{ worker : "department_id"
    department ||--o{ activity : "department_id"
    member ||--o{ attendance : "member_id"
    activity ||--o{ attendance : "activity_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Arogundade_Glory_301908292_ERDiagram.png)
