

select* 
from [Portfolio Project ]..NashvilleHousing


select SaleDateConverted,CONVERT(Date,SaleDate)
from [Portfolio Project ]..NashvilleHousing

Update NashvilleHousing
SET SaleDate= CONVERT(Date,SaleDate)

ALTER Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted= CONVERT(Date,SaleDate)


select*
from [Portfolio Project ]..NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Portfolio Project ]..NashvilleHousing a
join [Portfolio Project ]..NashvilleHousing b
	on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
--Where a.PropertyAddress is null
order by a.ParcelID

Update a 
SET PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Portfolio Project ]..NashvilleHousing a
join [Portfolio Project ]..NashvilleHousing b
	on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null


select 
SUBSTRING(PropertyAddress , 1, CHARINDEX (',' ,PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress ,CHARINDEX (',' ,PropertyAddress)+1,LEN(PropertyAddress)) as Address

from [Portfolio Project ]..NashvilleHousing

ALTER Table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress= SUBSTRING(PropertyAddress , 1, CHARINDEX (',' ,PropertyAddress)-1)

ALTER Table NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity= SUBSTRING(PropertyAddress ,CHARINDEX (',' ,PropertyAddress)+1,LEN(PropertyAddress))


select*
from [Portfolio Project ]..NashvilleHousing

select 
PARSENAME(Replace(OwnerAddress,',','.'),3) as hhh
,PARSENAME(Replace(OwnerAddress,',','.'),2)
,PARSENAME(Replace(OwnerAddress,',','.'),1)
from [Portfolio Project ]..NashvilleHousing

ALTER Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress= PARSENAME(Replace(OwnerAddress,',','.'),3)

ALTER Table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity= PARSENAME(Replace(OwnerAddress,',','.'),2)

ALTER Table NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState= PARSENAME(Replace(OwnerAddress,',','.'),1)

select*
from [Portfolio Project ]..NashvilleHousing

Select distinct(SoldAsVacant), count(SoldAsVacant)
from [Portfolio Project ]..NashvilleHousing
Group by SoldAsVacant
order by SoldAsVacant


select SoldAsVacant
,CASE	when SoldAsVacant='Y'then 'Yes'
		when SoldAsVacant='N' then 'NO'
		Else SoldAsVacant
		End
from [Portfolio Project ]..NashvilleHousing
	

Update NashvilleHousing
SET SoldAsVacant= CASE	when SoldAsVacant='Y'then 'Yes'
		when SoldAsVacant='N' then 'NO'
		Else SoldAsVacant
		End

With ROWNUMCTE as (
select*,
	ROW_NUMBER()OVER (
	PARTITION By ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [Portfolio Project ]..NashvilleHousing
--order by ParcelID
)				
select*
From ROWNUMCTE
--where row_num>1


select *
from [Portfolio Project ]..NashvilleHousing

ALTER Table [Portfolio Project ]..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate