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
Subject = 1;

switch Subject
    case 1, load Results_S1
    case 2, load Results_S2
    case 3, load Results_S3
end

%%
f2 = figure(11);
clf, set(f2,'color','w')
subplot(4,1,1:2)
hold on
rectangle('Position',[0 70 50 90],'FaceColor',[.8 1 .8 .5],'EdgeColor',[0 1 0 .5],'LineS','-','LineWidth',1)
rectangle('Position',[0 60 50 10],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[0 40 50 20],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[0 160 50 60],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[0 220 50 100],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)

for i = 1:5
    h2=plot([U2_meal(1,i) U2_meal(1,i)],[0 180],'b-.','LineW',1);
end
axis([0+6.5 24+6.5 50 290])
text(7,266,'LINPH','FontW','b','FontSize',13)
set(gca,'Layer','top')
set(gca,'XTick',8:2:32)
set(gca,'XTickLabel', {'08','10','12','14','16','18','20','22','24','02','04','06'})
set(gca,'YTick',20:40:420,'FontSize',14)
box on
ylabel('Blood Glucose [mg/dl]','FontW','n','FontSize',16)
% legend([h1 h2],'Insulin Injection','Meal Consumption')

subplot(4,1,3:4)
hold on
rectangle('Position',[0 70 50 90],'FaceColor',[.8 1 .8 .5],'EdgeColor',[0 1 0 .5],'LineS','-','LineWidth',1)
rectangle('Position',[0 60 50 10],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[0 40 50 20],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[0 160 50 60],'FaceColor',[1 .9 .9 .3],'EdgeColor','none','LineS','-','LineWidth',1)
rectangle('Position',[0 220 50 100],'FaceColor',[1 .65 .65 .5],'EdgeColor','none','LineS','-','LineWidth',1)

for i = 1:5
    plot([U1_meal(1,i) U1_meal(1,i)],[0 180],'b-.','LineW',1)
end
axis([0+6.5 24+6.5 50 290])
text(7,266,'RINPH','FontW','b','FontSize',13)
set(gca,'Layer','top')
set(gca,'XTick',8:2:32)
set(gca,'XTickLabel', {'08','10','12','14','16','18','20','22','24','02','04','06'})
set(gca,'YTick',20:40:420,'FontSize',14)
box on
ylabel('Blood Glucose [mg/dl]','FontW','n','FontSize',16)
xlabel('Time [hr]','FontW','n','FontSize',16)

subplot(4,1,1:2)
for i = 1:N_sim
    plot(tout2_NE/60+6.5,GB_LI_NE(:,i),'color',[rand(1,3) .4],'LineW',.5)
end
plot(tout2_NE/60+6.5,GB_LI_NE(:,end),'k-','LineW',1.5)
% plot(tout2_NE/60+6.5,min(GB_LI_NE,[],2),'b-','LineW',1)
% plot(tout2_NE/60+6.5,max(GB_LI_NE,[],2),'b-','LineW',1)

subplot(4,1,3:4)
for i = 1:N_sim
    plot(tout2_NE/60+6.5,GB_RI_NE(:,i),'color',[rand(1,3) .4],'LineW',.5)
end
plot(tout2_NE/60+6.5,GB_RI_NE(:,end),'k-','LineW',1.5)
% plot(tout2_NE/60+6.5,min(GB_RI_NE,[],2),'b-','LineW',1)
% plot(tout2_NE/60+6.5,max(GB_RI_NE,[],2),'b-','LineW',1)

f2.Renderer = 'opengl';
print(f2,'-dpdf','-r600','FIG10')

%%
hh_RI = [];
dd = 1;
for i = 1:size(GB_RI_NE,1)
    h = histogram(GB_RI_NE(i,:),50:dd:250,'visible','off');
    hh_RI(:,i) = h.Values;
end

hh_LI = [];
for i = 1:size(GB_LI_NE,1)
    h = histogram(GB_LI_NE(i,:),50:dd:250,'visible','off');
    hh_LI(:,i) = h.Values;
end

%%
f3 = figure(3);
clf, set(f3,'color','w')

subplot(1,10,1:8)
hold on, box on, grid on
imagesc(tout2_NE/60+6.5,50+dd/2:dd:250,hh_RI/N_sim)
N = 50;
map = [];
for i = 1:N
    map(i,1:3) = 1-[0 1 1]*(i-1)/N;
end
colormap(map)
% plot(tout2_NE/60+6.5,GB_RI_NE(:,end),'k-','LineW',1)
plot(tout2_NE/60+6.5,min(GB_RI_NE,[],2),'k:','LineW',1)
plot(tout2_NE/60+6.5,max(GB_RI_NE,[],2),'k:','LineW',1)

axis([0+6.5 24+6.5 50 290])
set(gca,'Layer','top')
set(gca,'XTick',8:2:32)
set(gca,'XTickLabel', {'08','10','12','14','16','18','20','22','24','02','04','06'})
set(gca,'YTick',20:40:420,'FontSize',14)
ylabel({'Blood Glucose [mg/dl]'},'FontW','n','FontSize',16)
xlabel('Time [hr]','FontW','n','FontSize',16)

subplot(1,10,9:10)
hold on, box on, grid on
ddd = 5;
h = histogram(GB_RI_NE,50:ddd:350,'visible','off');
barh(50+ddd/2:ddd:350,h.Values/sum(h.Values)*100,.7,'FaceColor',[1 .7 .7],'EdgeColor','none')

