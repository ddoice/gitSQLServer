-- GRANT TO AVOID ERROR ON SAVING FILES

-- SELECT suser_name() <<WHOAMI

USE MASTER
GO

--GRANT EXECUTE ON [sys].[sp_OACreate] TO [casa-PC\casa]
--GRANT EXECUTE ON [sys].[sp_OAMethod] TO [casa-PC\casa]
grant exec on sp_OACreate to [casa-PC\casa]
grant exec on sp_OAGetErrorInfo to [casa-PC\casa]
grant exec on sp_OAMethod to [casa-PC\casa]
grant exec on sp_OAGetProperty to [casa-PC\casa]
grant exec on sp_OADestroy to [casa-PC\casa]