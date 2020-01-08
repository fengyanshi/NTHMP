
param_CV4;  % change

rang={[0 1],[0 5],[0 1],[0 1],[0 5]};         % change
% --------------


fdir_output=[fdir_writeout 'Hmax/' domain];
eval(['mkdir ' fdir_output]);


for k=1:length(cases)
%for k=2:2
fdir_result=[fdir domain cases{k} '/'];
num=numb{k};

hmax=load([fdir_result 'hmax_' num]);

flood=hmax;
flood(flood>0.0)=1;
flood(dep>0)=0;
flood(flood<threhold)=0;

total_flood(:,:,k)=flood(:,:);

hmax(dep>0)=NaN;
hmax(hmax<threhold)=NaN;

total_hmax(:,:,k)=hmax;

fig=figure(1);
clf
%colormap jet
pcolor(x,y,hmax),shading flat
caxis(rang{k})
c=colorbar;
c.Location='east';
c.TickDirection ='in';
c.Position=[.9 .4 .01 .5];
c.FontSize = 12;

hold on
contour(x,y,flood,[0.5 0.5],'Color','k')
axis tight
axis off
set(gca,'Position',[0 0 1.0 1.0]);
set(gcf,'paperunits','centimeter')
set(gcf,'papersize',[100,96.7])
set(gcf,'paperposition',[0 0 100 96.7]);

% output

set(fig, 'PaperPositionMode', 'auto')
print('-djpeg100',[fdir_output cases{k} '_hmax.jpg'])

% transparent
I=imread([fdir_output cases{k} '_hmax.jpg']);
G=rgb2gray(I);  
ima=imadjust(G);  
bw=im2bw(ima);     
%figure,imshow(bw)

% level=graythresh(G);
level=0.9;
bw2=im2bw(ima,level);
%figure,imshow(bw2);

bw3=~bw2;   
bw4 =bwareaopen(bw3, 20);
%bw4=imfill(~bw4,'hole');
%figure,imshow(bw4)

bw5=~bw4;
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);


R(bw5)=255;
G(bw5)=255;
B(bw5)=255;
rgb=cat(3,R,G,B);   
%figure,imshow(rgb)


siz=size(I);
alpha=ones(siz(1),siz(2));
alpha(B==255)=0;    
imwrite(rgb,[fdir_output cases{k} '_hmax.png'],'Alpha',alpha)


end

% combine
hmax_comb=max(total_hmax,[],3);
flood_comb=max(total_flood,[],3);

fig=figure;
clf
%colormap jet
pcolor(x,y,hmax_comb),shading flat
caxis(rang{k+1})
c=colorbar;
c.Location='east';
c.TickDirection ='in';
c.Position=[.9 .4 .01 .5];
c.FontSize = 12;
hold on
contour(x,y,flood_comb,[0.5 0.5],'Color','k')
axis tight
axis off
set(gca,'Position',[0 0 1.0 1.0]);
set(gcf,'paperunits','centimeter')
set(gcf,'papersize',[100,96.7])
set(gcf,'paperposition',[0 0 100 96.7]);

set(fig, 'PaperPositionMode', 'auto')
print('-djpeg100',[fdir_output 'COMB_hmax.jpg'])

% transparent
I=imread([fdir_output 'COMB_hmax.jpg']);
G=rgb2gray(I);  
ima=imadjust(G);  
bw=im2bw(ima);     
%figure,imshow(bw)

% level=graythresh(G);
level=0.9;
bw2=im2bw(ima,level);
%figure,imshow(bw2);

bw3=~bw2;   
bw4 =bwareaopen(bw3, 20);
%bw4=imfill(~bw4,'hole');
%figure,imshow(bw4)

bw5=~bw4;
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

R(bw5)=255;
G(bw5)=255;
B(bw5)=255;
rgb=cat(3,R,G,B);   
%figure,imshow(rgb)

siz=size(I);
alpha=ones(siz(1),siz(2));
alpha(B==255)=0;    
imwrite(rgb,[fdir_output 'COMB_hmax.png'],'Alpha',alpha)


% coordinate
xy(1,1)=x(1);
xy(1,2)=y(1);
xy(2,1)=x(end);
xy(2,2)=y(end);

save('-ASCII',[fdir_output 'domain_xy.txt'],'xy')





