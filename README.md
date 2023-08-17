# NOAA Freeze Data PowerShell Scripts

The noaa-geo-data.ps1 scripts takes two parameters

* address
* distance

Address can be a full addreess or just a partial address such as a zip code or city and state.

Distance is the radius in miles used to search for NOAA Stations. I say radius but it's really a square bounding box. If you prefer kilometers you can change that on
[Line 18 in noaa-geo-data.ps1](https://github.com/squintz/NOAA-Freeze-Data/blob/main/noaa-geo-data.ps1?#L18) by changing "mi" to "km"

## Usage

1. Check out this repository
2. Edit keys.ps1 with:
   1. Google Maps API key: https://console.cloud.google.com/
   2. NOAA API Keys: https://www.ncdc.noaa.gov/cdo-web/token
3. Run from PowerShell
   ` .\noaa-geo-data.ps1 -address "7964 Baltimore St Baltimore, MD 21224" -distance 11`

## Future Plans

I have no future plans to maintain these scripts. My goal here was to figure out how to work with the NOAA API so that I can use it in a future mobile app.

## Example Output

```
PS C:\Scripts\> .\noaa-geo-data.ps1 -address "7964 Baltimore St Baltimore, MD 21224" -distance 11
Location: -76.5141056,39.2996889

GeoJSON (Copy to http://bboxfinder.com/):
{
    "coordinates":  [
                        [
                            -76.719882989390058,
                            39.1404493741548
                        ],
                        [
                            -76.308328210609929,
                            39.4589284258452
                        ]
                    ],
    "type":  "LineString"
}

Getting Stations...
BALTIMORE CUSTOMS HOUSE, MD US: GHCND:USW00013777
BALTIMORE WASHINGTON INTERNATIONAL AIRPORT, MD US: GHCND:USW00093721
CYLBURN, MD US: GHCND:USC00182308
MARYLAND SCIENCE CENTER, MD US: GHCND:USW00093784

Calculating Closest Station...
MARYLAND SCIENCE CENTER, MD US

Last Freeze (Get Ready to Transplant):
03/13/2023

First Freeze (Get Ready to Protect the Plants)
12/03/2023
```

## License

[Creative Commons Attribution-NonCommercial (CC BY-NC)](https://creativecommons.org/licenses/by-nc/4.0/)

## Attributions

The primary contributor to this code is ChatGPT. However, I couldn't have done it without the following people:

[kdas](https://https://stackoverflow.com/users/3645686/kdas): [noaa-api-integration (StackOverflow)](https://https://stackoverflow.com/questions/45854063/noaa-api-integration)

- Thanks for supplying a working example!

[macpod](https://https://macpod.net/contact.php)

- Thanks for showing me how to properly use Inspect!




