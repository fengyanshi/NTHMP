clear all
close all

threhold=0.01;

fdir='/Volumes/easystore/URI_EC450m/NTHMP/VB/';
fdir_dep=[fdir 'Depths/'];
fdir_writeout='/Users/fengyanshi15/work/NTHMP/';
domain='VB_1/';                % change
dep_name='vi_1arc_1';          % change
xx=load([fdir_dep 'x.txt']);
yy=load([fdir_dep 'y.txt']);
dx=2.777777700000000e-04;

dep=load([fdir_dep dep_name]);
[n m]=size(dep);
x=xx(1)+[0:m-1]*dx;           % change
y=yy(1)+[0:n-1]*dx;           % change

% cases --------
cases={'CFS', 'CVV80' 'LIS' 'PR'};
numb={'0980', '0705' '0733' '0545'};        % change

xyname='CV1_xy.txt';   % change
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

bar_position=[.9 .4 .01 .5];  % change
bar_location='east';

wid=100;
len=96.7;
%len=wid*n/m;
image_size=[wid,len];
image_position=[0 0 wid len];

