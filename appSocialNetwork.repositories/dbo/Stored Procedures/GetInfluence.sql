
-- =============================================
-- Author:      Luna
-- Create Date: 01/03/2023
-- Description: requête 1
-- =============================================
CREATE PROCEDURE [dbo].[GetInfluence]
(
	@idInfluencer	int, 
	@profondeur	int
)
AS
BEGIN
    SET NOCOUNT ON;
	
	WITH FollowerCTE AS
	(
		-- On démarre avec le user de base
		SELECT F1.*, 1 AS Niveau
		FROM Followers F1
		WHERE F1.idUser = @idInfluencer

		UNION ALL

		SELECT F2.*, Niveau+1
		FROM Followers F2
		INNER JOIN FollowerCTE follows ON follows.idFollower = F2.idUser
		WHERE Niveau < @profondeur
	)

	SELECT DISTINCT P.*, COUNT(P.IdProduct) as 'count'
    FROM Products P
    JOIN Purchases Pr on Pr.IdProduct = P.IdProduct
    WHERE Pr.idUser IN (
		SELECT DISTINCT idFollower FROM FollowerCTE
		WHERE idFollower <> @idInfluencer
	)
    GROUP BY P.IdProduct, P.labelProduct;
	
END