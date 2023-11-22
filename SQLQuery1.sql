CREATE DATABASE AliNinoDB
USE AliNinoDB

CREATE TABLE Categories(
	ID int identity PRIMARY KEY,
	Title nvarchar(255),
	ParentCategory int references Categories(ID),
	IsDeleted bit
);

CREATE TABLE Books(
	ID int identity PRIMARY KEY,
	Title nvarchar(255),
	Description nvarchar(255),
	ActualPrice int,
	DiscountPrice int,
	PublishingHouseID int references PublishingHouses(ID),
	StockCount int,
	ArticleCode int,
	BindingID int references Bindings(ID),
	Pages int,
	CategoryID int references Categories(ID),
	IsDeleted bit
);

CREATE TABLE Authors(
	ID int identity PRIMARY KEY,
	Name nvarchar(255),
	Surname nvarchar(255),
	IsDeleted bit
);

CREATE TABLE BooksAuthors(
	ID int identity PRIMARY KEY,
	BookID int references Books(ID),
	AuthorID int references Authors(ID)
);

CREATE TABLE PublishingHouses(
	ID int identity PRIMARY KEY,
	Title nvarchar(255),
	IsDeleted bit
);

CREATE TABLE BooksGenres(
	ID int identity PRIMARY KEY,
	BookID int references Books(ID),
	GenreID int references Genres(ID)
);

CREATE TABLE Genres(
	ID int identity PRIMARY KEY,
	Title nvarchar(255),
	IsDeleted bit
);
CREATE TABLE Bindings(
	ID int identity PRIMARY KEY,
	Title nvarchar(255),
	IsDeleted bit
);
CREATE TABLE Languages(
	ID int identity PRIMARY KEY,
	Title nvarchar(255),
	IsDeleted bit
);

CREATE TABLE BooksLanguages(
	ID int identity PRIMARY KEY,
	BookID int references Books(ID),
	LanguageID int references Languages(ID)
);

CREATE TABLE Comments(
	ID int identity PRIMARY KEY,
	Description nvarchar(255),
	BookID int references Books(ID),
	Rating int,
	Check( Rating >= 0 AND Rating <= 5 ),
	Name nvarchar(50) NOT NULL,
	Email nvarchar(50) NOT NULL,
	ImageUrl nvarchar(255),
	IsDeleted bit
);

------------------------------------------------------------------
--------TASK 1-----------
------------------------------------------------------------------
CREATE PROCEDURE usp_CreateProduct

(@CTitle nvarchar(255), @CParentCategory int, @CIsDeleted bit,

@AName nvarchar(255), @ASurname nvarchar(255), @AIsDeleted bit,

@PHTitle nvarchar(255),
@PHIsDeleted bit,

@GTitle nvarchar(255),
@GIsDeleted bit,

@BDTitle nvarchar(255),
@BDIsDeleted bit,

@LGTitle nvarchar(255),
@LGIsDeleted bit,

@BTitle nvarchar(150),
@BDescription nvarchar(250),
@BActualPrice int,
@BDiscountPrice int,
@BPublishingHouseId int,
@BStockCount int,
@BArticleCode int,
@BBindingId int,
@BPages int,
@BCategoryId int,
@BIsDeleted bit,

@CMDescription nvarchar(255),
@CMBookID int,
@CMRating int,
@CMName nvarchar(50),
@CMEmail nvarchar(50),
@CMImageUrl nvarchar(255),
@CMIsDeleted bit,

@BABookID int,
@BAAuthorID int,

@BGBookID int,
@BGGenreID int,

@BLBookID int,
@BLLanguageID int)

AS
BEGIN
	INSERT INTO Categories VALUES (@CTitle, @CParentCategory, @CIsDeleted)
	INSERT INTO Authors VALUES (@AName, @ASurname, @AIsDeleted)
	INSERT INTO PublishingHouses VALUES (@PHTitle, @PHIsDeleted)
	INSERT INTO Genres VALUES (@GTitle, @GIsDeleted)
	INSERT INTO Bindings VALUES (@BDTitle, @BDIsDeleted)
	INSERT INTO Languages VALUES (@LGTitle, @LGIsDeleted)
	INSERT INTO Books VALUES (@BTitle, @BDescription, @BActualPrice, @BDiscountPrice, @BPublishingHouseID, 
	@BStockCount, @BArticleCode, @BBindingID, @BPages, @BCategoryID, @BIsDeleted)
	INSERT INTO Comments VALUES (@CMDescription, @CMBookID, @CMRating, @CMName, @CMEmail, @CMImageUrl, @CMIsDeleted)
	INSERT INTO BooksAuthors VALUES (@BABookID, @BAAuthorID)
	INSERT INTO BooksGenres VALUES (@BGBookID, @BGGenreID)
	INSERT INTO BooksLanguages VALUES (@BLBookID, @BLLanguageID)
END

usp_CreateProduct 
N'Books', NULL, 0,
N'Rashad', N'Salimov', 0,
N'BakiNesr', 0,
N'Dram',0,
N'Yumşaq',0,
N'İngilis',0,
N'boktitl',N'Bookdesc',13,10,2,5,56464684,2,145,3,0,
N'adsdsadda',3,4,N'rashad',N'rashad@mail.ru','url.image.png',0,
3,2,
3,1,
3,1

SELECT * FROM Categories
SELECT * FROM Authors
SELECT * FROM PublishingHouses
SELECT * FROM Genres
SELECT * FROM Bindings
SELECT * FROM Books
SELECT * FROM Languages
SELECT * FROM Comments
SELECT * FROM BooksAuthors
SELECT * FROM BooksGenres
SELECT * FROM BooksLanguages

DELETE FROM Books WHERE ID = 6;

-------------------------------------------------
--TASK2--
-------------------------------------------------
--CREATE TRIGGER ChangeIsDeletedBooks
--ON Books
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE Books
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END


--CREATE TRIGGER ChangeIsDeletedCategories
--ON Categories
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE Categories
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END

--CREATE TRIGGER ChangeIsDeletedAuthors
--ON Authors
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE Authors
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END

--CREATE TRIGGER ChangeIsDeletedPublishingHouses
--ON PublishingHouses
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE PublishingHouses
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END

--CREATE TRIGGER ChangeIsDeletedGenres
--ON Genres
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE Genres
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END

--CREATE TRIGGER ChangeIsDeletedBindings
--ON Bindings
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE Bindings
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END

--CREATE TRIGGER ChangeIsDeletedLanguages
--ON Languages
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE Languages
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END

--CREATE TRIGGER ChangeIsDeletedComments
--ON Comments
--INSTEAD OF DELETE
--AS
--BEGIN
--    UPDATE Comments
--    SET IsDeleted = 1
--    WHERE Id IN (SELECT Id FROM deleted)
--END