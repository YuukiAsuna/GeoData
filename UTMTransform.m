clc;
clear;

% Coordinates: the first two positions are the start and end positions

% % Define coordinates without anomaly
% coords = [22.6, 132.9;
%           20.800, 136.00;
%           20.812, 135.954;
%           20.889, 135.884;
%           20.862, 135.930;
%           20.851, 135.896;
%           21.142, 136.124];

% Define coordinates with anomaly
coords = [22.6, 132.9;
          20.800, 136.00;
          20.926, 135.974;
          21.249, 135.871;
          21.507, 134.194;
          21.633, 134.158;
          20.957, 135.789];

% Store UTM coordinates and zones
utmCoords = zeros(size(coords, 1), 2);
utmZones = strings(size(coords, 1), 1);

% Convert latitude and longitude to UTM coordinates and print
for i = 1:size(coords, 1)
    [utmCoords(i,1), utmCoords(i,2), utmZones(i)] = latlonToUTM(coords(i,1), coords(i,2));
    fprintf('UTM%d Zone: %s\n', i, utmZones(i));
    fprintf('UTM%d X: %f\n', i, utmCoords(i,1));
    fprintf('UTM%d Y: %f\n', i, utmCoords(i,2));
end

% Calculate and print the distance between each pair of coordinates
for i = 1:size(utmCoords, 1) - 1
    for j = i + 1:size(utmCoords, 1)
        dist = calculateDistance(utmCoords(i,1), utmCoords(i,2), utmCoords(j,1), utmCoords(j,2));
        fprintf('Distance %d-%d: %f meters\n', i, j, dist);
    end
end

% Calculate and print deviations
deviation1 = calculateDistance(utmCoords(2,1), utmCoords(2,2), utmCoords(3,1), utmCoords(3,2)) / calculateDistance(utmCoords(1,1), utmCoords(1,2), utmCoords(2,1), utmCoords(2,2))
deviation2 = calculateDistance(utmCoords(2,1), utmCoords(2,2), utmCoords(4,1), utmCoords(4,2)) / calculateDistance(utmCoords(1,1), utmCoords(1,2), utmCoords(2,1), utmCoords(2,2))
deviation3 = calculateDistance(utmCoords(2,1), utmCoords(2,2), utmCoords(5,1), utmCoords(5,2)) / calculateDistance(utmCoords(1,1), utmCoords(1,2), utmCoords(2,1), utmCoords(2,2))
deviation4 = calculateDistance(utmCoords(2,1), utmCoords(2,2), utmCoords(6,1), utmCoords(6,2)) / calculateDistance(utmCoords(1,1), utmCoords(1,2), utmCoords(2,1), utmCoords(2,2))
deviation5 = calculateDistance(utmCoords(2,1), utmCoords(2,2), utmCoords(7,1), utmCoords(7,2)) / calculateDistance(utmCoords(1,1), utmCoords(1,2), utmCoords(2,1), utmCoords(2,2))

% Function to calculate the distance between two lat/lon points
function distance = distanceBetween(lat1, lon1, lat2, lon2)
    radius = 6371; % km
    dlat = deg2rad(lat2 - lat1);
    dlon = deg2rad(lon2 - lon1);
    a = sin(dlat/2) * sin(dlat/2) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dlon/2) * sin(dlon/2);
    c = 2 * atan2(sqrt(a), sqrt(1-a));
    distance = radius * c;
end

% Function to convert latitude and longitude to UTM coordinates
function [x, y, utmzone] = latlonToUTM(lat, lon)
    % Check if latitude and longitude are numeric
    if ~isnumeric(lat) || ~isnumeric(lon)
        error('Latitude and longitude must be numeric.');
    end

    % Check validity of latitude and longitude
    if lat < -80 || lat > 84 || lon < -180 || lon > 180
        error('Latitude must be between -80 and 84, longitude must be between -180 and 180.');
    end

    % Calculate UTM zone number
    zone = floor((lon + 180)/6) + 1;

    % Calculate UTM band letter
    bands = 'CDEFGHJKLMNPQRSTUVWX';
    bandIndex = floor((lat + 80)/8) + 1;
    band = bands(bandIndex);

    % Combine UTM zone number and band letter
    utmzone = sprintf('%02d%c', zone, band);

    % Convert coordinates using UTM zone and band
    utmstruct = defaultm('utm');
    utmstruct.zone = utmzone;
    utmstruct = defaultm(utmstruct);
    [x, y] = projfwd(utmstruct, lat, lon);
end

% Function to calculate the distance between two UTM coordinates
function distance = calculateDistance(x1, y1, x2, y2)
    distance = sqrt((x2 - x1)^2 + (y2 - y1)^2);
end
