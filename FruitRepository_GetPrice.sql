SELECT Name, 
	  CAST( FPM.PalletPrice AS FLOAT)/ (CAST(FPM.NoOfCases AS FLOAT) * CAST(FPCM.NoOfUnit AS FLOAT)) AS 'Price'
			FROM Fruit F 
			INNER JOIN FruitPalletMap FPM ON FPM.FruitId = F.Id
			INNER JOIN FruitPalletCaseMap FPCM ON FPCM.PalletId = FPM.Id

