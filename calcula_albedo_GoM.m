%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Para calcular albedo recorte del GoM
clear all, close all,clc


% cos(teta_s) = sin(phi)*sin(delta)+cos(phi)*cos(delta)*cos(h)  

% Declinación terrestre 23.5
% mu es el ánfulo cenital solar
% phi es la latitud
% delta es el ángulo de declinacion  
% h es el ángulo horario. 
% epsilon es el angulo de inclinacion

%carga datos de latitud y longitud
% cd /media/jorge/MyPassport/work/hycom/forzamientos/a20170512/
% load('WRF_2010_lat_lon.mat')
load('/media/DATOS/Alin/boyas/flujos/scrips/figs/WRF_2010_lat_lon.mat')

% para recortar la malla del WRF al GoM
LON=LON(319:560,:); %   [-99.0428   -75.9746]
LAT=LAT(:,129:309); %   [ 17.0867    32.6496] 

% Definir Lat y Lon
phi=LAT(1,:);
lon=LON(:,1);
       
% calcula el albedo para 24 horas del día por 365 días
c=1;
% for nn=1:length(lon);  %contador para longitud
%     for mm=1:length(phi)  %contador para latitud
%         for ii=1:365 %172-79 %1:365;   % 79 días desde el equinoccio de primavera
%             for hd=1:24; % horas del díaphi =
for ii=1:365 %172-79 %1:365;   % 79 días desde el equinoccio de primavera
    ii
    for hd=1:24; % horas del díaphi =
        %           for nn=1:length(lon);  %contador para longitud
%             %  nn
              for mm=1:length(phi)  %contador para latitud
                %  mm
                tv = ii-79;
                T=365.24; % duración del año
                lambda=360*(tv/T);  % día del año en grados
                epsilon=23.5; % inclinación de la tierra
                sdelta=sind(epsilon)*sind(lambda); %angulo de declinación
                delta=asind(sdelta); %en grados
                ddelta(:,:,c)=delta;
                
                
                % ángulo horario
                hd2=hd-1;
                % h = (hd-12)*15;
                %h = (hd2-12-(lon(nn)/15))*15;
                h = (hd2-12-(lon/15))*15;
                %H(hd)=h;
                
                
                % calcular ángulo cenital
                mu=sind(phi(mm))*sind(delta) + cosd(phi(mm))*cosd(delta)*cosd(h);
%                 mu_C(mm,nn,c)=mu; %guarda mu en matriz de 365
%                 a_mu=acosd(mu_C); %misma que mu_C pero en grados
%                 
                %hacer la malla
                %         [yy,mu] = meshgrid(lon,mu); mu=mu';
                
                % calcular albedo
                A = 0.037./(1.1*abs(mu.^1.4)+0.15);
                %albedo(mm,nn,c)=A; %guarda albedo en matriz, como mu_C
                albedo(mm,:,c)=A; %guarda albedo en matriz, como mu_C
                            
              end
              c=c+1;
        end
       % c=1;
    end
%end
for ij=1:24
    AA=squeeze(albedo(:,:,ij));
    figure
    contourf(AA),colorbar
end


% AV=cat(3,albedo(:,:,7:end),albedo(:,:,1:6));

AV=albedo;
lat=phi;



save albedo_WRF_2010_GoM.mat albedo LON LAT -v7.3

%% para graficar

%para graficar serie de tiempo en un punto de la malla WRF
figure, plot(squeeze(albedo(1,1,:)))

%para graficar todos los puntos de la malla WRF en un tiempo
dat=(albedo(:,:,8000));contour(LON,LAT,dat)


