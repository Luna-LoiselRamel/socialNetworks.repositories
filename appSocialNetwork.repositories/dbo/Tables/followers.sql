CREATE TABLE [dbo].[followers] (
    [idUser]     INT NOT NULL,
    [idFollower] INT NOT NULL,
    CONSTRAINT [PK_Users_Users] PRIMARY KEY CLUSTERED ([idUser] ASC, [idFollower] ASC),
    CONSTRAINT [FK_Followers_User] FOREIGN KEY ([idUser]) REFERENCES [dbo].[users] ([idUser]),
    CONSTRAINT [FK_Followers_User_2] FOREIGN KEY ([idFollower]) REFERENCES [dbo].[users] ([idUser])
);

