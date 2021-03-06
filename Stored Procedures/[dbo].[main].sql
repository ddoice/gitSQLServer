USE [Git]
GO
/****** Object:  StoredProcedure [dbo].[main]    Script Date: 21/04/2016 14:41:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rafael García Lara
-- Create date: 2016-04-21
-- Description:	main Git procedure
-- =============================================
ALTER PROCEDURE [dbo].[main] 
	@eventData xml 
AS
BEGIN

	SET NOCOUNT ON;

	-- If SQL Server 2005 change to one line for every variable
	DECLARE @eType NVARCHAR(200), @eTime NVARCHAR(200), @eServer NVARCHAR(200), @eLogin NVARCHAR(200), @eDatabase NVARCHAR(200), @eSchema NVARCHAR(200), @eObjectName NVARCHAR(200), @eTargetObjectName NVARCHAR(200), @eTargetObjectType NVARCHAR(200), @eNewObjectName NVARCHAR(200), @eCommandText NVARCHAR(MAX)

	-- SELECT ORIGINAL_LOGIN() << AVOID EXECUTING CONTEXT HACKS

	SELECT
		@eType = @eventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(200)'),
		@eTime = @eventData.value('(/EVENT_INSTANCE/PostTime)[1]',   'NVARCHAR(200)'),
		@eServer = @eventData.value('(/EVENT_INSTANCE/ServerName)[1]',   'NVARCHAR(200)'),
		@eLogin = @eventData.value('(/EVENT_INSTANCE/LoginName)[1]',   'NVARCHAR(200)'),
		@eDatabase = @eventData.value('(/EVENT_INSTANCE/DatabaseName)[1]',   'NVARCHAR(200)'),
		@eSchema = @eventData.value('(/EVENT_INSTANCE/SchemaName)[1]',   'NVARCHAR(200)'),
		@eObjectName = @eventData.value('(/EVENT_INSTANCE/ObjectName)[1]',   'NVARCHAR(200)'),
		@eTargetObjectName = @eventData.value('(/EVENT_INSTANCE/TargetObjectName)[1]',   'NVARCHAR(200)'),
		@eTargetObjectType = @eventData.value('(/EVENT_INSTANCE/TargetObjectType)[1]',   'NVARCHAR(200)'),
		@eNewObjectName = @eventData.value('(/EVENT_INSTANCE/NewObjectName)[1]',   'NVARCHAR(200)'),
		@eCommandText = @eventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]',   'NVARCHAR(MAX)')

END
