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

xyname='CV5_xy.txt';   % change
% --------------

A1=[m n];
A2=[xx(1) yy(1)];
A3=dx;
A4=-9999;

% coordinate
xy(1,1)=x(1);
xy(1,2)=y(1);
xy(2,1)=x(end);
xy(2,2)=y(end);
save('-ASCII',xyname,'xy')

bar_position=[.1 .4 .01 .45];  % change
bar_location='east';

wid=100;
len=96.7;
%len=wid*n/m;
image_size=[wid,len];
image_position=[0 0 wid len];
