clear; clc;

%% Желаемые целевые значения
TargetPrey = 100;
Proportion = 2;
Addiction  = 10;

%% Константы и начальные значения
Y = 0:0.1:50;
x0 = [10; 10];
T = 1;
p = -Proportion;
d = Addiction;
b1 = 0.5;   
b2 = 0.5;
a1 = (b1*TargetPrey-b1*d)/(-p);
a2 = 0.8;

%% Вычисление
[t, x] = ode45(@(t, x) F(t, x, T, a1, a2, b1, b2, p, d), Y, x0);

%% Построение графика
plot(t, x);
title('Predator-Prey Model');
legend('Prey', 'Predator');

%% Вывод последних вычисленных значений
disp(['Prey:     ' num2str(x(length(x)-1, 1))]);
disp(['Predator: ' num2str(x(length(x)-1, 2))]);
disp(['Target:   ' num2str(x(length(x)-1, 1) + p*x(length(x)-1, 2)-d)]);

%% Система функций с управлением
function OUT = F(t, x, T, a1, a2, b1, b2, p, d)
    u  = @(x1, x2) (b1*x1*x2-a1*x1+p*a2*x2-p*b2*x1*x2-(x1+p*x2-d)/T)/p;
    f1 = @(x1, x2) a1*x1 - b1*x1*x2;
    f2 = @(x1, x2) -a2*x2 + b2*x1*x2 + u(x1,x2);
    OUT = [f1(x(1), x(2)); f2(x(1), x(2))];
end