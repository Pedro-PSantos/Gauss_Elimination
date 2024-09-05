%Efolio B - 2000809
%Script para exercício 1.3

%%%%%%%%%%%%%%%%%%%%%%%%
%% Ficheiro efb23.m   %%
%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all
clear all

%iniciar valores especificados no enunciado
A = 2.*rand(15,15)-1;
b = 2.*rand(15,1)-1;
tol = 10^-13;

%obter o valor de p=1 ou p=inf, com a mesma probabilidade
if(randi([1,2]) == 1)
  p = 1
else
  p = inf
end

%valores auxiliares para o script
k = (0.0:0.9/49:0.9);%vetor para os valores a utilizar de k
Norma2 = zeros(1,50);%vetor para guardar os valores da norma de ordem2 do erro Ax-b
c = zeros(1,50);%vetor para guardar os valores da condição de A

LogErro = zeros(1,50);%Vetor para guardar os valores log10(erro)
LogCond = zeros(1,50);%Vetor para guardar os valores log10(nro. de condição)

%iniciar o ciclo de 50 iteraçoes
for(i = 1:50)

  c(i) = condm(A,p);%c(i) = ao resultado de condm para a matriz A e o valor p a utilizar na norma

  x = elim_gausspt(A,b,tol);%x = vetor solução de Ax=b

  if(isempty(x))%se x vier vazio, é porque a matriz é singular,
    Norma2(i)=inf;%o valor da norma2 é infinito, como especificado
  else%caso contrário,
    Erro=A*x-b;%Erro é Ax-b

    Somatorio = 0;
    for(j=1:size(Erro)(1))%E a norma 2 deste vetor é Norma2(Erro)=
      Somatorio = Somatorio + abs(Erro(j))^2;%=Somatório de (|x(i)|^2), i=1,2,...,n
    end
    Norma2(i) = Somatorio^(1/2);%Norma2 = Somatório calculado acima elevado a 1/2
  end

  %Variar A segundo o parâmentro k na  expressão:
  A(1,:)= (1-k(i))*A(1,:) + k(i)*A(2,:);

end

LogErro = log10(Norma2);
LogCond = log10(c);

figure(1);
xaxis=1:50;
plot(xaxis,LogErro,xaxis,LogCond);

xlabel("Index de Iteração");
ylabel("log10");
title( "norma do erro vs num. condição, por iteração");
legend( "y1=log10(Erro)","y2=log10(Condição)","location", "northeastoutside");
grid on;

figure(2);
loglog(Norma2,c);
title( "norma do erro vs num. condição");
xlabel("Log10(erro)");
ylabel("Log10(número de condição)");
grid on;

%EOF

