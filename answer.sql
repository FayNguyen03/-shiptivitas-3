-- TYPE YOUR SQL QUERY BELOW

-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change

SELECT pre_post_launch, AVG(daily_users)
FROM (
    (SELECT COUNT(*) AS daily_users, login_history_date, CASE WHEN login_history_date >= '2018-06-02' THEN "After" ELSE "Before" END AS pre_post_launch
    FROM (
        SELECT user_id, DATE(login_timestamp, 'unixepoch') AS login_history_date
        FROM login_history
        GROUP BY user_id, login_history_date
    )
    GROUP BY login_history_date)
    )
GROUP BY pre_post_launch;


-- PART 2: Create a SQL query that indicates the number of status changes by card

SELECT number_of_status_changes, COUNT(*)
FROM(
    SELECT cardId, COUNT(*) AS number_of_status_changes
    FROM card_change_history
    GROUP BY cardId)
GROUP BY number_of_status_changes;

-- COALESCE: returns the very first non-NULL value it encounters
SELECT 
    COALESCE(oldStatus, 'NEW') as from_status,
    newStatus as to_status,
    COUNT(*) as transition_count
FROM card_change_history
GROUP BY oldStatus, newStatus
ORDER BY transition_count DESC;

