
-- SQLite schema

CREATE TABLE contact (
    contact_id INTEGER PRIMARY KEY,
    advisor_id INTEGER NOT NULL,
    first_name TEXT,
    last_name TEXT,
    phone_number TEXT,
    email_address TEXT,
    sync_status TEXT,
    last_sync TIMESTAMP,
    last_update TIMESTAMP
);


CREATE TABLE IF NOT EXISTS advisor (
  advisor_id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  name TEXT
);

INSERT INTO advisor (username, password, name)
VALUES
  ('advisor1', 'pass123', 'Alice Advisor'),
  ('advisor2', 'pass456', 'Bob Consultant'),
  ('advisor3', 'pass789', 'Charlie Coach');


CREATE TABLE lead (
    lead_id INTEGER PRIMARY KEY,
    advisor_id INTEGER NOT NULL,
    contact_id INTEGER,
    lead_type TEXT,
    lead_total REAL,
    due_date TIMESTAMP,
    sync_status TEXT,
    last_sync TIMESTAMP,
    last_update TIMESTAMP
);

CREATE TABLE activity (
    activity_id INTEGER PRIMARY KEY,
    advisor_id INTEGER NOT NULL,
    lead_id INTEGER,
    contact_id INTEGER,
    activity_type TEXT,
    lead_total REAL,
    due_date TIMESTAMP,
    sync_status TEXT,
    last_sync TIMESTAMP,
    last_update TIMESTAMP
);

CREATE TABLE "order" (
    order_id INTEGER PRIMARY KEY,
    advisor_id INTEGER NOT NULL,
    contact_id INTEGER,
    lead_id INTEGER,
    activity_id INTEGER,
    order_status TEXT,
    order_total REAL,
    sync_status TEXT,
    last_sync TIMESTAMP,
    last_update TIMESTAMP
);

-- Dummy Data
INSERT INTO contact VALUES (1, 101, 'John', 'Doe', '1234567890', 'john@example.com', 'synced', datetime('now'), datetime('now'));
INSERT INTO contact VALUES (2, 101, 'Jane', 'Smith', '0987654321', 'jane@example.com', 'pending', datetime('now'), datetime('now'));

INSERT INTO lead VALUES (1, 101, 1, 'Product A', 500.00, datetime('now'), 'synced', datetime('now'), datetime('now'));
INSERT INTO lead VALUES (2, 101, 2, 'Product B', 800.00, datetime('now'), 'pending', datetime('now'), datetime('now'));

INSERT INTO activity VALUES (1, 101, 1, 1, 'Thermomix Demo', 500.00, datetime('now'), 'synced', datetime('now'), datetime('now'));
INSERT INTO activity VALUES (2, 101, 2, 2, 'Vorwerk Visit', 800.00, datetime('now'), 'pending', datetime('now'), datetime('now'));

INSERT INTO "order" VALUES (1, 101, 1, 1, 1, 'confirmed', 500.00, 'synced', datetime('now'), datetime('now'));
INSERT INTO "order" VALUES (2, 101, 2, 2, 2, 'pending', 800.00, 'pending', datetime('now'), datetime('now'));
