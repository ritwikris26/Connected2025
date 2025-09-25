CREATE PROCEDURE Procedure1
	@:Name VARCHAR(20), @:Topic VARCHAR(20), @:SDateTime DATETIME, @:EDateTime DATETIME
AS
BEGIN
	DECLARE @RowStartDate DATETIME, @RowEndDate DATETIME, @name VARCHAR(20), @topic VARCHAR(20)
	DECLARE @IsValid BIT
	SET @IsValid = 1
	DECLARE db_cursor CURSOR FOR
	SELECT Name, SDateTime, EDateTime FROM Request
	OPEN db_cursor
	FETCH NEXT FROM db_cursor INTO @name, @RowStartDate, @RowEndDate

	WHILE @@Fetch_status = 0
	BEGIN
		IF (:SDateTime BETWEEN SDateTime AND EDateTime) OR (:EDateTime BETWEEN SDateTime AND EDateTime) OR (SDateTime BETWEEN :SDateTime AND :EDateTime) OR (EDateTime BETWEEN :SDateTime AND :EDateTime) AND (Name=:Name)
		BEGIN
			SET @IsValid = 0
			BREAK
		END
		FETCH NEXT FROM db_cursor INTO @name, @RowStartDate, @RowEndDate
	END
	CLOSE db_cursor
	DEALLOCATE db_cursor

	IF @IsValid = 1
	BEGIN
		INSERT INTO Request (Name, SDateTime, EDateTime, Topic) VALUES (@:Name, @:SDateTime, @:EDateTime, @:Topic)
	END
END