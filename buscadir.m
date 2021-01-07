function buscadir
%ira buscando en cada directorio desde el directorio anterior
%tira hacia un punto comun desde donde comenzar busqueda
r=dir;
%r(1).name sera un punto
%r(2).name seran dos puntos
%buscare a partir de r(3)!!!

R=length(r);
OK=0;
L=length('PROYECTO_DCP');

    while OK==0
      for k=3:R
         LON=length(r(k).name);
         if LON>L
            v=r(k).name(1:L);
         else
             v=[r(k).name zeros(1,L-LON)];
         end
        %si encuentro el directorio salgo
            if v=='PROYECTO_DCP'
                     OK=1;
                     cd PROYECTO_DCP
                     break;
            else
                if k==R
                    cd .. %directorio anterior
                    k=3;
                    %nuevo directorio con nuevos directorios y archivos
                    r=dir;
                    R=length(r); 
                end
           end
      end
     end
        %si llego al final del directorio y no encuentro el que busco salto
        %arriba y vuelvo a empezar en el nuevo directorio
   cd DATOS_PACIENTES     
 