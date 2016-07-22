n = 13;
alfa1 = 0.15;
alfa2 = 0.21;
alfa3 = 5.96;
X(1) = 45; %tamaño 45.000 [mm]
X(2) = 31.5; %tamaño 31.500 [mm]
X(3) = 22.4; %tamaño 22.400 [mm]
X(4) = 16; %tamaño 16.000 [mm]
X(5) = 11.2; %tamaño 11.200 [mm]
X(6) = 8; %tamaño 8.000 [mm]
X(7) = 5.6; %tamaño 5.600 [mm]
X(8) = 2.8; %tamaño 2.800 [mm]
X(9) = 1; %tamaño 1.000 [mm]
X(10) = 0.5; %tamaño 0.500 [mm]
X(11) = 0.315; %tamaño 0.315 [mm]
X(12) = 0.2; %tamaño 0.200 [mm]
X(13) = 0.125; %tamaño 0.125 [mm]
for i=1:n,
    B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3)
end
 for j=1:n,
        suma = 0;
        for i=1:n-1,
            if i>j,
                b(i,j)=B(i-j+1)-B(i-j+2)
                suma = suma + b(i,j);
            else i<=j,
                b(i,j)=0
            end
        end
        suma
        for i=n,
            b(i,j)=1-suma
        end
    end
    for i=n,
        for j=n,
            b(i,j) = 0
        end
    end
