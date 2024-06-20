function [Bx, By, Bz, F, I, D, H, lat_s, lon_s] = ReadMap(lat, lon, Anomaly)
% This function reads geomagnetic field data from a file and returns the
% values at the specified latitude and longitude. The data can either
% include or exclude anomalies based on the Anomaly parameter.

% Example usage:
% Anomaly = 1;
% lon = 135.97;
% lat = 21.8;
% latitude_range = 5;
% longitude_range = 5;
% gridsize = 500;

% Determine which dataset to read based on the Anomaly parameter
if Anomaly == 1
    % Read data without interferences (anomalies)
    GF_info = readmatrix("C:\Users\yangs\Navigation\GF without interferences.dat");
else
    % Read data with interferences (anomalies)
    GF_info = readmatrix("C:\Users\yangs\Navigation\GF with interferences.dat");
end

% Extract columns from the data file
Bx_out = GF_info(:, 1); % Bx component of geomagnetic field
By_out = GF_info(:, 2); % By component of geomagnetic field
Bz_out = GF_info(:, 3); % Bz component of geomagnetic field
F_out = GF_info(:, 4);  % Total intensity of the geomagnetic field
I_out = GF_info(:, 5);  % Inclination angle
D_out = GF_info(:, 6);  % Declination angle
H_out = GF_info(:, 7);  % Horizontal intensity of the geomagnetic field
lat_out = GF_info(:, 8); % Latitude
lon_out = GF_info(:, 9); % Longitude

% Find the index of the closest latitude and longitude in the data
dis_lat = min(abs(lat_out - lat)); % Minimum distance in latitude
dis_lon = min(abs(lon_out - lon)); % Minimum distance in longitude
indices = find(abs(lat_out - lat) == dis_lat & abs(lon_out - lon) == dis_lon);

% Output the latitude and longitude found (for verification)
lat_out(indices)
lon_out(indices)

% Retrieve the geomagnetic field data at the closest location
Bx = Bx_out(indices(1));
By = By_out(indices(1));
Bz = Bz_out(indices(1));
F = F_out(indices(1));
I = I_out(indices(1));
D = D_out(indices(1));
H = H_out(indices(1));
lat_s = lat_out(indices(1));
lon_s = lon_out(indices(1));

% End of function
end