x1 = 50:1:350;
s1 = spline(50+ddd/2:ddd:350,h.Values/sum(h.Values)*100,x1);
plot(s1,x1,'k-','LineW',.5)

axis([0 30 50 290])
xlabel({'Probability';'density'},'FontW','n','FontSize',16)
set(gca,'XTick',0:5:40)
set(gca,'YTick',20:40:420,'YTickLabel',[],'XTickLabel',[],'FontSize',14)

%%
f4 = figure(4);
clf, set(f4,'color','w')

subplot(1,10,1:8)
hold on, box on, grid on
imagesc(tout2_NE/60+6.5,50+dd/2:dd:250,hh_LI/N_sim)
N = 50;
map = [];
for i = 1:N
    map(i,1:3) = 1-[0 1 1]*(i-1)/N;
end
colormap(map)
% plot(tout2_NE/60+6.5,GB_LI_NE(:,end),'k-','LineW',1)
plot(tout2_NE/60+6.5,min(GB_LI_NE,[],2),'b:','LineW',1)
plot(tout2_NE/60+6.5,max(GB_LI_NE,[],2),'b:','LineW',1)

axis([0+6.5 24+6.5 50 290])
set(gca,'Layer','top')
set(gca,'XTick',8:2:32)
set(gca,'XTickLabel', {'08','10','12','14','16','18','20','22','24','02','04','06'})
set(gca,'YTick',20:40:420,'FontSize',14)
ylabel({'Blood Glucose [mg/dl]'},'FontW','n','FontSize',16)
xlabel('Time [hr]','FontW','n','FontSize',16)

subplot(1,10,9:10)
hold on, box on, grid on
h = histogram(GB_LI_NE,50:ddd:350,'visible','off');
barh(50+ddd/2:ddd:350,h.Values/sum(h.Values)*100,.7,'FaceColor',[1 .7 .7],'EdgeColor','none')

x = 50:1:350;
s = spline(50+ddd/2:ddd:350,h.Values/sum(h.Values)*100,x);
plot(s,x,'k-','LineW',.5)

axis([0 30 50 290])
xlabel({'Probability';'density'},'FontW','n','FontSize',16)
set(gca,'XTick',0:5:40)
set(gca,'YTick',20:40:420,'YTickLabel',[],'XTickLabel',[],'FontSize',14)

f3.Renderer = 'Painters';
f4.Renderer = 'Painters';
print(f3,'-dpdf','FIG11')
print(f4,'-dpdf','FIG12')

%%
dd = 2;
for i = 280
    h = histogram(GB_LI_NE(i,:),50:dd:250,'visible','off');
    h_LI = h.Values/N_sim;
end

f44 = figure(10);
clf, set(f44,'color','w')

subplot(1,10,1:8)
hold on, box on, grid on
bar(50+dd/2:dd:250,h_LI,.65,'FaceColor',[1 .6 .6])

axis([66 118 0 max(h_LI)*1.2])
set(gca,'Layer','top')
% set(gca,'XTick',8:2:32)
set(gca,'FontSize',14)
set(gca,'YTickLabel',[])

f44.Renderer = 'Painters';
print(f44,'-dpdf','FIG12_')

%%
% f5 = figure(5);
% clf, hold on, box on, grid on, set(f5,'color','w')
% for i = 1:N_sim
%     plot(tout2_NE/60+6.5,GB_RI_NE(:,i),'color',[1 0 0 .012],'LineW',.5)
% end
% plot(tout2_NE/60+6.5,GB_RI_NE(:,end),'k-','LineW',1)
% plot(tout2_NE/60+6.5,min(GB_RI_NE,[],2),'b-','LineW',1)
% plot(tout2_NE/60+6.5,max(GB_RI_NE,[],2),'b-','LineW',1)
% 
% axis([0+6.5 24+6.5 50 290])
% set(gca,'Layer','top')
% set(gca,'XTick',8:2:32)
% set(gca,'XTickLabel', {'08','10','12','14','16','18','20','22','24','02','04','06'})
% set(gca,'YTick',20:40:420,'FontSize',14)
% ylabel({'Blood Glucose';'[mg/dl]'},'FontW','n','FontSize',16)
% 
% f6 = figure(6);
% clf, hold on, box on, grid on, set(f6,'color','w')
% for i = 1:N_sim
%     plot(tout2_NE/60+6.5,GB_LI_NE(:,i),'color',[1 0 0 .012],'LineW',.5)
% end
% plot(tout2_NE/60+6.5,GB_LI_NE(:,end),'k-','LineW',1)
% plot(tout2_NE/60+6.5,min(GB_LI_NE,[],2),'b-','LineW',1)
% plot(tout2_NE/60+6.5,max(GB_LI_NE,[],2),'b-','LineW',1)
% 
% axis([0+6.5 24+6.5 50 290])
% set(gca,'Layer','top')
% set(gca,'XTick',8:2:32)
% set(gca,'XTickLabel', {'08','10','12','14','16','18','20','22','24','02','04','06'})
% set(gca,'YTick',20:40:420,'FontSize',14)
% ylabel({'Blood Glucose';'[mg/dl]'},'FontW','n','FontSize',16)
