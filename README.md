# FruitMarket

Two Procedure are created
- GetCurrentStock: Which will give you current stock in Unit, Cases and Pallet for each fruit
  
  ```sql
  SELECT Name, 
	   Quantity AS 'Current Stock',
	   CAST(Quantity AS FLOAT)/ (CAST(FPM.NoOfCases AS FLOAT)* CAST(FPCM.NoOfUnit AS FLOAT))  AS 'Current Stock in Pallets',
	   CAST( Quantity AS FLOAT) / CAST( FPCM.NoOfUnit   AS FLOAT) AS 'Current Stock In Cases'
			FROM Fruit F 
			INNER JOIN FruitStock FS ON F.Id = FS.FruitId
			INNER JOIN FruitPalletMap FPM ON FPM.FruitId = FS.FruitId
			INNER JOIN FruitPalletCaseMap FPCM ON FPCM.PalletId = FPM.Id
  ```
  
- GetPrice: Which will give you price of each fruit.
This query also included in script file.

Below is the Database diagram: 
![Database Digram](https://raw.githubusercontent.com/NeelamYangal/FruitMarket/master/FruitRepository.JPG)

