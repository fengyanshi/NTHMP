% clc; clear all
% hmax=load('H:\NTHMP_FL\results\bhm\mC2_bth\Hmax_00024');
% dep=load('H:\NTHMP_FL\model\NTHMP\Grid\C2.txt');
% % vel=load('H:\NTHMP_FL\results\bhm\mC2_bth\Hmax_00024');
% 
% x0 = -80.393246;
% y0 = 25.5859537;
% delta = 0.000093333333;
% 
% [n,m]=size(dep);
% 
% xx=linspace(1,m,m);
% yy=linspace(1,n,n);
% 
% X=x0+delta.*(xx-1);
% Y=y0+delta.*(yy-1);
% [XX YY]=meshgrid(X,Y);
% 
% inun=dep+hmax;
% 
% inun(dep>0)=NaN;
% inun(hmax==0)=NaN;
% 
% figure(1)
% pcolor(XX,YY,inun)
% shading interp
% colormap(autumn)
% caxis([0 1])
% axis tight
% axis off
% set(gca,'Position',[0 0 1.0 1.0]);
% set(gcf,'paperunits','centimeter')
% set(gcf,'papersize',[100,96.7])
% set(gcf,'paperposition',[0 0 100 96.7]);
% print(gcf,'ORG/inundation.png','-dpng','-opengl');
% 
figure(2)
pcolor(XX,YY,inun)
shading interp
colormap(autumn)
caxis([0 1])
axis tight
axis off

h=colorbar;
t=get(h,'Yticklabel');
t=strcat(t,'m');
set(h,'Yticklabel',t);
set(h,'Fontsize',18);
saveas(gcf,'ORG/fld_colorbar_ORG.png') 
a=imread('ORG/fld_colorbar_ORG.png');
b=imcrop(a,[941.5 14.5 236 849]); %%%Can crop by mouse
imshow(b)
set(gca,'Position',[0 0 1.0 1.0]);
saveas(gcf,'ORG/fld_colorbar.png') 




