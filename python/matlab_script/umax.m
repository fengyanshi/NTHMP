
fdir_output=[fdir_writeout 'Umax/' domain];
eval(['mkdir ' fdir_output]);

fdir_output_asc=[fdir_writeout 'Umax_ASC/' domain];
eval(['mkdir ' fdir_output_asc]);


for k=1:length(cases)
%for k=2:2
fdir_result=[fdir domain cases{k} '/'];
num=numb{k};

hmax=load([fdir_result 'hmax_' num]);
flood=hmax;

thing=load([fdir_result 'umax_' num]);

% flooded area
f_add=hmax;
f_add(flood>=threhold)=1;
f_add(dep>0)=0;         %
f_add(flood<threhold)=0;
total_flood(:,:,k)=f_add(:,:);

flood(flood>=threhold)=1;
flood(dep>0)=NaN;         %
flood(flood<threhold)=NaN;
%

thing(dep>0)=NaN;         %

total_thing(:,:,k)=thing(:,:);

thing(thing==0.0)=NaN;

fig=figure(1);
clf
%colormap jet
pcolor(x,y,thing),shading flat       %
caxis(rang{k})                       %
c=colorbar;
c.Location=bar_location;
c.TickDirection ='in';
c.Position=bar_position;
c.FontSize = 12;

hold on
contour(x,y,f_add,[0.5 0.5],'Color','k')
axis tight
axis off
set(gca,'Position',[0 0 1.0 1.0]);
set(gcf,'paperunits','centimeter')
set(gcf,'papersize',image_size)
set(gcf,'paperposition',image_position);

% output

set(fig, 'PaperPositionMode', 'auto')
print('-djpeg100',[fdir_output cases{k} 'tmp.jpg'])

% transparent
I=imread([fdir_output cases{k} 'tmp.jpg']);
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
imwrite(rgb,[fdir_output cases{k} '_umax.png'],'Alpha',alpha)

% write out asc
file_name=[fdir_output_asc  cases{k} '_inundep.asc'];
fileID=fopen(file_name,'w');
fprintf(fileID,'ncols %d\n',A1(1));
fprintf(fileID,'nrows %d\n',A1(2));
fprintf(fileID,'xllcorner %12.6f\n',A2(1));
fprintf(fileID,'yllcorner %12.6f\n',A2(2));
fprintf(fileID,'cellsize %16.6e\n',A3);
fprintf(fileID,'NODATA_value %d\n',A4);
fclose(fileID);

thing_write=flipud(thing);
thing_write(isnan(thing_write))=-9999;
dlmwrite(file_name,thing_write,'delimiter','\t','-append')


end

% combine

% flooded area
flood_comb=max(total_flood,[],3);
f_add=flood_comb;
flood_comb(dep>0)=NaN;         %
flood_comb(flood_comb<threhold)=NaN;
%

thing_comb=max(total_thing,[],3);
thing=flood_comb;
thing_comb(dep>0)=NaN;         %
thing_comb(thing_comb==0.0)=NaN;

fig=figure;
clf
%colormap jet
pcolor(x,y,thing_comb),shading flat    %
caxis(rang{5})
c=colorbar;
c.Location=bar_location;
c.TickDirection ='in';
c.Position=bar_position;
c.FontSize = 12;

hold on
contour(x,y,f_add,[0.5 0.5],'Color','k')
axis tight
axis off
set(gca,'Position',[0 0 1.0 1.0]);
set(gcf,'paperunits','centimeter')
set(gcf,'papersize',image_size)
set(gcf,'paperposition',image_position);

set(fig, 'PaperPositionMode', 'auto')
print('-djpeg100',[fdir_output 'tmp.jpg'])

% transparent
I=imread([fdir_output 'tmp.jpg']);
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
imwrite(rgb,[fdir_output 'COMB_umax.png'],'Alpha',alpha)

% write out inundation depth

file_name=[fdir_output_asc 'COMB_umax.asc'];
fileID=fopen(file_name,'w');
fprintf(fileID,'ncols %d\n',A1(1));
fprintf(fileID,'nrows %d\n',A1(2));
fprintf(fileID,'xllcorner %12.6f\n',A2(1));
fprintf(fileID,'yllcorner %12.6f\n',A2(2));
fprintf(fileID,'cellsize %16.6e\n',A3);
fprintf(fileID,'NODATA_value %d\n',A4);
fclose(fileID);

thing_write=flipud(thing_comb);
thing_write(isnan(thing_write))=-9999;
dlmwrite(file_name,thing_write,'delimiter','\t','-append')






