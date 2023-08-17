class MapPoint {
    [double]$Longitude
    [double]$Latitude
}

class BoundingBox {
    [MapPoint]$MinPoint
    [MapPoint]$MaxPoint
	
    BoundingBox([MapPoint]$min, [MapPoint]$max) {
        $this.MinPoint = $min
        $this.MaxPoint = $max
    }

    BoundingBox() {
    }

    [String] ToString() {
        return "{0},{1},{2},{3}" -f $this.MinPoint.Latitude, $this.MinPoint.Longitude, $this.MaxPoint.Latitude, $this.MaxPoint.Longitude
    }
}