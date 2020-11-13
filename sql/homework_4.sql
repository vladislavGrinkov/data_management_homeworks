CREATE TABLE movie.content_genres (
    movieid numeric,
    genre TEXT
);

\copy movie.content_genres FROM '/usr/share/data_store/raw_data/genres.csv' DELIMITER ',';


WITH top_rated AS (
    SELECT
        movieid,
        avg(rating) AS avg_rating
    FROM movie.ratings
    GROUP BY movieid
    HAVING count(*) >= 50
    ORDER BY avg_rating DESC, movieid ASC
    LIMIT 150
)
SELECT
    tt.movieid,
    tt.avg_rating,
    kw.keywords
INTO movie.ratings_and_keywords
FROM top_rated tt
INNER JOIN (
    SELECT
        movieid,
        array_agg(genre) AS keywords
    FROM movie.content_genres
    GROUP BY movieid
) kw
    ON kw.movieid = tt.movieid;


\copy movie.ratings_and_keywords TO '/usr/share/data_store/raw_data/top_rated_movies_with_keywords.csv' DELIMITER ',';