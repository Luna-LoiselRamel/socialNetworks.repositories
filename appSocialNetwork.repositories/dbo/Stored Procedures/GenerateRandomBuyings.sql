
-- =============================================
-- Author:      Luna
-- Create Date: 03/03/2023
-- Description: generate random buyings link in purchases
-- =============================================
CREATE PROCEDURE [dbo].[GenerateRandomBuyings]
AS
BEGIN
	
    DECLARE @num_links INT;
	DECLARE @counter INT = 0;
	DECLARE @done bit = 0;
	DECLARE @user_id INT;
	DECLARE @product_id INT;
	DECLARE @already_set_ids VARCHAR(255) = '';
 
	-- Déclare un curseur pour parcourir la table dans l'ordre
	DECLARE users_cursor CURSOR FOR SELECT idUser FROM users u where idUser not in (select idUser from purchases) ORDER BY idUser ASC;

	-- Ouvre le curseur et commence le parcours
	OPEN users_cursor;
	FETCH NEXT from users_cursor INTO @user_id;

	WHILE @@FETCH_STATUS =0
	BEGIN

		SET @num_links = FLOOR(RAND() * 6); -- Génère un nombre aléatoire entre 0 et 20
		set @counter = 0;
		set @already_set_ids = '';

  		WHILE @counter < @num_links 
		BEGIN
			-- Sélectionne deux identifiants de lignes au hasard dans chaque table
			SELECT TOP 1 @product_id = idProduct FROM products p ORDER BY  NEWID();
	
			-- Insère la liaison entre les deux identifiants sélectionnés
			IF CHARINDEX(CONVERT(VARCHAR(10), @product_id), @already_set_ids) =0
			BEGIN
	    		SET @already_set_ids = CONCAT(@already_set_ids, ',', @product_id);
				INSERT INTO purchases (idUser, idProduct) VALUES (@user_id, @product_id);
			END
	    
			SET @counter += 1;
  		END
		FETCH NEXT from users_cursor INTO @user_id;

	END

	-- Ferme le curseur
	CLOSE users_cursor;
	DEALLOCATE users_cursor;

END