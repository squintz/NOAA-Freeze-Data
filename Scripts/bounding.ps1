. ".\Scripts\CoordinateClasses.ps1"

# Semi-axes of WGS-84 geoidal reference
$WGS84_a = 6378137.0 # Major semiaxis [m]
$WGS84_b = 6356752.3 # Minor semiaxis [m]

# 'halfSideInKm' is the half length of the bounding box you want in kilometers.
function GetBoundingBox([MapPoint]$point,
						[double]$halfSideDistance,
						[string]$unit) {
	
    # Bounding box surrounding the point at given coordinates,
    # assuming local approximation of Earth surface as a sphere
    # of radius given by WGS84
    $lat = Deg2rad($point.Latitude)
    $lon = Deg2rad($point.Longitude)
	
	if ($unit -eq "mi") {
        $halfSide = $halfSideDistance * 1609.34
    } elseif ($unit -eq "km") {
        $halfSide = $halfSideDistance * 1000
    } else {
        throw "Invalid unit. Use 'miles' or 'kilometers'."
    }

    # Radius of Earth at given latitude
    $radius = WGS84EarthRadius($lat)
    # Radius of the parallel at given latitude
    $pradius = $radius * [Math]::Cos($lat)

    $latMin = $lat - $halfSide / $radius
    $latMax = $lat + $halfSide / $radius
    $lonMin = $lon - $halfSide / $pradius
    $lonMax = $lon + $halfSide / $pradius

    return [BoundingBox]@{
        MinPoint = [MapPoint]@{ Latitude = Rad2deg($latMin); Longitude = Rad2deg($lonMin) }
        MaxPoint = [MapPoint]@{ Latitude = Rad2deg($latMax); Longitude = Rad2deg($lonMax) }
    }
}

# degrees to radians
function Deg2rad($degrees) {
    return [Math]::PI * $degrees / 180.0
}

# radians to degrees
function Rad2deg($radians) {
    return 180.0 * $radians / [Math]::PI
}

# Earth radius at a given latitude, according to the WGS-84 ellipsoid [m]
function WGS84EarthRadius($lat) {
    # http://en.wikipedia.org/wiki/Earth_radius
    $An = $WGS84_a * $WGS84_a * [Math]::Cos($lat)
    $Bn = $WGS84_b * $WGS84_b * [Math]::Sin($lat)
    $Ad = $WGS84_a * [Math]::Cos($lat)
    $Bd = $WGS84_b * [Math]::Sin($lat)
    return [Math]::Sqrt(($An*$An + $Bn*$Bn) / ($Ad*$Ad + $Bd*$Bd))
}