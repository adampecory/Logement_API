/*USER*/

--Ajout d'un USer
CREATE PROCEDURE spUserAdd @Login NVARCHAR(50), 
				@Password NVARCHAR(200), 
				@Email NVARCHAR(50)=NULL, 
				@Tel NVARCHAR(50)=NULL, 
				@AgencyId int=NULL
AS
BEGIN
	DECLARE @salt UNIQUEIDENTIFIER=NEWID()
	INSERT INTO "USER"(LOGIN, PASSWORD, SALT, EMAIL, TEL, AGENCY_ID, CREATED_DATE) 
	  VALUES (@Login,
			  HASHBYTES('SHA2_512', @Password+CAST(@salt AS NVARCHAR(36))), 			  
			  @salt,
			  @Email,
			  @Tel, 
			  @AgencyId, 
			  GetDate())
END
GO

--Mise à jour d'un User
CREATE PROCEDURE spUserUpdate @Id int, @Login NVARCHAR(50), @Email NVARCHAR(50)=NULL, @Tel NVARCHAR(50)=NULL
AS
UPDATE "USER" set LOGIN=@Login, EMAIL=@Email, TEL=@Tel, MODIFIED_DATE=GetDate() where ID=@Id
GO

--Liste de tous les Users
CREATE PROCEDURE spUserGet
AS
Select * from "USER"
GO

--Recherche un User à partir de son Login
CREATE PROCEDURE spUserGetbyLogin @Login NVARCHAR(50)
AS
SELECT * from "USER" where LOGIN=@Login
GO

--Recherche un User à partir de son Id
CREATE PROCEDURE spUserGetbyId @Id NVARCHAR(50)
AS
SELECT * from "USER" where ID=@Id
GO

--Vérifie le Login et Mot de passe
CREATE PROCEDURE spUserValidate @Login NVARCHAR(50), @Password NVARCHAR(50)
AS
Select * from "USER" where LOGIN=@Login and PASSWORD=HASHBYTES('SHA2_512', @Password+CAST(Salt AS NVARCHAR(36)))
GO

--Supprime un User
CREATE PROCEDURE spUserDelete @Id int
AS
Delete from USERROLE where ID_USER=@Id
Delete from "USER" where ID=@Id
GO

--Mise à jour du mot de passe
CREATE PROCEDURE spUserUpdatePassword @Login NVARCHAR(50), @Password NVARCHAR(200)
AS
BEGIN
	UPDATE dbo.[USER] set PASSWORD=HASHBYTES('SHA2_512', @Password+CAST(Salt AS NVARCHAR(36))) 
	WHERE LOGIN=@Login
END
GO

--Liste des roles d'un utilisateur
CREATE PROCEDURE spUserGetUserRoles @UserId Int
AS
	Select * from 
	"ROLE" b,
	USERROLE c
	where b.ID=c.ID_ROLE
	and c.ID_USER=@UserId	
GO

--Liste des users ayant un role donné
CREATE PROCEDURE spUserGetRoleUsers @RoleId Int
AS
	Select * from 
	"USER" a, 
	USERROLE c
	where a.ID=c.ID_USER
	and c.ID_ROLE=@RoleId
GO

--Ajout d'un role à un user
CREATE PROCEDURE spUserAddUsertoRole @UserId int, @RoleId Int
AS
	INSERT INTO USERROLE VALUES(@UserId,@RoleId)
	Select * from 
	"USER" a, 
	"ROLE" b,
	USERROLE c
	where a.ID=c.ID_USER
	and b.ID=c.ID_ROLE
	and a.id=@UserId
GO

--Retire un role à un User
CREATE PROCEDURE spUserRemoveUsertoRole @UserId int, @RoleId Int
AS
  Delete FROM USERROLE where ID_USER=@UserId and ID_ROLE=@RoleId
  Select * from 
	"USER" a, 
	"ROLE" b,
	USERROLE c
	where a.ID=c.ID_USER
	and b.ID=c.ID_ROLE
	and a.id=@UserId
GO