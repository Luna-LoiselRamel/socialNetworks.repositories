
-- =============================================
-- Author:      Luna
-- Create Date: 01/03/2023
-- Description: insertion produits
-- =============================================
CREATE PROCEDURE [dbo].[MassiveProductsInsertion]
(
	@nbOfRows	int
)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @compteur INT = 0;
        while (@compteur <= @nbOfRows)
		BEGIN 
                insert into products (idProduct, labelProduct) values (ABS(CHECKSUM(NEWID())), @compteur);
                SET @compteur += 1;
        END 
END