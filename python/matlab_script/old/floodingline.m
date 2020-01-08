close all;clc;clear all;
I=imread('ORG/inundation.png');
G=rgb2gray(I);  
% 
figure
bw=im2bw(I,0.8);
imshow(bw);

figure(2)
bw2=bwperim(bw,8);
imshow(bw2);

figure(3)
bw3=~bw2;
imshow(bw3);

bw4 =bwareaopen(bw3, 1);
bw4(1,:)=1;
bw4(end,:)=1;
bw4(:,1)=1;
bw4(:,end)=1;
figure(4),imshow(bw4)

% set(gca,'Position',[0 0 1.0 1.0]);
% saveas(gcf,'fld_edg.png')
% I=imread('fld_edg.png');

bw5=~bw4;
figure(5),imshow(bw5)

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

R(~bw5)=255;   
G(~bw5)=255;      
B(~bw5)=255;
% 
R(bw5)=50;
G(bw5)=100;
B(bw5)=7;
rgb=cat(3,R,G,B);   
figure(6),imshow(rgb)

set(gca,'Position',[0 0 1.0 1.0]);
set(gcf,'paperunits','centimeter')
set(gcf,'papersize',[100,96.7])
set(gcf,'paperposition',[0 0 100 96.7]);
print(gcf,'ORG/ploygon.png','-dpng','-opengl');

% siz=size(I);
% alpha=ones(siz(1),siz(2));
% alpha(B==255)=0;
