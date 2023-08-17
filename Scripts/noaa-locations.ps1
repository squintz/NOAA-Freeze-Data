. ".\keys.ps1"
. ".\Scripts\CoordinateClasses.ps1"
. ".\Scripts\bounding.ps1"

function GetStations([BoundingBox] $boundingBox)
{
	$uriWithParams = "https://www.ncdc.noaa.gov/cdo-web/api/v2/stations?limit=50" +
					 "&offset=1" +
					 "&datasetid=NORMAL_ANN" +
					 "&startdate=2010-01-01" +
					 "&enddate=2010-01-01" +
					 "&sortfield=name" +
					 "&extent=$($boundingBox.ToString())"
	
	$headers = @{
		'token' = $token
	}

	$response = Invoke-RestMethod -Uri $uriWithParams -Headers $headers

	$responseJson = $response | ConvertTo-Json -Depth 10
	
	return $responseJson
}

function FindClosestStation([MapPoint]$originalPoint, $jsonStations) {
    # Convert the JSON string to a PowerShell object
    $stations = $jsonStations | ConvertFrom-Json

    # Initialize variables to store the closest station's details
    $closestStation = $null
    $closestDistance = [double]::MaxValue

    foreach ($station in $stations.results) {
        $stationPoint = [MapPoint]@{
            Latitude = $station.latitude
            Longitude = $station.longitude
        }

        # Calculate the distance between the original point and the station
        $distance = CalculateDistance $originalPoint $stationPoint

        # Check if this station is closer than the previous closest station
        if ($distance -lt $closestDistance) {
            $closestDistance = $distance
            $closestStation = $station
        }
    }

    return $closestStation
}

# Define the CalculateDistance function to calculate distance between two points
function CalculateDistance([MapPoint]$point1, [MapPoint]$point2) {
    $earthRadius = 6371000.0 # Approximate Earth radius in meters
    $lat1Rad = Deg2Rad $point1.Latitude
    $lat2Rad = Deg2Rad $point2.Latitude
    $deltaLat = Deg2Rad ($point2.Latitude - $point1.Latitude)
    $deltaLon = Deg2Rad ($point2.Longitude - $point1.Longitude)

    $a = [Math]::Sin($deltaLat / 2.0) * [Math]::Sin($deltaLat / 2.0) + [Math]::Cos($lat1Rad) * [Math]::Cos($lat2Rad) * [Math]::Sin($deltaLon / 2.0) * [Math]::Sin($deltaLon / 2.0)
    $c = 2 * [Math]::Atan2([Math]::Sqrt($a), [Math]::Sqrt(1 - $a))
    $distance = $earthRadius * $c

    return $distance
}

