# Portfolio 4 — NoSQL and Advanced Data Models

I used MongoDB collection church_activity_events for activity_scheduled and attendance_recorded events. These are fictional event examples based on activity, attendance, member.

## Document model

| Field | Meaning |
| --- | --- |
| _id | Unique string event ID |
| eventType | One of the two selected case event labels |
| occurredAt | Native BSON Date; sample timestamps are in 2030 |
| source | Original entity, primary key and saved JSON snapshot |
| embedded | Linked record snapshots read with the event |
| references | Keys for linked sources kept outside the embedded snapshots |
| details | Event metadata whose fields vary |

Related member details are stored as snapshots with the event. This makes an event readable in one document. It duplicates some information, and later SQL changes do not automatically update the snapshots. PostgreSQL continues to enforce the relational rules.

## Example document

```javascript
{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "activity_scheduled",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "attendance",
        "key": {
            "attendance_id": 501
        },
        "snapshot": {
            "attendance_id": 501,
            "member_id": 201,
            "activity_id": 401,
            "session_date": "2026-02-01",
            "status": "present",
            "recorded_at": "2026-02-01T10:15:00Z"
        }
    },
    "embedded": {
        "member": [
            {
                "key": {
                    "member_id": 201
                },
                "snapshot": {
                    "member_id": 201,
                    "first_name": "Alex",
                    "last_name": "Morgan",
                    "email": "alex.morgan@example.test",
                    "membership_status": "active",
                    "joined_date": "2026-01-15"
                },
                "via": [
                    "attendance.member_id → member"
                ]
            }
        ]
    },
    "references": {
        "activity": [
            {
                "key": {
                    "activity_id": 401
                },
                "via": [
                    "attendance.activity_id → activity"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}
```

## Queries and results

| Query | Returned documents |
| --- | --- |
| Find the first sample event type (up to five documents). | 1 |
| Find events for the first source record using nested key fields (up to five). | 2 |
| Find events in the sample time range using a MongoDB Date filter (up to five). | 2 |
| Count documents for each event type. | 2 |

## 1. Find the first sample event type (up to five documents).

```javascript
db.getCollection("church_activity_events").find({"eventType":"activity_scheduled"}).sort({_id:1}).limit(5).toArray();
```

Selected fields from the returned documents:

```json
[
  {
    "_id": "event_000001",
    "eventType": "activity_scheduled",
    "occurredAt": {
      "$date": "2030-01-01T10:00:00Z"
    },
    "source": {
      "attendance_id": 501
    }
  }
]
```

## 2. Find events for the first source record using nested key fields (up to five).

```javascript
db.getCollection("church_activity_events").find({"source.key.attendance_id":501}).sort({_id:1}).limit(5).toArray();
```

Selected fields from the returned documents:

```json
[
  {
    "_id": "event_000001",
    "eventType": "activity_scheduled",
    "occurredAt": {
      "$date": "2030-01-01T10:00:00Z"
    },
    "source": {
      "attendance_id": 501
    }
  },
  {
    "_id": "event_000002",
    "eventType": "attendance_recorded",
    "occurredAt": {
      "$date": "2030-01-01T10:01:00Z"
    },
    "source": {
      "attendance_id": 501
    }
  }
]
```

## 3. Find events in the sample time range using a MongoDB Date filter (up to five).

```javascript
db.getCollection("church_activity_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray();
```

Selected fields from the returned documents:

```json
[
  {
    "_id": "event_000001",
    "eventType": "activity_scheduled",
    "occurredAt": {
      "$date": "2030-01-01T10:00:00Z"
    },
    "source": {
      "attendance_id": 501
    }
  },
  {
    "_id": "event_000002",
    "eventType": "attendance_recorded",
    "occurredAt": {
      "$date": "2030-01-01T10:01:00Z"
    },
    "source": {
      "attendance_id": 501
    }
  }
]
```

## 4. Count documents for each event type.

```javascript
db.getCollection("church_activity_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray();
```

| _id | documentCount |
| --- | --- |
| activity_scheduled | 1 |
| attendance_recorded | 1 |

## Validation and suitability

MongoDB inserted 2 documents. An invalid date type was rejected with code 121 and a repeated event ID with 11000. The collection still contained 2 valid documents. The compound eventType/occurredAt index supports those access fields; this exercise does not measure its speed.

The details field can vary across event types, while the common fields have a validator. Events can be added as separate documents rather than growing one large history record.

## Run the script

Connect mongosh to a fresh exercise database and run Arogundade_Glory_301908292_P4_MongoDB.js. It selects portfolio_nosql, creates the collection, inserts the sample documents and displays the query results. [Implementation evidence](screenshots/Arogundade_Glory_301908292_P4_DocumentsAndQueries.png).

## References

- [MongoDB — data modelling](https://www.mongodb.com/docs/manual/data-modeling/)

