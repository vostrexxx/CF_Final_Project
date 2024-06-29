-- Предполагается, что таблица пользователей называется 'Users'
-- и что есть столбец 'PhoneNumber' для хранения номеров телефонов.

CREATE PROCEDURE UpdateUserPhoneNumber
    @UserID INT,
    @NewPhoneNumber VARCHAR(20)
AS
BEGIN
    -- Обновление номера телефона для пользователя с определенным UserID
    UPDATE Users
    SET PhoneNumber = @NewPhoneNumber
    WHERE UserID = @UserID;

    -- Выборка обновленной информации для проверки
    SELECT *
    FROM Users
    WHERE UserID = @UserID;
END;
GO

-- Вызов процедуры с конкретными параметрами
EXEC UpdateUserPhoneNumber 5, '1234567899';