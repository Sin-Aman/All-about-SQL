CREATE TABLE friends (
  id INTEGER,
  name TEXT,
  birthday DATE
);

INSERT INTO friends VALUES (
  1,
  'Ororo Munroe',
  '1940-05-30'
);

INSERT INTO friends VALUES (
  2,
  'Rudolf Dassler',
  '1952-10-08'
);

INSERT INTO friends VALUES (
  3,
  'Harry Kane',
  '1993-02-20'
);


ALTER TABLE friends ADD COLUMN email TEXT;

UPDATE friends SET email = 'storm@academy.com' WHERE id = 1;

DELETE FROM friends WHERE id = 1;

SELECT * FROM friends;