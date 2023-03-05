CREATE TABLE [dbo].[purchases] (
    [idUser]    INT NOT NULL,
    [idProduct] INT NOT NULL,
    CONSTRAINT [PK_Users_Products] PRIMARY KEY CLUSTERED ([idUser] ASC, [idProduct] ASC),
    CONSTRAINT [FK_Purchases_Products] FOREIGN KEY ([idProduct]) REFERENCES [dbo].[products] ([idProduct]),
    CONSTRAINT [FK_Purchases_Users] FOREIGN KEY ([idUser]) REFERENCES [dbo].[users] ([idUser])
);

