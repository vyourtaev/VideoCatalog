--
-- Add users and role tables, along with a many-to-many join table
--
PRAGMA foreign_keys = ON;
CREATE TABLE users (
    id            INTEGER PRIMARY KEY,
    username      TEXT,
    password      TEXT,
    email_address TEXT,
    first_name    TEXT,
    last_name     TEXT,
    active        INTEGER
);
CREATE TABLE role (
    id   INTEGER PRIMARY KEY,
    role TEXT
);
CREATE TABLE user_role (
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    role_id INTEGER REFERENCES role(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_id, role_id)
);
--
-- Load up some initial test data
--
INSERT INTO users VALUES (1, 'admin', 'admin', 'admin@yourtaev.name', 'Vova',  'Yourtaev', 1);
INSERT INTO users VALUES (2, 'user', 'user', 'marina@yourtaev.name', 'Marina', 'Yourtaev',  1);
INSERT INTO users VALUES (3, 'test03', 'mypass', 't03@na.com', 'No',   'Go',   0);
INSERT INTO role VALUES (2, 'user');
INSERT INTO role VALUES (1, 'admin');
INSERT INTO user_role VALUES (1, 1);
INSERT INTO user_role VALUES (1, 2);
INSERT INTO user_role VALUES (2, 2);
INSERT INTO user_role VALUES (3, 2);
