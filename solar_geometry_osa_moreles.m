%% Solar geometry
%% Ocean surface albedo for a given day
%% Efrain Moreles ICML UNAM


clearvars; close all; clc;

phi=32:-0.5:18; % latitud
lon=98:-0.5:76; % longitud
nlat=length(phi);
nlon=length(lon);
A=NaN(nlat,nlon,24); % Matrix for ocean surface albedo

n=181; % dia juliano

for t=0:1:23 % ciclo para horas locales
    for ilat=1:nlat % ciclo para latitud
        for ilon=1:nlon % ciclo para longitud
            h_loc=t; % local hour
            m_loc=0; % local minutes
            
            lon_st=15*round(lon(ilon)/15); % standard meridian for the local time zone
            b=(n-1)*360./365.; % parameter for extraterrestrial radiation incident
            e=229.2*(0.000075+0.001868*cosd(b)-0.032077*sind(b)-0.014615*cosd(2.0*b)-0.04089*sind(2.0*b)); % equation of time in minutes
            m_dif=4*(lon_st-lon(ilon))+e; % difference in minutes
            m_sol=m_loc+m_dif; % solar minutes
            ts=h_loc+m_sol/60; % local solar time in h
            w=15*(ts-12); % hour angle in °
            delta=23.45*sind(360*(284+n)/365); % declination angle in °
            ctz=cosd(phi(ilat))*cosd(delta)*cosd(w)+sind(phi(ilat))*sind(delta); % cosine of the zenith angle of the sun
            A(ilat,ilon,t+1)=0.037/(0.15+1.1*ctz^1.4); % Ocean surface albedo T-OSA
        end
    end
end

%% Figuras para el período cuando el sol está sobre el horizonte en todo el GoM
[X,Y] = meshgrid(lon,phi);

for t=8:16
    z=A(:,:,t+1);
    figure(t+1); contour(X,Y,z,'ShowText','on');
    set(gca, 'XDir','reverse')
end

% figure(1); imagesc(lon,phi,z); colorbar
% set(gca,'YDir','normal')
% set(gca, 'XDir','reverse')


%% Para tiempos cuando el sol no está sobre el horizonte el angulo cenital solar es mayor que 90°
% lo cual quiere decir que aún no amanece o que ya se ocultó el sol
% Para estos casos el coseno del angulo es negativo
% Hay que tomar en cuenta esto para el cálculo de la radiación solar
