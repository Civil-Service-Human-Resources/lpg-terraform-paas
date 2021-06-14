SELECT COUNT(*)
FROM identity.token
WHERE status = 0
GROUP BY authentication_id
HAVING COUNT(*) > 1;