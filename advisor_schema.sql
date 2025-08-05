
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
