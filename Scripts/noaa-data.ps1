. ".\keys.ps1"
. ".\Scripts\geocode.ps1"
. ".\Scripts\CoordinateClasses.ps1"
. ".\Scripts\bounding.ps1"
. ".\Scripts\noaa-locations.ps1"

# PRBLST = Probability of Last Occurence
#		   This means the earliest date we would want to transplant outdoors
function GetDate_PRBLST_T28FP50([string] $jsonStation) {
	
	# Convert the JSON string back to a PowerShell object
	$station = ConvertFrom-Json $jsonStation
	
	$uriWithParams = "https://www.ncdc.noaa.gov/cdo-web/api/v2/data?" +
					 "&datasetid=NORMAL_ANN" +
					 "&datatypeid=ANN-TMIN-PRBLST-T28FP50" +
					 "&startdate=2010-01-01" +
					 "&enddate=2010-01-01" +
					 "&stationid=" +
					 $station.id
					 
	$headers = @{
		'token' = $token
	}

	$response = Invoke-RestMethod -Uri $uriWithParams -Headers $headers

	$responseJson = $response | ConvertTo-Json -Depth 10

	#$responseJson
	
	$dayOfYear = $response.results[0].value
	$currentYear = (Get-Date).Year
	$calendarDate = (Get-Date -Year $currentYear -Month 1 -Day 1).AddDays($dayOfYear - 1)

	$formattedDate = $calendarDate.ToString("MM/dd/yyyy")

	Write-Host $formattedDate
}

# PRBFST = Probability of First Occurence
#		   This means the date we would want to bring plants back indoors
function GetDate_PRBFST_T28FP50([string] $jsonStation) {
	
	# Convert the JSON string back to a PowerShell object
	$station = ConvertFrom-Json $jsonStation
	
	$uriWithParams = "https://www.ncdc.noaa.gov/cdo-web/api/v2/data?" +
					 "&datasetid=NORMAL_ANN" +
					 "&datatypeid=ANN-TMIN-PRBFST-T28FP50" +
					 "&startdate=2010-01-01" +
					 "&enddate=2010-01-01" +
					 "&stationid=" +
					 $station.id
					 
	$headers = @{
		'token' = $token
	}

	$response = Invoke-RestMethod -Uri $uriWithParams -Headers $headers

	$responseJson = $response | ConvertTo-Json -Depth 10

	#$responseJson
	
	$dayOfYear = $response.results[0].value
	$currentYear = (Get-Date).Year
	$calendarDate = (Get-Date -Year $currentYear -Month 1 -Day 1).AddDays($dayOfYear - 1)

	$formattedDate = $calendarDate.ToString("MM/dd/yyyy")

	Write-Host $formattedDate
}
