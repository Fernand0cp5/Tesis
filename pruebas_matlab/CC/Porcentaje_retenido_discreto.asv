function Salida=Porcentaje_retenido_discreto(Entrada)
fptHPGRu1=Entrada;
%Modelo de Harnero vibratorio propuesto por KARRA, adaptado por A. Casali.
%N° de tamaños de clases:
n=13;
Xt=[45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
for i=1:n;
    if i<=n-1;
    faH(i)=fptHPGRu1(i)-fptHPGRu1(i+1);
    else
        faH(i)=fptHPGRu1(i);
    end
end
Salida=[faH];
end