function [f,g] = softmax_regression(theta, X,y)
  %
  % Arguments:
  %   theta - A vector containing the parameter values to optimize.
  %       In minFunc, theta is reshaped to a long vector.  So we need to
  %       resize it to an n-by-(num_classes-1) matrix.
  %       Recall that we assume theta(:,num_classes) = 0.
  %
  %   X - The examples stored in a matrix.  
  %       X(i,j) is the i'th coordinate of the j'th example.
  %   y - The label for each example.  y(j) is the j'th example's label.
  %
  m=size(X,2);
  n=size(X,1);

  % theta is a vector;  need to reshape to n x num_classes.
  theta=reshape(theta, n, []);
  num_classes=size(theta,2)+1;
  
  % initialize objective value and gradient.
  f = 0;
  g = zeros(size(theta));

  %
  % TODO:  Compute the softmax objective function and gradient using vectorized code.
  %        Store the objective function value in 'f', and the gradient in 'g'.
  %        Before returning g, make sure you form it back into a vector with g=g(:);
  %
%%% YOUR CODE HERE %%%
      h = theta'*X;
      % h is a k*m matrix, k labels, m samples
      s = exp(h);
      p = bsxfun(@rdivide,s,sum(s));
      % sum(s) is a row vector, while sum(s,2) is a column vector
      % need the total sum of each colume, (i'th element)
      % p:k*m
      c = log(p);
      for i = 1:m
          for k=1:num_classes-1
              if y(i) ~= k
                  continue;
              end
              f = f+c(k,i);
          end
      end
      f = -f;
      
%       flag = 0
%       for k=1:num_classes-1
%           for i=1:m-1
%               if y(i)~=k
%                   flag = 0
%               else
%                   flag = 1
%               end
%               g(:,k)= g(:,k) + X(:,i)'*(p(k,i)-flag);
%           end
%       end
%       i = sub2ind(size(c),y',1:size(c,2));
%       values = c(i);
%       f = f-(1/m)*sum(values)+ lambda/2 * sum(theta(:) .^ 2);
%       d = full(sparse(1:m,y,1));
%       g = (1/m)*X*(p'-d)+ lambda * theta;

  a = exp(h);  
  a = [a;ones(1,size(a,2))]; 
  b = sum(a,1);
  flag=0;  
  for j=1:num_classes-1  
    for i=1:m  
      if (y(i)==j)  
        flag =1;  
      else   
        flag=0;  
      end  
      g(:,j)=g(:,j) + X(:,i)*(a(j,i)/b(i)-flag);  
    end  
  end 
  
  g=g(:); % make gradient a vector for minFunc

