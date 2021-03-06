-- Your SQL goes here

CREATE TABLE users (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(255),
  email VARCHAR(255),
  bio VARCHAR(1023) default "New here!",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
  password VARCHAR(255),
  admin BOOLEAN default false,
  show_email BOOLEAN default false,
  remote_user BOOLEAN default false,
  website VARCHAR(255) default "",
  can_invite boolean default false
);
CREATE UNIQUE INDEX users_username_idx ON users (username);
CREATE UNIQUE INDEX users_email_idx ON users (email);

CREATE TABLE registration_keys (
  value VARCHAR PRIMARY KEY,
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  inviting_user_id REFERENCES users(id)
);

CREATE TABLE activities (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  json_text TEXT
);


CREATE TABLE sessions (
  id INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
  cookie VARCHAR NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users (id),
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);


CREATE TABLE notes (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER REFERENCES users(id),
    content TEXT,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    in_reply_to references notes(id),
    neighborhood BOOLEAN,
    is_remote boolean default false,
    remote_url varchar(1000),
    remote_creator varchar(1000),
    remote_id varchar(1000)
);

create table server_mutuals (
  id integer primary key autoincrement,
  actor_id VARCHAR(1000),
  inbox_url VARCHAR(1000),
  accepted boolean default false,
  followed_back boolean default false,
  outbox_url VARCHAR(1000)
);

create unique index unique_inbox on server_mutuals(actor_id);
