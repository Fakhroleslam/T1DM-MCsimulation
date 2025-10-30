%==========================================================================
%   Copyright (c) 2025, PSE TMU
%   Process System Engineering (PSE) research group at Tarbiat Modares University (TMU)
%   All rights reserved.
%
%   This code is provided "as is" without any warranties, express or implied,
%   including but not limited to the warranties of merchantability and fitness
%   for a particular purpose.
%
%   Author: Mohammad Fakhroleslam
%   Contact:
%   fakhroleslam@modares.ac.ir
%
%   Last update: 2025-10-29
%%=========================================================================

clearvars
clc

%% Plot the results
d  = 5;
x  = 50+d/2:d:350;
x1 = 50:1:350;

%%
f1 = figure(1);
clf, set(f1,'color','w')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(6,1,1:2)
hold on, box on, grid on
load Results_UE
rectangle('Position',[70 -10 90 50],'FaceColor',[.8 1 .8 .5],'EdgeColor',[0 1 0 .6],'LineS','-','LineWidth',1)
rectangle('Position',[60 -10 10 50],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[40 -10 20 50],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[160 -10 60 50],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[220 -10 60 50],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
h  = histogram(GB_RI_NE(1:end-7.5*60/2,:),50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h1 = plot(x1,s,'r-','LineW',1.5);
h  = histogram(GB_RI_NE,50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h2 = plot(x1,s,'r:','LineW',1);
h  = histogram(GB_LI_NE(1:end-7.5*60/2,:),50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h3 = plot(x1,s,'b-','LineW',1);
h  = histogram(GB_LI_NE,50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h4 = plot(x1,s,'b--','LineW',1);
legend([h1 h2 h3 h4],'RINPH - wake','RINPH - wake & sleep','LINPH - wake','LINPH - wake & sleep')
adjustFig
text(100,19,'Undereating DD','FontW','b','FontSize',13)
set(gca,'XTick',40:20:350,'XTickLabel',[],'FontSize',14)
ylabel('Probability density','FontW','n','FontSize',14.5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(6,1,3:4)
hold on, box on, grid on
load Results_NE
rectangle('Position',[70 -10 90 50],'FaceColor',[.8 1 .8 .5],'EdgeColor',[0 1 0 .6],'LineS','-','LineWidth',1)
rectangle('Position',[60 -10 10 50],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[40 -10 20 50],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[160 -10 60 50],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[220 -10 60 50],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
h  = histogram(GB_RI_NE(1:end-7.5*60/2,:),50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h1 = plot(x1,s,'r-','LineW',1.5);
h  = histogram(GB_RI_NE,50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h2 = plot(x1,s,'r:','LineW',1);
h  = histogram(GB_LI_NE(1:end-7.5*60/2,:),50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h3 = plot(x1,s,'b-','LineW',1);
h  = histogram(GB_LI_NE,50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h4 = plot(x1,s,'b--','LineW',1);
adjustFig
text(100,19,'Normal DD','FontW','b','FontSize',13)
set(gca,'XTick',40:20:350,'XTickLabel',[],'FontSize',14)
ylabel('Probability density','FontW','n','FontSize',14.5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(6,1,5:6)
hold on, box on, grid on
load Results_OE
rectangle('Position',[70 -10 90 50],'FaceColor',[.8 1 .8 .5],'EdgeColor',[0 1 0 .6],'LineS','-','LineWidth',1)
rectangle('Position',[60 -10 10 50],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[40 -10 20 50],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[160 -10 60 50],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[220 -10 60 50],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
h  = histogram(GB_RI_NE(1:end-7.5*60/2,:),50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h1 = plot(x1,s,'r-','LineW',1.5);
h  = histogram(GB_RI_NE,50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h2 = plot(x1,s,'r:','LineW',1);
h  = histogram(GB_LI_NE(1:end-7.5*60/2,:),50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h3 = plot(x1,s,'b-','LineW',1);
h  = histogram(GB_LI_NE,50:d:350,'visible','off');
s  = spline(x,h.Values/sum(h.Values)*100,x1); s(1:7) = 0;
h4 = plot(x1,s,'b--','LineW',1);
adjustFig
text(100,19,'Overeating DD','FontW','b','FontSize',13)
set(gca,'XTick',40:20:350,'FontSize',14)
xlabel({'Blood Glucose [mg/dl]'},'FontW','n','FontSize',16)
ylabel('Probability density','FontW','n','FontSize',14.5)

f1.Renderer = 'Painters';
print(f1,'-dpdf','FIG13')

function adjustFig
axis([50 230 -1 28])
set(gca,'Layer','top')
set(gca,'YTick',0:5:100,'YTickLabel',[],'FontSize',14)
end
