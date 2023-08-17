. ".\keys.ps1"
. ".\Scripts\CoordinateClasses.ps1"

function GetLatLong ([string]$address) {
	# Construct the API request URL
	$baseURL = "https://maps.googleapis.com/maps/api/geocode/json?address=" + $address + "&key=" + $apiKey

	# Send the request and parse the JSON response
	$response = Invoke-RestMethod -Uri $baseURL -Method Get
	
	$location = $response.results[0].geometry.location

    # Create a new MapPoint object
    $LatLong = [MapPoint]::new()
    $LatLong.Latitude = $location.lat
    $LatLong.Longitude = $location.lng
	
	return $LatLong
}

