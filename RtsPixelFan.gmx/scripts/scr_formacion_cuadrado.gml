///scr_formacion_cuadrado(objeto)
//script que realiza la formación en cuadrado de las unidades.

unidad = argument0;
cantidadTypo = 0;
with(obj_infanteria)  
{        
    if(selected)
    {
        if(other.unidad.type == type)  //// cuanta las unidades de este tipo.     
        {    
            other.cantidadTypo++;
            estado = "defensa";
        }          
        
        if(other.primeraUnidad == true)  ///contamos la cantidad de unidades que se van a mover y las posiciones minimas y maximas de la x y la y
        {            
            other.cantidad++;                        
            other.minx = min(other.minx,x);
            other.miny = min(other.miny,y);
            other.maxx = max(other.maxx,x);
            other.maxy = max(other.maxy,y);
        }                                          
    }
}
with(obj_vehiculos)  
{        
    if(selected)
    {
        if(other.unidad.type == type)  //// cuanta las unidades de este tipo.     
        {    
            other.cantidadTypo++;
            estado = "defensa";
        }          
        
        if(other.primeraUnidad == true)  ///contamos la cantidad de unidades que se van a mover y las posiciones minimas y maximas de la x y la y
        {            
            other.cantidad++;                        
            other.minx = min(other.minx,x);
            other.miny = min(other.miny,y);
            other.maxx = max(other.maxx,x);
            other.maxy = max(other.maxy,y);
        }                                          
    }
}
////// Formación Cuadrado 3x3 -- 4x4 -- 5x5 -- ///////
  
//comenzamos dibujando la formacion
if(cantidadTypo > 0)  
{   
    /// calculo del numero de filas
    filas = round(sqrt(cantidad));

    /// calculo del numero de columnas de la unidad    
    if (cantidad >0 && cantidad <=9)    
        columnas = 3;
    else if(cantidad >9 && cantidad <=16)
        columnas = 4;        
    else if(cantidad >16 && cantidad <=25)
        columnas = 5;
    else if(cantidad >25 && cantidad <=36)
        columnas = 6;
    else if(cantidad >36 && cantidad <=49)
        columnas = 7;
    else if(cantidad >49 && cantidad <=64)
        columnas = 8;
    else if(cantidad >64 && cantidad <=81)
        columnas = 9;
    else if(cantidad >81 && cantidad <=100)
        columnas = 10;
    else if(cantidad >100 && cantidad <=121)
        columnas = 11; 
         
    if(cantidadTypo > 3) // formacion para mas de 3 unidades. en cuadrado
    {
        // calculamos x de la unidad de la esquina superior izq en relacion con el raton.       
        if(columnas % 2 == 0)/// si es par ay que restarle media unidad para que se centre con el raton.
            xxStart = mouse_x - ((unidad.ancho)*(floor(columnas/2)-0.5));
        else
            xxStart = mouse_x - ((unidad.ancho)*(floor(columnas/2)));
        xx = xxStart;    //posicion de la primera columna
        // calculamos y de la unidad de la esquina superior izq en relacion con el raton.        
        /// si es el sugundo tipo de unidad solo tenemos que desplazarlas un poco hacia abajo
        if(primeraUnidad == true)
        {            
            if(filas % 2 == 0)
                yy = mouse_y - (unidad.alto * (floor(filas/2)-0.5));
            else
                yy = mouse_y - (unidad.alto * (floor(filas/2)));
        }
        else
        {
            yy = yy + unidad.alto + 10;
        }
    }
    else  // formacion para 3 o menso unidades.
    {
        switch(cantidadTypo)
        {
            case 1:
                xx = mouse_x;
            break;
            case 2:
                xx = mouse_x - (unidad.ancho/2);
            break;
            case 3:
                xx = mouse_x - unidad.ancho;
            break;
        }
        /// si es el sugundo tipo de unidad solo tenemos que desplazarlas un poco hacia abajo
        if(primeraUnidad == true)
        {
            yy = mouse_y;            
        }
        else
        {
            yy = yy + unidad.alto + 10;
        }     
    }        
                   
    contador = 0; 
    if(global.patrullar) // calculamos donde vamos a colocar las banderas. la de inicio en el centro de la pisicion inicial de las unidades
    {                    // la de destino en la posicion del raton. les asignamos la cantidad de unidades q van a hacer esa patrulla.
        banderax = minx + ((maxx - minx)/2);
        banderay = miny + ((maxy - miny)/2);        
        if(primeraUnidad == true)
        {
            banderasalida = instance_create(banderax,banderay,obj_bandera_patrulla);
            banderasalida.cantidad = cantidad;        
            banderadestino = instance_create(mouse_x,mouse_y,obj_bandera_patrulla);
            banderadestino.image_index = 1;
            banderadestino.cantidad = cantidad;            
        }            
    }
    
    with(unidad)
    {    
        if(other.contador == other.columnas && other.cantidad >3)  // cuando coinciden saltamos a la siguiente fila
        {                
            other.yy = other.yy + alto + 7;// +7 para separar las barras de vida.
            other.xx = other.xxStart;
            other.contador = 0;            
        }            
        if(selected)//añadimos el movimiento a la unidad.
        {    
            if(banderadest != 0) //al volver a mover la unidad la restamos de su banderar para poder eliminar las banderas cuando no hay patrullas.
            {                
                with(obj_bandera_patrulla)
                {
                    if(id == other.banderadest)
                    {
                        cantidad--;                            
                        other.banderadest = 0;
                    }
                    if(id == other.banderaorig)
                    {
                        cantidad--;                            
                        other.banderaorig = 0;
                    }
                }
            }            
            patrullar = false;
            movin = true;            
            origx = x;
            origy = y;
            destx = other.xx;
            desty = other.yy;                
            banderadest = other.banderadestino;
            banderaorig = other.banderasalida;                              
            instance_create(other.xx,other.yy,obj_stop);
            other.xx = other.xx + ancho;
            other.contador++; 
            if(global.patrullar)
            {
                patrullar = true;                     
            } 
        }            
    }    
    primeraUnidad = false;    
    minx = 9999;
    maxx = 0;
    miny = 9999;
    maxy = 0;         
}    
