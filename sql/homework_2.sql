-- ФИО
SELECT 'ФИО: Томчик Никита Сергеевич';

-- Simple selects
SELECT * FROM movie.ratings LIMIT 10;

SELECT
    *
FROM movie.links
WHERE
    imdbid LIKE "%42"
    AND movieid > 100
    AND movieid < 1000
LIMIT 10;

-- Complicated selects. JOIN

SELECT
    DISTINCT(ml.imdbid)
FROM movie.links ml
INNER JOIN movie.ratings mr
    ON mr.movieid = ml.movieid
WHERE mr.rating = 5
LIMIT 10;

-- Data aggregation. Basic stats

SELECT
    COUNT(DISTINCT(ml.movieid))
FROM movie.links ml
LEFT JOIN movie.ratings mr
    ON ml.movieid = mr.movieid
WHERE mr.movieid is NULL;

SELECT
    userid, avg(rating) as avg_rating
FROM movie.ratings
GROUP BY userid
HAVING avg(rating) > 3.5
LIMIT 10;

-- Hierachical sub-queries
SELECT
    ml.imdbid
FROM movie.links ml
WHERE ml.movieid IN (
    SELECT
        movieid
    FROM movie.ratings
    GROUP BY movieid
    HAVING avg(rating) > 3.5
)
LIMIT 10;


-- Common Table Expressions
WITH avg_user_ratings AS (
    SELECT
        userid, avg(rating) AS avg_user_rating
    FROM movie.ratings
    GROUP BY userid
    HAVING count(rating) > 10
)
SELECT avg(avg_user_rating) FROM avg_user_ratings;
