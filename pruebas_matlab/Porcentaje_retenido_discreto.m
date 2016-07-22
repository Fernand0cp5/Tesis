function Salida=Porcentaje_retenido_discreto(Entrada)
fptHPGRu5=Entrada;
%Modelo de Harnero vibratorio propuesto por KARRA, adaptado por A. Casali.
%N° de tamaños de clases:
load('n.mat','n');
load('Xt.mat','Xt');
for i=1:n;
    if i<=n-1;
    faH(i)=fptHPGRu5(i)-fptHPGRu5(i+1);
    else
        faH(i)=fptHPGRu5(i);
    end
end
Salida=[faH];
end