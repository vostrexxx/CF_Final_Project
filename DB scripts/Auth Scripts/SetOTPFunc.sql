CREATE FUNCTION SetOTPCodeFunc
(
    @PhoneNumber VARCHAR(20),
    @OTPCode VARCHAR(10)
)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT;

    -- Проверка наличия пользователя с заданным номером телефона
    IF EXISTS (SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber)
    BEGIN
        -- Обновление OTP кода для указанного пользователя
        UPDATE Users
        SET OTPCode = @OTPCode
        WHERE PhoneNumber = @PhoneNumber;

        -- Успешное обновление
        SET @Result = 1;
    END
    ELSE
    BEGIN
        -- Пользователь не существует
        SET @Result = 0;
    END

    RETURN @Result;
END;
GO
