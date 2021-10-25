%% calcular el ángulo cenital solar (SZA)
% depende de la latitud (phi), la estación (delta) y la hora del día (h)

% mu(=sin(phi)*sin(delta) + cos(phi)*cos(delta)*cos(h)

% donde phi es la latitud

% delta es el ángulo de declinación del sol, varía entre 23.45 (solsticio de verano)
% y -23.45° (solsticio de invierno)

% h es al angulo horario 

%% declinación del sol

tv=240;   % días desde el equinoccio de verano hasta el 15 de nov
T=365.24; % duración del año
lambda=360*(tv/T)

epsilon=23.5 % inclinación de la tierra

delta=sind(epsilon)*sind(lambda)
sdelta=rad2deg(delta) % en grados 

phi=40 % latitud 

h= 360*(3/24) % ángulo horario 

mu=sind(phi)*sind(sdelta) + cosd(phi)*cosd(sdelta)*cosd(h)
a_mu=acosd(mu)


%% declinación del sol

tv=1;   % días desde el equinoccio de verano hasta el 15 de nov
T=365.24; % duración del año
lambda=360*(tv/T);

epsilon=23.5; % inclinación de la tierra

delta=sind(epsilon)*sind(lambda);
sdelta=asind(delta); % en grados 

phi=18; % latitud 

hd=0:6
h= 360*(hd/24); % ángulo horario 

mu=sind(phi)*sind(sdelta) + cosd(phi)*cosd(sdelta)*cosd(h)
a_mu=acosd(mu);




