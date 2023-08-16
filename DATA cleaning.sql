use portfolioproject
select * from nashville

--cleaning data in sql quieres
use portfolioproject
select * from nashville



--standadise data format


ALTER TABLE nashville
alter column saledate date

use portfolioproject
select Saledate from nashville


-- popultebpoperty address data
use portfolioproject
select * from nashville
--where PropertyAddress is null
order by PropertyAddress

use portfolioproject
select a.ParcelID ,a.PropertyAddress, b.ParcelID ,b.PropertyAddress ,
ISNULL(a.PropertyAddress,b.PropertyAddress)from nashville a
join nashville b
on a.ParcelID =b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null
order by a.ParcelID



update a 
set Propertyaddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from nashville a
join nashville b
on a.ParcelID =b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

 -- breaking address into city ,state ,address

 -- popultebpoperty address data
use portfolioproject
select PropertyAddress from nashville
--where PropertyAddress is null
--order by
use portfolioproject

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address from nashville




alter table nashville
add  Propertyslitaddress nvarchar (255)
  . 
update nashville
set
 Propertyslitaddress=substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 



alter table nashville
add Propertyslitcity  nvarchar (255)

update nashville
set 
Propertyslitcity =SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) 



use portfolioproject
select OwnerAddress from nashville

select
PARSENAME(Replace(owneraddress,',','.'), 3),PARSENAME(Replace(owneraddress,',','.'), 2),PARSENAME(Replace(owneraddress,',','.'), 1)

from nashville


alter table nashville
add  ownerslitaddress nvarchar (255)
 
update nashville
set
 ownerslitaddress=PARSENAME(Replace(owneraddress,',','.'), 3)
alter table nashville
add ownerslitcity  nvarchar (255)

update nashville
set 
ownerslitcity =PARSENAME(Replace(owneraddress,',','.'), 2)

alter table nashville
add ownersplitstate  nvarchar (255)
update nashville
set 
ownersplitstate =PARSENAME(Replace(owneraddress,',','.'), 1)




use portfolioproject
select Distinct(SoldAsVacant)
, count(SoldAsVacant)from nashville
group by soldasvacant
order by 2 desc

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From nashville


Update nashville
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END



WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From nashville
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


	     



--- used data
Select *
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate