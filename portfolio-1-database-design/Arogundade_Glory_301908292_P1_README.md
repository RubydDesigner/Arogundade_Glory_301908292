# Portfolio 1 — Database Design and Modelling

I organised the data into department, member, worker, activity, attendance. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| department | 1 |
| member | 2 |
| worker | 1 |
| activity | 2 |
| attendance | 1 |

The 14 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Arogundade_Glory_301908292_P1_Design.md)
- [ER diagram](Arogundade_Glory_301908292_P1_ERDiagram.md)
- [Normalisation](Arogundade_Glory_301908292_P1_Normalisation.md)
- [Schema](Arogundade_Glory_301908292_P1_Schema.sql)
- [Sample data](Arogundade_Glory_301908292_P1_SampleData.sql)
- [Constraint tests](Arogundade_Glory_301908292_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Arogundade_Glory_301908292_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

