USE [Git]
GO
/****** Object:  StoredProcedure [dbo].[commitChanges]    Script Date: 21/04/2016 14:40:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================================================
-- Author:		<Rafael García Lara>
-- Create date: <2016-04-21>
-- Description:	<extracts data from the event, generates .sql files and commits changes>
-- ======================================================================================

ALTER PROCEDURE [dbo].[commitChanges] 
	@eventData xml
AS
BEGIN
	SET NOCOUNT ON;

	

END
