      function y=allclass(t)
      % ALLCLASS - Devuelve el vector t ordenado ascendentemente y sin elementos repetidos.
      j=1;
      for i=min(t):max(t),
         indices = find(t==i); %me quedo con los indices del valor determinado
         if length(indices)>0,
            y(j)=t(indices(1));
            j=j+1;      
         end;
      end;

