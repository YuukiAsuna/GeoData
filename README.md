# GeoData
This repository contains MATLAB scripts for reading and analyzing geomagnetic field data. The data can include or exclude anomalies based on user input.
## UTMTransform
This script reads latitude and longitude coordinates, converts them to UTM coordinates, and calculates distances between these points. Additionally, it computes deviations between specified points.
## ReadMap
This function reads geomagnetic field data from a file and returns the values at the specified latitude and longitude. The data can either include or exclude anomalies based on the Anomaly parameter.
### Parameters:
Bx, By, Bz: Components of the geomagnetic field.
F: Total intensity of the geomagnetic field.
I: Inclination angle.
D: Declination angle.
H: Horizontal intensity of the geomagnetic field.
lat_s, lon_s: Latitude and longitude of the closest data point.
### Data
The geomagnetic field data files used by these scripts are:
GF without interferences.dat
GF with interferences.dat
Make sure these files are available in the specified path in the scripts.

