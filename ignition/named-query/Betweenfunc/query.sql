SELECT COUNT(*) AS C FROM Request 
WHERE (Name=:Name) AND 
(SDateTime BETWEEN :SDateTime AND :EDateTime)
OR (EDateTime BETWEEN :SDateTime AND :EDateTime)