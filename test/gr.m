syms x y a
p = [a*y + x^2*y + a, a*x^2 + y];
vars = [x y];
grobnerBasis = gbasis(p,vars)


syms x y z
p = [y*z^2 + 1, y^2*x^2 - y - z^3];
grobnerBasis = gbasis(p,'MonomialOrder','lexicographic')';