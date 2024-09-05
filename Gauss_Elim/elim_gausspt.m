function [x] = elim_gausspt(A,b,tol)

%Efolio B - 2000809
%Script para exercício 1.2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Ficheiro elim_gausspt.m  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = size(A)(1);%ordem da matriz A e número de linah de b

pivot = [0,0];  %primeiro valor é o valor do pivot, o segundo a linha

x = zeros(n,1); %variável x para guardar a matriz solução

for(k = 1:n-1)%para todos k = 1,2,...n-1

  m = zeros(1,n-k); %vetor para os valores dos multiplicadores
  pivot=[A(k,k),k];%assimila pivot como o elemento k,k, ou seja o elemento k da diagonal principal

  %Escolha do pivot, consoante a técnica da escolha parcial de pivot
  for(i=k+1:n(1))
    if(abs(A(i,k))>pivot(1))%(1)) %verifica se existe algum valor maior na coluna
      pivot(1) = A(i,k);%guardando esse valor, caso exista
      pivot(2) = i;% e a sua linha
    end
  end

  if(abs(pivot(1))<tol) %se o valor absoluto do pivot for inferior ao valor de tolerância
  %quer dizer que essa matriz é singular, retornando com mensagem a informar o mesmo!
    printf("Matriz A singular!")

    x=[];%retorna também a matriz vazia
    return;
  end

    %Verifica se o pivot se encontra na primeira linha verificada
    if(pivot(2) != k) %em caso contrário
      auxA = A(k,:); %troca os valores na matriz
      A(k,:) = A(pivot(2),:); %da linha do pivot
      A(pivot(2),:)=auxA; %com essa linha
      auxb = b(k); %troca o valor no vetor
      b(k) = b(pivot(2)); %da linha do pivot
      b(pivot(2))=auxb; %com essa linha
    end

    m = A(k+1:n,k)./pivot(1); %vetor dos multiplicadores, para cada linha

    %efetua a operação linha(i) = linha(i) - m*linha do pivot para todas as linhas abaixo do pivot
    A(k+1:n,k:n)=A(k+1:n,k:n)-m*A(k,k:n);

    %efetua a operação b(i) = b(i) - m*elemento na linha do pivot para todas as linhas abaixo do pivot
    b(k+1:n) = b(k+1:n)-m*b(k);

end

%Caso o pivot em A(n,n) seja inferior, em valor absoluto, à tolerância, assume-se que a matriz é singular
if(abs(A(n,n))<tol)
  printf("Matriz A singular!");
  x=[];%e retorna o vetor vazio
  return;
end

%Valor de x(n) = b(n) - A(n,n) (Início da substituição inversa)
x(n)=b(n)/A(n,n);

%método de substituição inversa
for(i=n-1:-1:1)

  somatorio=0;%inicializa o valor do somatorio em 0

  for(j=i+1:n)%Somatório de a(i,j) * x(j)
    somatorio = somatorio + A(i,j)*x(j);
  end

  %função xi=(bi-somatorio(n,j=i+1) de aij*xj)/ai,i -> método de substituição inversa
  x(i)=(b(i)-somatorio)/A(i,i);

end

%EOF

