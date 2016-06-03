

/*USER*/
CREATE PROCEDURE spUserAdd @Login NVARCHAR(50), @Password NVARCHAR(50), @Email NVARCHAR(50)=NULL, @Tel NVARCHAR(50)=NULL, @AgencyId int=NULL
AS
INSERT INTO "USER"(LOGIN, PASSWORD, EMAIL, TEL, AGENCY_ID) VALUES (@Login,@Password,@Email,@Tel, @AgencyId)
GO

CREATE PROCEDURE spUserUpdate @Id int, @Login NVARCHAR(50), @Password NVARCHAR(50), @Email NVARCHAR(50)=NULL, @Tel NVARCHAR(50)=NULL
AS
UPDATE "USER" set LOGIN=@Login, EMAIL=@Email, TEL=@Tel, PASSWORD=@Password, MODIFY_DATE=GetDate() where ID=@Id
GO

CREATE PROCEDURE spUserGet
AS
Select * from "USER"
GO

CREATE PROCEDURE spUserGetbyLogin @Login NVARCHAR(50)
AS
SELECT * from "USER" where LOGIN=@Login
GO

CREATE PROCEDURE spUserGetbyId @Id NVARCHAR(50)
AS
SELECT * from "USER" where ID=@Id
GO

CREATE PROCEDURE spUserValidate @Login NVARCHAR(50), @Password NVARCHAR(50)
AS
Select * from PRO_USER where LOGIN=@Login and PASSWORD=@Password
GO

CREATE PROCEDURE spUserDelete @Id int
AS
Delete from USERROLE where ID_USER=@Id
Delete from "USER" where ID=@Id
GO

/*UserROLE*/
CREATE PROCEDURE spURAddUserToRole @ID_USER int, @ID_ROLE int
AS
INSERT INTO USERROLE(ID_USER, ID_ROLE) VALUES (@ID_USER, @ID_ROLE)
GO

CREATE PROCEDURE spURGetRolesbyUser @Login NVARCHAR(50)
AS
Select * from ROLE where ID in (SELECT ID_ROLE FROM USERROLE where ID_USER in (SELECT ID FROM "USER" where LOGIN=@Login))
GO

CREATE PROCEDURE spURGetRolesbyUserId @UserId NVARCHAR(50)
AS
Select * from ROLE where ID in (SELECT ID_ROLE FROM USERROLE where ID_USER = @UserId)
GO

CREATE PROCEDURE spURGetUsersbyRole @RoleName NVARCHAR(50)
AS
Select * from "USER" where ID in (SELECT ID_USER FROM USERROLE where ID_ROLE in (SELECT ID FROM ROLE where NAME=@RoleName))
GO

CREATE PROCEDURE spURGetUsersbyRoleId @RoleId int
AS
Select * from "USER" where ID in (SELECT ID_USER FROM USERROLE where ID_ROLE = @RoleId)
GO

/* TEST */
/*
Exec dbo.spRoleGetbyId 2
Exec dbo.spRoleDelete 1
Exec dbo.spRoleAdd ADMINISTRATEUR

Exec dbo.spUserGet
Exec dbo.spUserAdd pkaco, azerty, 'a@b.com'
Exec dbo.spUserAdd erdo, qwerty, 'b@c.com'
*/