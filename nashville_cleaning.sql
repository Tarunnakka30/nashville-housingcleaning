-- Filled Missing PropertyAddress Values
SELECT *
FROM dbo.nashville_housing_data
WHERE PropertyAddress IS NULL;

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM dbo.nashville_housing_data a
JOIN dbo.nashville_housing_data b 
ON a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET a.PropertyAddress = b.PropertyAddress
FROM dbo.nashville_housing_data a
JOIN dbo.nashville_housing_data b
ON a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL OR a.PropertyAddress = '';

-- Split PropertyAddress into Street & City
ALTER TABLE nashville_housing_data
ADD PropertyStreet NVARCHAR(255), PropertyCity NVARCHAR(255);

UPDATE nashville_housing_data
SET 
PropertyStreet = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1),
PropertyCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+2,LEN(PropertyAddress))

-- Split OwnerAddress into Street, City and State
SELECT OwnerAddress,
PARSENAME(REPLACE(OwnerAddress,',','.'),3) AS OwnerStreet,
PARSENAME(REPLACE(OwnerAddress,',','.'),2) AS OwnerCity,
PARSENAME(REPLACE(OwnerAddress,',','.'),1) AS OwnerState
FROM dbo.nashville_housing_data;

ALTER TABLE nashville_housing_data
ADD OwnerStreet NVARCHAR(255), OwnerCity NVARCHAR(255), OwnerState NVARCHAR(255);

UPDATE dbo.nashville_housing_data
SET 
OwnerStreet = PARSENAME(REPLACE(OwnerAddress,',','.'),3),
OwnerCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2),
OwnerState = PARSENAME(REPLACE(OwnerAddress,',','.'),1);

-- Cleaned Inconsistent Values in SoldAsVacant
SELECT DISTINCT SoldAsVacant
FROM dbo.nashville_housing_data;

ALTER TABLE nashville_housing_data
ADD SoldAsVacantText NVARCHAR(10);

UPDATE dbo.nashville_housing_data
SET SoldAsVacantText = CASE 
WHEN SoldAsVacant = 0 THEN 'No'
WHEN SoldAsVacant = 1 THEN 'Yes'
ELSE 'Unknown'
END;

-- Remove Duplicate Entries
SELECT 
ParcelId, PropertyAddress, SalePrice, SaleDate, LegalReference, COUNT(*) AS count_val
FROM dbo.nashville_housing_data
GROUP BY 
ParcelID,
PropertyAddress,
SalePrice,
SaleDate,
LegalReference
HAVING COUNT(*) > 1;

WITH DuplicateCTE AS  (
	SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelId, PropertyAddress, SalePrice, SaleDate, LegalReference
	ORDER BY UniqueId
	) AS row_num
	FROM nashville_housing_data
)
DELETE FROM DuplicateCTE
WHERE row_num > 1;

-- Dropped Unnecessary Columns
ALTER TABLE nashville_housing_date
DROP COLUMN PropertyAddress, OwnerAddress, SoldAsVacant, TaxDistrict;




