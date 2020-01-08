clear all
close all

threhold=0.01;

fdir='/Volumes/easystore/URI_EC450m/NTHMP/VB/';
fdir_dep=[fdir 'Depths/'];
fdir_writeout='/Users/fengyanshi15/work/NTHMP/';
domain='VB_5/';                % change
dep_name='vi_1arc_5';          % change
xx=load([fdir_dep 'x.txt']);
yy=load([fdir_dep 'y.txt']);
dx=2.777777700000000e-04;

dep=load([fdir_dep dep_name]);
[n m]=size(dep);
x=xx(5)+[0:m-1]*dx;           % change
y=yy(5)+[0:n-1]*dx;           % change

[lonR latR]=meshgrid(x,y);

% cases --------
cases={'CFS', 'CVV80' 'LIS' 'PR'};
numb={'0611', '0680' '0292' '0647'};        % change
rang={[0 1],[0 5],[0 1],[0 1],[0 5]};         % change
% --------------


fdir_output=[fdir_writeout 'Polygon/' domain];
eval(['mkdir ' fdir_output]);


for k=1:length(cases)
%for k=2:2
fdir_result=[fdir domain cases{k} '/'];
num=numb{k};

hmax=load([fdir_result 'hmax_' num]);

hmax(hmax>0.0)=1;
hmax(dep>0)=0;
hmax(hmax<threhold)=0;

total_hmax(:,:,k)=hmax(:,:);

cmatrix =contour(lonR,latR,hmax,[0.5 0.5]);
shapedata = contour2shape(cmatrix) ;
shapewrite(shapedata, [fdir_output cases{k} '.shp']);

end

% combine
hmax_comb=max(total_hmax,[],3);

cmatrix =contour(lonR,latR,hmax_comb,[0.5 0.5]);
shapedata = contour2shape(cmatrix) ;
shapewrite(shapedata, [fdir_output  'COMB.shp']);





