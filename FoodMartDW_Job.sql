USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'FoodMartDW', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Job para executar ETL as 8:AM durante os dias uteis', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'WIN-48AUAGSDP02\ssd', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'FoodMartDW', @server_name = N'WIN-48AUAGSDP02'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'FoodMartDW', @step_name=N'Execute ETL', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/ISSERVER "\"\SSISDB\FoodMart_SSIS\FoodMart_SSIS\FoodMart_Inicial.dtsx\"" /SERVER "\"WIN-48AUAGSDP02\"" /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E', 
		@database_name=N'master', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'FoodMartDW', @step_name=N'Incrementar', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/ISSERVER "\"\SSISDB\FoodMart_SSIS\FoodMart_SSIS\FoodMart_Incremental.dtsx\"" /SERVER "\"WIN-48AUAGSDP02\"" /Par "\"ChangeDateTime(DateTime)\"";"\"05-05-2013 00:00:00\"" /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E', 
		@database_name=N'master', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'FoodMartDW', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Job para executar ETL as 8:AM durante os dias uteis', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'WIN-48AUAGSDP02\ssd', 
		@notify_email_operator_name=N'', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'FoodMartDW', @name=N'ExecuteJob', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=62, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20160524, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO
