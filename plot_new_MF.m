clear;
clc;
% load('MB_Results/MB_pima_diabetes_R3_newmf.mat');
% 1:Pregnancies 2:Glucose 3:BloodPressure 4:SkinThickness 
% 5:Insulin	6:BMI 7:DiabetesPedigreeFunction 8:Age
load('WM_results/mammogarphic_masses.mat');
Vs = bestresult.models{1,1}.Vs(:,5);
name = 'Density';

x = 0:0.005:1;
% x = 0.075:0.0001:0.3145;
[~,d] = size(x);
y1 = zeros(1,d);
y2 = zeros(1,d);
y3 = zeros(1,d);

v1 = Vs(1,:);
v2 = Vs(2,:);
v3 = Vs(3,:);

for i = 1:d
    if x(:,i)<=v1
        y1(:,i) = 1;
    elseif (v1 < x(:,i)) && (x(:,i)<v2)
        y1(:,i) = (x(:,i) - v2) ./ (v1 - v2);
    elseif v2 < x(:,i)
        y1(:,i) = 0;
    end
end

for j = 1:d
    if x(:,j)<= v1
        y2(1,j) = 0;
    elseif (v1<x(:,j)) && (x(:,j)<=v2)
        y2(1,j) = (x(:,j) - v1) ./ (v2 - v1);
    elseif (v2<x(:,j)) && (x(:,j)<v3)
        y2(1,j) = (x(:,j) - v3) ./ (v2 - v3);
    elseif v3<=x(:,j)
        y2(1,j) = 0;
    end
end

for k = 1:d
      if x(:,k) <= v2
        y3(:,k) = 0;
    elseif (v2<x(:,k)) && (x(:,k)<v3)
        y3(:,k) = (x(:,k)-v2) ./ (v3-v2);
    elseif v3<x(:,k)
        y3(:,k) = 1;
      end
end
% plot(x,y1,'r-',x,y2,'b-', x,y3,'g-');

plot(x,y1,'--k','LineWidth',2);
hold on;
plot(x,y2,':ko','LineWidth',1);
hold on;
plot(x,y3,'-k','LineWidth',2);
set(gca,'FontSize',20);
legend('Low','Medium','High');
title(name,'FontSize',20);
saveas(gcf,['Figs/' name '.png'])
%         if cur_p==1
%             if cur_xj<=v1
%                 FSs(i,j) = 1;
%             elseif (v1 < cur_xj) && (cur_xj<v2)
%                 FSs(i,j) = (cur_xj - v2) ./ (v1 - v2);
%             elseif v2 < cur_xj
%                 FSs(i,j) = 0;
%             end
%         elseif cur_p==2
%             if cur_xj <= v1
%                 FSs(i,j) = 0;
%             elseif (v1<cur_xj) && (cur_xj<=v2)
%                 FSs(i,j) = (cur_xj - v1) ./ (v2 - v1);
%             elseif (v2<cur_xj) && (cur_xj<v3)
%                 FSs(i,j) = (cur_xj-v3) ./ (v2 - v3);
%             elseif v3<=cur_xj
%                 FSs(i,j) = 0;
%             end
%         elseif cur_p==3
%             if cur_xj <= v2
%                 FSs(i,j) = 0;
%             elseif (v2<cur_xj) && (cur_xj<v3)
%                 FSs(i,j) = (cur_xj-v2) ./ (v3-v2);
%             elseif v3<cur_xj
%                 FSs(i,j) = 1;
%             end
%         end