CREATE SCHEMA IF NOT EXISTS gowebapp;

-- ************************************** gowebapp.users

CREATE TABLE gowebapp.users
(
    User_ID        bigserial PRIMARY KEY,
    User_Name      text      NOT NULL,
    Pass_Word_Hash text      NOT NULL,
    Name           text      NOT NULL,
    Config         jsonb     NOT NULL DEFAULT '{}'::JSONB,
    Created_At     TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    Is_Enabled     boolean   NOT NULL DEFAULT TRUE
);

-- ************************************** gowebapp.exercises

CREATE TABLE gowebapp.exercises
(
    Exercise_ID   bigserial PRIMARY KEY,
    Exercise_Name text      NOT NULL
);

-- ************************************** gowebapp.images

CREATE TABLE gowebapp.images
(
    Image_ID     bigserial PRIMARY KEY,
    User_ID      bigint    NOT NULL,
    Content_Type text      NOT NULL DEFAULT 'image/png',
    Image_Data   bytea     NOT NULL
);

-- ************************************** gowebapp.sets

CREATE TABLE gowebapp.sets
(
    Set_ID      bigserial PRIMARY KEY,
    Exercise_ID bigserial NOT NULL,
    Weight      int       NOT NULL DEFAULT 0
);

-- ************************************** gowebapp.workouts

CREATE TABLE gowebapp.workouts
(
    Workout_ID bigserial PRIMARY KEY,
    Set_ID     bigint    NOT NULL,
    User_ID    bigint    NOT NULL,
    Start_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);