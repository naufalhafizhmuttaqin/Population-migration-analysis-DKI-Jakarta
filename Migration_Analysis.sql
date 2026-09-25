/*==========================================================
Project  : Jakarta Migration Analysis
Author   : Naufal Hafizh Muttaqin
Database : MySQL

Description:
Business Case Analysis of Population Migration to DKI Jakarta
==========================================================*/

-- ==========================================================
-- CREATE DATABASE
-- ==========================================================

CREATE DATABASE IF NOT EXISTS jakarta_migration_analysis;

USE jakarta_migration_analysis;

-- ==========================================================
-- CREATE TABLE
-- ==========================================================

CREATE TABLE IF NOT EXISTS jakarta_migration (
    year INT,
    destination_city VARCHAR(100),
    destination_district VARCHAR(100),
    destination_village VARCHAR(100),
    origin_province VARCHAR(100),
    origin_city VARCHAR(100),
    total_migrants INT
);

-- ==========================================================
-- DATA PREVIEW
-- ==========================================================

SELECT *
FROM jakarta_migration
LIMIT 10;

-- ==========================================================
-- BUSINESS QUESTION 1
-- Total Number of Migrants
-- ==========================================================

SELECT
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration;

-- ==========================================================
-- BUSINESS QUESTION 2
-- Project Overview KPI
-- ==========================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT origin_province) AS total_origin_provinces,
    COUNT(DISTINCT origin_city) AS total_origin_cities,
    COUNT(DISTINCT destination_city) AS total_destination_cities,
    COUNT(DISTINCT destination_district) AS total_destination_districts,
    COUNT(DISTINCT destination_village) AS total_destination_villages,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration;

-- ==========================================================
-- BUSINESS QUESTION 3
-- Top 10 Origin Provinces
-- ==========================================================

SELECT
    origin_province,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY origin_province
ORDER BY total_migrants DESC
LIMIT 10;

-- ==========================================================
-- BUSINESS QUESTION 4
-- Bottom 10 Origin Provinces
-- ==========================================================

SELECT
    origin_province,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY origin_province
ORDER BY total_migrants ASC
LIMIT 10;

-- ==========================================================
-- BUSINESS QUESTION 5
-- Contribution Percentage by Province
-- ==========================================================

SELECT
    origin_province,
    SUM(total_migrants) AS total_migrants,
    ROUND(
        SUM(total_migrants) * 100 /
        (SELECT SUM(total_migrants)
         FROM jakarta_migration),
        2
    ) AS contribution_percentage
FROM jakarta_migration
GROUP BY origin_province
ORDER BY total_migrants DESC;

-- ==========================================================
-- BUSINESS QUESTION 6
-- Top 15 Origin Cities / Regencies
-- ==========================================================

SELECT
    origin_city,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY origin_city
ORDER BY total_migrants DESC
LIMIT 15;

-- ==========================================================
-- BUSINESS QUESTION 7
-- Destination City Ranking
-- ==========================================================

SELECT
    destination_city,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY destination_city
ORDER BY total_migrants DESC;

-- ==========================================================
-- BUSINESS QUESTION 8
-- Top Destination Districts
-- ==========================================================

SELECT
    destination_district,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY destination_district
ORDER BY total_migrants DESC
LIMIT 15;

-- ==========================================================
-- BUSINESS QUESTION 9
-- Top Destination Villages
-- ==========================================================

SELECT
    destination_village,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY destination_village
ORDER BY total_migrants DESC
LIMIT 15;

-- ==========================================================
-- BUSINESS QUESTION 10
-- Top Migration Routes
-- ==========================================================

SELECT
    origin_city,
    destination_city,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY
    origin_city,
    destination_city
ORDER BY total_migrants DESC
LIMIT 10;

-- ==========================================================
-- BUSINESS QUESTION 11
-- Province Diversity by Destination City
-- ==========================================================

SELECT
    destination_city,
    COUNT(DISTINCT origin_province) AS unique_origin_provinces
FROM jakarta_migration
GROUP BY destination_city
ORDER BY unique_origin_provinces DESC;

-- ==========================================================
-- BUSINESS QUESTION 12
-- Province Diversity by District
-- ==========================================================

SELECT
    destination_district,
    COUNT(DISTINCT origin_province) AS unique_origin_provinces
FROM jakarta_migration
GROUP BY destination_district
ORDER BY unique_origin_provinces DESC;

-- ==========================================================
-- BUSINESS QUESTION 13
-- Top Province for Each Destination City
-- (Window Function)
-- ==========================================================

WITH ranked_province AS
(
    SELECT
        destination_city,
        origin_province,
        SUM(total_migrants) AS total_migrants,
        RANK() OVER
        (
            PARTITION BY destination_city
            ORDER BY SUM(total_migrants) DESC
        ) AS ranking
    FROM jakarta_migration
    GROUP BY
        destination_city,
        origin_province
)

SELECT *
FROM ranked_province
WHERE ranking = 1;

-- ==========================================================
-- BUSINESS QUESTION 14
-- Top 5 Destination Districts in Each Destination City
-- ==========================================================

WITH ranked_district AS
(
    SELECT
        destination_city,
        destination_district,
        SUM(total_migrants) AS total_migrants,
        ROW_NUMBER() OVER
        (
            PARTITION BY destination_city
            ORDER BY SUM(total_migrants) DESC
        ) AS row_num
    FROM jakarta_migration
    GROUP BY
        destination_city,
        destination_district
)

SELECT *
FROM ranked_district
WHERE row_num <= 5;

-- ==========================================================
-- BUSINESS QUESTION 15
-- Migration Trend by Year
-- ==========================================================

SELECT
    year,
    SUM(total_migrants) AS total_migrants
FROM jakarta_migration
GROUP BY year
ORDER BY year;

-- ==========================================================
-- BUSINESS QUESTION 16
-- Average Migrants per Origin Province
-- ==========================================================

SELECT
    origin_province,
    ROUND(AVG(total_migrants),2) AS average_migrants
FROM jakarta_migration
GROUP BY origin_province
ORDER BY average_migrants DESC;

-- ==========================================================
-- BUSINESS QUESTION 17
-- Average Migrants per Destination City
-- ==========================================================

SELECT
    destination_city,
    ROUND(AVG(total_migrants),2) AS average_migrants
FROM jakarta_migration
GROUP BY destination_city
ORDER BY average_migrants DESC;

-- ==========================================================
-- BUSINESS QUESTION 18
-- Top Origin Province for Each District
-- ==========================================================

WITH ranked_origin AS
(
    SELECT
        destination_district,
        origin_province,
        SUM(total_migrants) AS total_migrants,
        ROW_NUMBER() OVER
        (
            PARTITION BY destination_district
            ORDER BY SUM(total_migrants) DESC
        ) AS rn
    FROM jakarta_migration
    GROUP BY
        destination_district,
        origin_province
)

SELECT *
FROM ranked_origin
WHERE rn = 1;

-- ==========================================================
-- END OF PROJECT
-- ==========================================================