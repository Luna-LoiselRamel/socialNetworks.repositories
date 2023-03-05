
-- =============================================
-- Author:      Luna
-- Create Date: 01/03/2023
-- Description: requête 3
-- =============================================
CREATE PROCEDURE [dbo].[GetViralProduct]
(
	@profondeur	int
	,@idProduit	int
)
AS
BEGIN
    SET NOCOUNT ON;
	WITH FollowerCTE AS
            (
            -- On démarre avec les user qui ont achetés le produit
            select F1.*,1 AS Niveau
            FROM Followers F1
            WHERE F1.idUser in (select pr.idUser from purchases pr where pr.idProduct=@idProduit)

            UNION ALL

            select F2.idFollower , cte.idUser ,Niveau+1 as Niveau
            FROM Followers F2
            INNER JOIN FollowerCTE cte ON cte.idFollower = F2.idUser
            WHERE niveau < @profondeur
        )

        select P.idProduct, P.labelProduct, COUNT(DISTINCT CONCAT(F.idFollower, F.idUser, F.Niveau))
        from FollowerCTE F, products P
        where F.Niveau = @profondeur and P.idProduct = @idProduit and F.idFollower != F.idUser and  F.idFollower in (Select distinct PR.idUser
                                                                FROM Products P
                                                                JOIN Purchases Pr on Pr.IdProduct = P.IdProduct
                                                                WHERE P.IdProduct = @idProduit)
		GROUP BY P.idProduct, P.labelProduct
	
END