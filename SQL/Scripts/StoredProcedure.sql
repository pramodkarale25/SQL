create procedure Proc1
@par1 int,
@par2 int=0,--Default Value
@par3 varchar(10)
as
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			select * from Customers
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION

		DECLARE  @ErrorMessage  NVARCHAR(4000), @ErrorSeverity INT,  @ErrorState    INT;    
		
		SELECT     
		@ErrorMessage  = ERROR_MESSAGE(),    
		@ErrorSeverity = ERROR_SEVERITY(),   
		@ErrorState    = ERROR_STATE();   
	   
	   SET @ErrorMessage=@ErrorMessage   

		RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
	END CATCH
END