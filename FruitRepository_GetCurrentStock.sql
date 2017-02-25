SELECT Name, 
	   Quantity AS 'Current Stock',
	   CAST(Quantity AS FLOAT)/ (CAST(FPM.NoOfCases AS FLOAT)* CAST(FPCM.NoOfUnit AS FLOAT))  AS 'Current Stock in Pallets',
	   CAST( Quantity AS FLOAT) / CAST( FPCM.NoOfUnit   AS FLOAT) AS 'Current Stock In Cases'
			FROM Fruit F 
			INNER JOIN FruitStock FS ON F.Id = FS.FruitId
			INNER JOIN FruitPalletMap FPM ON FPM.FruitId = FS.FruitId
			INNER JOIN FruitPalletCaseMap FPCM ON FPCM.PalletId = FPM.Id
