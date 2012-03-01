% gets a given complex central moment value
function muv = complexmoment(Image,u,v)

     [r,c] = find(Image>0);     % get (r,c) of region's pixels
     rbar = mean(r);            % get centre row of where there's stuff
     cbar = mean(c);            % get centre col of where there's stuff
     n = length(r);             % get number of pixels over 0
     momlist = zeros(n,1);      % initialise list with space for value relating to each non zero pixel
     for i = 1 : n                              
       c1 = complex(r(i) - rbar,c(i) - cbar);   
       c2 = complex(r(i) - rbar,cbar - c(i));
       momlist(i) = c1^u * c2^v * Image(r(i),c(i));
     end
     muv = sum(momlist);
