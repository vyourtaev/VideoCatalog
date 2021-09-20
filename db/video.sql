CREATE TABLE IF NOT EXISTS video (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT UNIQUE,
    release INTEGER,
    format TEXT,
    stars TEXT,
    created TIMESTAMP,
    updated TIMESTAMP
);
