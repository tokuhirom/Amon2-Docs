CREATE TABLE IF NOT EXISTS sessions (
    id           CHAR(72) PRIMARY KEY,
    session_data TEXT
);

CREATE TABLE IF NOT EXISTS entry (
    entry_id INTEGER NOT NULL PRIMARY KEY,
    body varchar(255) not null
);
