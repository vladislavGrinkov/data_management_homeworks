-- ФИО
SELECT 'ФИО: Томчик Никита Сергеевич';


-- Window functions

SELECT
    userid,
    movieid,
    AVG(rating) OVER (PARTITION BY userid) as avg_user_rating,
    ( (rating - MIN(rating) OVER w) / (MAX(rating) OVER w - MIN(rating) OVER w) ) as normed_rating
FROM movie.ratings
WINDOW w AS (PARTITION BY userid)
LIMIT 30;
