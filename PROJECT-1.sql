-- 1. Create new schema as ecommerce
CREATE DATABASE ecommerce;

-- 2.Import .csv file users_data into MySQL 
USE ecommerce;

-- 3.Run SQL command to see the structure of table

DESC users_data;

-- 4.Run SQL command to select first 100 rows of the database

SELECT * FROM users_data LIMIT 100;

-- 5.How many distinct values exist in table for field country and language

SELECT 'Sum of distinct country names in the table', COUNT(DISTINCT country) FROM users_data UNION
SELECT 'Sum of distinct languages in the table', COUNT(DISTINCT language) FROM users_data;

-- 6.Check whether male users are having maximum followers or female users.

SELECT SUM(socialNbFollowers), gender FROM users_data
GROUP BY gender
ORDER BY SUM(socialNbFollowers) DESC LIMIT 1;

-- 7.Calculate the total users those
-- a. Uses Profile Picture in their Profile
-- b. Uses Application for Ecommerce platform
-- c. Uses Android app
-- d. Uses ios app

SELECT 'TOTAL_USER_hasProfilePicture', COUNT(hasProfilePicture) FROM users_data WHERE hasProfilePicture = 'True' UNION
SELECT 'TOTAL_USER_hasAnyApp', COUNT(hasAnyApp) FROM users_data WHERE hasAnyApp = 'True' UNION
SELECT 'TOTAL_USER_hasAndroidApp', COUNT(hasAndroidApp) FROM users_data WHERE hasAndroidApp = 'True' UNION
SELECT 'TOTAL_USER_hasIosApp', COUNT(hasIosApp)  FROM users_data WHERE hasIosApp = 'True';

-- 8.Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers

SELECT COUNT(productsBought), country FROM users_data
GROUP BY country
ORDER BY COUNT(productsBought) DESC;

-- 9.Calculate the average number of sellers for each country and sort the result in ascending order of total number of sellers.

SELECT (AVG(productsSold + productsListed)) AVG_NO_OF_SELLERS, country FROM users_data
WHERE (productsSold >= 0) OR (productsListed >= 0)
GROUP BY country
ORDER BY AVG(productsSold)+ AVG(productsListed);

-- 10.Display name of top 10 countries having maximum products pass rate.

SELECT SUM(productsPassRate), country
FROM users_data
GROUP BY country
ORDER BY SUM(productsPassRate) DESC LIMIT 10;

-- 11.Calculate the number of users on an ecommerce platform for different language choices.

SELECT COUNT(hasAnyApp), language FROM users_data
WHERE hasAnyApp = 'True'
GROUP BY language;

-- 12.Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform.

SELECT SUM(socialProductsLiked) Sum_socialProductsLiked_Female_users, SUM(productsWished) Sum_productsWished_Female_users
FROM users_data
WHERE gender = 'F';

-- 13.Check the choice of male users about being seller or buyer.

SELECT SUM(productsListed) Sum_Male_sellers, SUM(productsBought) Sum_Male_buyers
FROM users_data
WHERE gender = 'M';

-- 14.Which country is having maximum number of buyers?

SELECT country, SUM(productsBought) FROM users_data
GROUP BY country
ORDER BY SUM(productsBought) DESC LIMIT 1;

-- 15.List the name of 10 countries having zero number of sellers

SELECT country, SUM(productsBought) FROM users_data
GROUP BY country
ORDER BY SUM(productsBought)
LIMIT 10;

-- 16.Display record of top 110 users who have used ecommerce platform recently.

SELECT * FROM users_data
ORDER BY daysSinceLastLogin
LIMIT 110;

-- 17.Calculate the number of female users those who have not logged in since last 100 days.

SELECT COUNT(gender) FROM users_data
WHERE (daysSinceLastLogin >= 100) AND (gender = 'F');

-- 18.Display the number of female users of each country at ecommerce platform.

SELECT * FROM users_data;

SELECT COUNT(gender) no_female_users, country FROM users_data
WHERE (gender = 'F') AND (hasAnyApp = 'True')
GROUP BY country
ORDER BY COUNT(gender) DESC;

-- 19.Display the number of male users of each country at ecommerce platform.

SELECT COUNT(gender) no_female_users, country, gender FROM users_data
WHERE (gender = 'M') AND (hasAnyApp = 'True')
GROUP BY country
ORDER BY COUNT(gender) DESC;

-- 20.Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

SELECT AVG(productsSold), AVG(productsBought), country, gender FROM users_data
WHERE (gender = 'M') AND (hasAnyApp = 'True')
GROUP BY country;




