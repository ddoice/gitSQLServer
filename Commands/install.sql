
--- NOT WORKING!!!
--- UNDER DEVELOPMENT

-->> CONFIG SECTION

DECLARE @GIT_PATH_AND_BIN VARCHAR(255) = 'git.exe' -- EX: 'C:\git\git.exe'
DECLARE @GIT_LOGIN VARCHAR(255) = 'gitUser'
DECLARE @GIT_PASS VARCHAR(255) = 'useAStrongOnePlease'

-->> END CONFIG

DECLARE @SQLC VARCHAR(4000);

-- CREATE DATABASE GIT
IF (SELECT COUNT(name) FROM sys.databases WHERE name = 'git') > 0 BEGIN
	SELECT 'HOLD ON! git DB is already on the server, run <DROP TABLE git> before running the script!' AS ERROR
	--RETURN
END
ELSE BEGIN
	CREATE DATABASE [Git]
END


-- CREATE USER GIT
IF (SELECT COUNT(*) FROM  sys.database_principals WHERE type_desc = 'SQL_USER' AND name = @GIT_LOGIN) = 0 BEGIN --<< CHECK IF USER IS EXIST

	BEGIN TRY
		SET @SQLC = '
						create login '+@GIT_LOGIN+' with password = '''+@GIT_PASS+''', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF;
						use git;
						EXEC sp_addrolemember N''db_owner'', N'''+@GIT_LOGIN+''';
						create user gitUser for login '+@GIT_LOGIN+';
						use master;
						create user gitUser for login '+@GIT_LOGIN+';
						grant execute on xp_cmdshell to '+@GIT_LOGIN+';
					'
		SELECT(@SQLC)
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
		IF ERROR_NUMBER() = 15151 BEGIN
			SELECT 'Looks like xp_cmdshell its not enabled, run <Enable - AO and xp_cmdshell.sql> in Commands folder' AS SOLUTION
		END
	END CATCH

END
ELSE BEGIN
	SELECT 'Login ' + @GIT_LOGIN + ' already exists, skipping.'
END



-- DEBUG!!

 CHECK GIT PATH
EXECUTE AS user = 'gitUser' 
GO
EXEC xp_cmdshell 'dir *.exe';
REVERT
 SELECT * FROm  sys.database_principals

 EXEC sp_xp_cmdshell_proxy_account null


 EXECUTE AS LOGIN = 'gitUser' ;
GO
xp_cmdshell 'whoami.exe' ;
REVERT ; 