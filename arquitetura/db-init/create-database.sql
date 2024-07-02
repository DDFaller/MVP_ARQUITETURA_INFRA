CREATE DATABASE mvp;

\connect mvp

CREATE SCHEMA models;
CREATE SCHEMA "user";

CREATE TABLE "models".clothes(

  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  model_name VARCHAR(140) NOT NULL,
  model_url VARCHAR(140)
);


CREATE TABLE "user".user_data(
  id SERIAL PRIMARY KEY,
  cpf VARCHAR(40) NOT NULL,
  password VARCHAR(40) NOT NULL
);


