function[L,U,cb]=slu(A,b) %Square LU factorization 과 row exchange를 통한 b값을 반환하는 함수입니다. 
[n,n]=size(A); tol=1.e-6; %A 행렬의 크기를 나타내는 변수를 n으로 나타내고, 0과 근사한 tol이라는 변수 지정합니다.
for i=1:n % 1x3 행렬 cb(changed b) 정의 후 b값을 그대로 복사합니다. 
    cb(i)=b(i); %각 행마다 복사
end
for k=1:n %첫번째 column부터 마지막 pivot을 정하고 이용하여 L, U 행렬을 구하는 for문입니다.
    L(k,k)=1;%L행렬의 대각선은 모두 1입니다.
    for i=k+1:n %피벗이 0일 경우 row exchange하는 for문입니다.
        if abs(A(k,k))<tol %만일 A(k,k)값의 절대값이 0일경우,
           temp=A(k,:);
           A(k,:)=A(i,:);
           A(i,:)=temp; %i행과 k행을 서로 바꿉니다.
           tempcb=cb(k);
           cb(k)=cb(i);
           cb(i)=tempcb; %마찬가지로 cb도 동시에 i행과 k행을 서로 바꿔줍니다.
        end
    end
    if A(k,k)==0 %모든 pivot이 0일 경우 해를 구할 수 없으므로 함수를 종료합니다.
       fprintf("모든 pivot이 0입니다\n"); %pivot이 모두 0이라는 문구를 출력합니다.
       break; %for문을 탈출함으로써 함수를 종료합니다.
    end
    for i=k+1:n %row exchange된 A에 Elimination하여 L과 U를 구하는 for문입니다.
        L(i,k)=A(i,k)/A(k,k);  % k열 pivot에 대한 i열의 multiplier를 L(i,k)에 넣어줍니다.
        A(i,k)=0; %A(i,k)에 0을 넣어줍니다.
        for j=k+1:n%A에 대한 Elimination을 하는 작업입니다.
            A(i,j)=A(i,j)-L(i,k)*A(k,j);%각 행마다 pivot과 multiplier를 이용하여 Elimination 합니다.
        end
    end
    for j=k:n
        U(k,j)=A(k,j); %A행렬의 k행에 대한 Elimination이 끝나면 그 행을 U에 그대로 복사합니다.
    end
end
cb=cb' %cb가 1x3행렬이므로 3x1행렬로 전치시켜줍니다.
end
