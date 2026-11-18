CREATE SCHEMA IF NOT EXISTS gold;


--dim user
CREATE TABLE gold.dim_user(
    user_id INT NOT NULL UNIQUE,
    gender CHAR(1) NOT NULL CHECK(gender IN ('M', 'F')),
    zip_code VARCHAR(10),
    age_group VARCHAR(20) NOT NULL,
    occupation VARCHAR(50) NOT NULL
);

--dim filmy
CREATE TABLE gold.dim_movie(
    user_id INT NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    release_year INT,
    genre VARCHAR(200) NOT NULL --vsetky zanre budu v jednom riadku ci co to zveraj udajne povedala janka
);

--dim date
CREATE TABLE gold.dim_date(
    date_id INT PRIMARY KEY,
    rated_at DATE NOT NULL UNIQUE,
    day INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    day_of_week INT NOT NULL,
    day_name VARCHAR(10) NOT NULL,
    week INT NOT NULL,
    month_name VARCHAT(10) NOT NULL,
    quarter INT NOT NULL
);

--dim time 
CREATE TABLE gold.dim_time(
    date_id INT PRIMARY KEY,
    rated_at DATE NOT NULL UNIQUE,
    hour INT NOT NULL,
    minute INT NOT NULL,
    second INT NOT NULL,
    time_of_day VARCHAR(10) NOT NULL
);

--fact rating
CREATE TABLE gold.fact_rating(
    rating_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES gold.dim_user(user_id), 
    movie_id INT NOT NULL REFERENCES gold.dim_movie(movie_id), 
    date_id INT NOT NULL REFERENCES gold.dim_date(date_id), 
    time_id INT NOT NULL REFERENCES gold.dim_time(time_id), 
    rating NUMERIC(2,1) NOT NULL CHECK(rating BETWEEN 1 AND 5),
    rating_count INT NOT NULL, -- pocet vsetkych hodnoteni
    rating_percentage INT NOT NULL --hodnotenie v percentach
);

--index na cuzdie kluce 
CREATE INDEX ON gold.fact_rating(user_id);
CREATE INDEX ON gold.fact_rating(movie_id);
CREATE INDEX ON gold.fact_rating(date_id);
CREATE INDEX ON gold.fact_rating(time_id);

BEGIN;

TRUNCATE gold.fact_rating,
gold.dim_user,
gold.dim_movie,
gold.dim_date,
gold.dim_time;


--dim user 
INSERT INTO 
    gold.dim_user(
        user_id,
        gender,
        zip_code,
        age_group,
        occupation
    )SELECT u.user_id, u.gender, u.zip_code, COALESCE(ag.age_group_name, 'Unknown') AS age_group, COEALESCE(o.occupation, 'Unknown') AS occupation
    FROM silver.stg_users u 
    LEFT JOIN silver.stg_age_groups ag ON ag.age_group_id = u.age
    LEFT JOIN silver.stg_occupations o ON o.occupation_id = u.occupation_id
ORDER BY u.user_id;  