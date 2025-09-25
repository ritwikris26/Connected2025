SELECT *,DATEDIFF(SECOND,SDateTime,EDateTime)/60 AS Time
FROM Request WHERE Name = :Name