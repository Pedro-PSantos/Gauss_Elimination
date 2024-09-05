function [c] = condm(A,p)

%Efolio B - 2000809
%Script para exercício 1.1

%%%%%%%%%%%%%%%%%%%%%%%%
%%  Ficheiro condm.m  %%
%%%%%%%%%%%%%%%%%%%%%%%%

%A - Matriz A
%p - 1 ou infinito (inf em octave), cc, invalida esta função
%condição = norma de ordem p de A * norma de ordem p da inversa de A

%Condição inicial de funcionalidade (p é 1 ou é infinito)
if(p!=1 && p!=inf)%%caso contrário, retornar matriz vazia
  c=[];
  return;
end

%A diferença entre a norma 1 e inf é uma atuar sobre linhas e a outra sobre colunas
if(p == inf)          %por isso, verificamos se p=inf,
  A = A';             %utilizando a transposta em caso positivo
end                   %podendo assim reutilizar o algoritmo, sem mais condicionais

%ordem da matriz para limitar o ciclo
n=size(A)(1);

%inicializa as normas
norma = 0;
normaInv = 0;

%cria vetores para guardar todos os valores dos somatórios das linhas ou colunas de A, dependendo de p
aux = zeros(1,n);
auxInv = zeros(1,n);

%usa a função inv() para calcular a inversa de A
InvA = inv(A);

for(i=1:n)%calcula a condição de A com norma 1
  aux(i) = sum(abs(A(:,i)));
  auxInv(i) = sum(abs(InvA(:,i)));
end

%onde norma = max do somatório das colunas de A
norma = max(aux);
normaInv = max(auxInv);

c = norma * normaInv;

%EOF

