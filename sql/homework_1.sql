-- Database schema and tables
CREATE SCHEMA IF NOT EXISTS homework1;

DROP TABLE IF EXISTS homework1.films, homework1.persons, homework1.persons2content;

CREATE TABLE IF NOT EXISTS homework1.films (
    id INTEGER PRIMARY KEY,
    title TEXT,
    country TEXT,
    box_office NUMERIC CHECK (box_office >= 0),
    release_date DATE
);

CREATE TABLE IF NOT EXISTS homework1.persons (
    id INTEGER PRIMARY KEY,
    fio TEXT
);

CREATE TABLE IF NOT EXISTS homework1.persons2content (
    person_id INTEGER REFERENCES homework1.persons (id) NOT NULL,
    film_id INTEGER REFERENCES homework1.films (id) NOT NULL,
    person_type TEXT,
    UNIQUE (person_id, film_id)
);

-- Films
INSERT INTO 
    homework1.films(id, title, country, box_office, release_date)
VALUES
    (1, 'Железный человек', 'США, Канада', 585366247, '2008/04/14'::date),
    (2, 'Джон Уик 2', 'Гонконг, США', 171539877, '2017/01/30'::date),
    (3, 'Области тьмы', 'США', 161849455, '2011/03/08'::date),
    (4, 'Люди в черном 3', 'США', 624026776, '2012/05/14'::date),
    (5, 'Этот неловкий момент', 'США', 45640143, '2014/01/27'::date)
ON CONFLICT (id) DO NOTHING;

-- Persons
INSERT INTO
    homework1.persons(id, fio)
VALUES
    (1, 'Джон Фавро'),
    (2, 'Роберт Дауни Младший'),
    (3, 'Чад Стахелзки'),
    (4, 'Киану Ривз'),
    (5, 'Нил Бергер'),
    (6, 'Бредли Купер'),
    (7, 'Барри Зонненфельд'),
    (8, 'Уилл Смит'),
    (9, 'Том Гормикен'),
    (10, 'Зак Эфрон')
ON CONFLICT (id) DO NOTHING;

-- Persons 2 Content
INSERT INTO
    homework1.persons2content(person_id, film_id, person_type)
VALUES
    (1, 1, 'Режиссер'),
    (2, 1, 'Актер'),
    (3, 2, 'Режиссер'),
    (4, 2, 'Актер'),
    (5, 3, 'Режиссер'),
    (6, 3, 'Актер'),
    (7, 4, 'Режиссер'),
    (8, 4, 'Актер'),
    (9, 5, 'Режиссер'),
    (10, 5, 'Актер')
ON CONFLICT (person_id, film_id) DO NOTHING;
