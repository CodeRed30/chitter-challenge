CREATE TABLE peeps(id SERIAL PRIMARY KEY, message VARCHAR(140), time TIMESTAMP NOT NULL DEFAULT NOW());
ALTER TABLE peeps ADD COLUMN user_id INTEGER REFERENCES users (id);