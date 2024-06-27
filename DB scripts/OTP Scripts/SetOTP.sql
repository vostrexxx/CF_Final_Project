ALTER PROCEDURE SetOTPCode
    @PhoneNumber VARCHAR(20),
    @OTPCode VARCHAR(10)
AS
BEGIN
    -- Проверка наличия пользователя с заданным номером телефона
    IF NOT EXISTS (SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber)
    BEGIN
        -- Если пользователь не существует, выводим сообщение об ошибке
        PRINT 'User with phone number ' + @PhoneNumber + ' does not exist.';
        RETURN;
    END

    -- Обновление OTP кода для указанного пользователя
    UPDATE Users
    SET OTPCode = @OTPCode
    WHERE PhoneNumber = @PhoneNumber;

    -- Вывод успешного сообщения
    PRINT 'OTP code set successfully for user with phone number ' + @PhoneNumber + '.';
END;
