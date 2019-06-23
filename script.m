%%
I = rgb2gray(imread('portrait.jpg'));
I = im2double(I);

%%
Sx = [-1 -2 -1; 0 0 0; 1 2 1] ./ 8;
Sy = [-1 0 1; -2 0 2; -1 0 1] ./ 8;

Ix = imfilter(I, Sx, 'replicate');
Iy = imfilter(I, Sy, 'replicate');

H = fspecial('gaussian', [5 5], 1);
A = imfilter(Ix.^2, H, 'replicate');
B = imfilter(Iy.^2, H, 'replicate');
C = imfilter(Ix .* Iy, H, 'replicate');

figure; imshow(I);
figure; imshow(A, []);
figure; imshow(B, []);
figure; imshow(C, []);

k = 0.05;
R = A .* B - C.^2 - k * ((A + B).^2);
Q = R ./ max(R(:));

threshold = 0.15;

corner = Q;
corner(Q < threshold) = 0;
corner(Q >= threshold) = 1;

figure; imshow(corner);

%%
corners = detectHarrisFeatures(I, 'MinQuality', 0.25, 'FilterSize', 5);
figure; 
imshow(I);
hold on;
plot(corners);
hold off;
