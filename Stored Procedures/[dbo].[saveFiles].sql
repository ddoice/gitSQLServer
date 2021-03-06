USE [Git]
GO
/****** Object:  StoredProcedure [dbo].[saveFiles]    Script Date: 21/04/2016 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================================================================================
-- Author     :	<Rafael García Lara>
-- Create date: <2016-04-21>
-- Description:	<saves files to local disk>
-- Code from  : <Phil Factor> @Phil_Factor https://www.simple-talk.com/sql/t-sql-programming/reading-and-writing-files-in-sql-server-using-t-sql/
-- =======================================================================================================================================

ALTER PROCEDURE [dbo].[saveFiles] 
	@content VARCHAR(MAX),
	@fileName VARCHAR(255),
	@path VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE  @objFileSystem int
			,@objTextStream int,
			@objErrorObject int,
			@strErrorMessage Varchar(1000),
			@Command varchar(1000),
			@hr int,
			@fileAndPath varchar(80)

	set nocount on

	select @strErrorMessage='opening the File System Object'
	EXECUTE @hr = sp_OACreate  'Scripting.FileSystemObject' , @objFileSystem OUT

	Select @FileAndPath=@path+'\'+@fileName
	if @HR=0 Select @objErrorObject=@objFileSystem , @strErrorMessage='Creating file "'+@FileAndPath+'"'
	if @HR=0 execute @hr = sp_OAMethod   @objFileSystem   , 'CreateTextFile'
		, @objTextStream OUT, @FileAndPath,2,True

	if @HR=0 Select @objErrorObject=@objTextStream, 
		@strErrorMessage='writing to the file "'+@FileAndPath+'"'
	if @HR=0 execute @hr = sp_OAMethod  @objTextStream, 'Write', Null, @content

	if @HR=0 Select @objErrorObject=@objTextStream, @strErrorMessage='closing the file "'+@FileAndPath+'"'
	if @HR=0 execute @hr = sp_OAMethod  @objTextStream, 'Close'

	if @hr<>0
		begin
		Declare 
			@Source varchar(255),
			@Description Varchar(255),
			@Helpfile Varchar(255),
			@HelpID int
	
		EXECUTE sp_OAGetErrorInfo  @objErrorObject, 
			@source output,@Description output,@Helpfile output,@HelpID output
		Select @strErrorMessage='Error whilst '
				+coalesce(@strErrorMessage,'doing something')
				+', '+coalesce(@Description,'')
		raiserror (@strErrorMessage,16,1)
		end
	EXECUTE  sp_OADestroy @objTextStream
	EXECUTE sp_OADestroy @objTextStream	

END
