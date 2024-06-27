USE CF_BookStore_VNE;

Select * from Users;
Select * from Authors;
Select * from Genres;
Select * from Books;
Select * from Favorites;
Select * from CartBooks;
Select * from Cart;

DBCC CHECKIDENT ('CartBooks', RESEED, 0);
DBCC CHECKIDENT ('Cart', RESEED, 0);
DBCC CHECKIDENT ('Favorites', RESEED, 0);
DBCC CHECKIDENT ('Books', RESEED, 0);
DBCC CHECKIDENT ('Genres', RESEED, 0);
DBCC CHECKIDENT ('Authors', RESEED, 0);
DBCC CHECKIDENT ('Users', RESEED, 0);

DELETE FROM CartBooks;
DELETE FROM Cart;
DELETE FROM Favorites;
DELETE FROM Books;
DELETE FROM Genres;
DELETE FROM Authors;
DELETE FROM Users;

