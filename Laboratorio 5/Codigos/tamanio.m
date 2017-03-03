%Recortar las imagenes
%Submuestreo en la imagen

a = imread('T01_31.jpg')
[x y] = size(a)
b = a(round(x/2)-105:round(x/2)+106,round(y/2)-81:round(y/2)+80)
imshow(a)
figure
imshow(b)