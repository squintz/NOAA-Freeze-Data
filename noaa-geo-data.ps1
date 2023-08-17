param (
    [string]$address,
	[double]$distance
)

#$address = "646 Mansfield Rd. Essex MD 21221"  # Replace with your desired address

. ".\keys.ps1"
. ".\scripts\geocode.ps1"
. ".\scripts\CoordinateClasses.ps1"
. ".\scripts\bounding.ps1"
. ".\scripts\noaa-locations.ps1"
. ".\scripts\noaa-data.ps1"

$latLongObject = GetLatLong -address $address

Write-Host "Location: $($latLongObject.Longitude),$($latLongObject.Latitude)`n"

$boundingBox =  GetBoundingBox -point $latLongObject -halfSideDistance $distance -unit "mi"

$boundingBoxJson = @{
    type = "LineString"
    coordinates = @(
        @($boundingBox.MinPoint.Longitude, $boundingBox.MinPoint.Latitude),
        @($boundingBox.MaxPoint.Longitude, $boundingBox.MaxPoint.Latitude)
    )
} | ConvertTo-Json

Write-Host "GeoJSON (Copy to http://bboxfinder.com/):"
Write-Host $boundingBoxJson

Write-Host "`nGetting Stations..."
$stations = GetStations -boundingBox $boundingBox
$psStations = $stations | ConvertFrom-Json

foreach ($station in $psStations.results) {
    Write-Host "$($station.name): $($station.id)"
}

Write-Host "`nCalculating Closest Station..."
$closestStation = FindClosestStation -originalPoint $latLongObject -jsonStations $stations
$jsonClosestStation = $closestStation | ConvertTo-Json -Depth 2
Write-Host $closestStation.name

Write-Host "`nLast Freeze (Get Ready to Transplant):"
GetDate_PRBLST_T28FP50 -jsonStation $jsonClosestStation

Write-Host "`nFirst Freeze (Get Ready to Protect the Plants)"
GetDate_PRBFST_T28FP50 -jsonStation $jsonClosestStation
