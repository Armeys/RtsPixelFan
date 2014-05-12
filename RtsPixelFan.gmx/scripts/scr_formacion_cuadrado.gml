///scr_formacion_cuadrado(objeto)
//script que realiza la formación en cuadrado de las unidades.

unidad = argument0;
cantidadTypo = 0;
with(unidad)  
{        
    if(selected)
    {
        if(other.type == type)  //// cuanta las unidades de este tipo.     
        {    
            other.cantidadTypo++;
        }          
        
        if(other.primeraUnidad == true)  ///contamos la cantidad de unidades que se van a mover y las posiciones minimas y maximas de la x y la y
        {                       
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
         
    if(primeraUnidad == true)
    {
        if(minx + ((maxx - minx)/2) > mouse_x)
            if(miny + ((maxy - miny)/2) > mouse_y )
                direccionMovimiento = 1;
            else
                direccionMovimiento = 3;
        else
            if(miny + ((maxy - miny)/2) > mouse_y )
                direccionMovimiento = 2;
            else
                direccionMovimiento = 4;
    }
    
    if(cantidadTypo > 3) // formacion para mas de 3 unidades. en cuadrado
    {
        if(primeraUnidad == true)
        { 
            switch(other.direccionMovimiento)
            {            
                case 1:
                    xxStart = mouse_x - (64 *((columnas-1)));
                    xx = xxStart;
                    yyStart = mouse_y;                    
                    yy = yyStart;
                break;
                case 2:
                    xxStart = mouse_x;
                    xx = xxStart;
                    yyStart = mouse_y -(32 *((columnas-1)));                    
                    yy = yyStart;              
                break;
                case 3:
                    xxStart = mouse_x - (64 *((columnas-1)));
                    xx = xxStart;
                    yyStart = mouse_y;                    
                    yy = yyStart;                
                break;
                case 4:
                    xxStart = mouse_x;
                    xx = xxStart;
                    yyStart = mouse_y +(32 *((columnas-1)));                    
                    yy = yyStart;                    
                break;
            }
        }
        else
        {   
            if(fila < ceil(cantidadAnterior/columnas))
            {    
                filaActual = filaActual +1;
                switch(other.direccionMovimiento)
                {            
                    case 1:
                        yy = yyStart + (32 * filaActual);
                    break;
                    case 2:
                        yy = yyStart + (32 * filaActual);                        
                    break;
                    case 3:
                        yy = yyStart - (32 * filaActual);
                    break;
                    case 4:
                        yy = yyStart - (32 * filaActual);
                    break;
                }
                fila = 0;                               
            }
            else
            {
                fila = 0;
            }
            switch(other.direccionMovimiento)
            {            
                case 1:
                    xx = xxStart + (64 * filaActual);                    
                break;
                case 2:
                    xx = xxStart - (64 * filaActual);                    
                break;
                case 3:
                    xx = xxStart + (64 * filaActual);
                break;
                case 4:
                    xx = xxStart - (64 * filaActual);
                break;
            }
        }
    }
    else  // formacion para 3 o menso unidades.
    {
        if(primeraUnidad == true)
        {
            switch(cantidadTypo)
            {
                case 1:
                    xx = mouse_x;
                    yy = mouse_y;                
                break;
                case 2:
                    xx = mouse_x - 32;
                    yy = mouse_y;
                break;
                case 3:
                    xx = mouse_x - 64;
                    switch(other.direccionMovimiento)
                    {
                        case 1:
                        case 4:
                            yy = mouse_y + 32;
                        break;
                        case 2:
                        case 3:
                            yy = mouse_y - 32;
                        break;
                    }
                break;
            }
            /// si es el sugundo tipo de unidad solo tenemos que desplazarlas un poco hacia abajo
            xxStart = xx;
            yyStart = yy;            
        }
        else
        {
            if(fila < ceil(cantidadAnterior/columnas))
            {     
                filaActual = filaActual + 1;
                switch(other.direccionMovimiento)
                {            
                    case 1:
                        yy = yyStart + (32 * filaActual);
                    break;
                    case 2:
                        yy = yyStart + (32 * filaActual);                        
                    break;
                    case 3:
                        yy = yyStart - (32 * filaActual);
                    break;
                    case 4:
                        yy = yyStart - (32 * filaActual);
                    break;
                }
                fila = 0;                
            }
            else
            {
                fila = 0;
            }
            switch(other.direccionMovimiento)
            {            
                case 1:
                    xx = xxStart + (64 * filaActual);                    
                break;
                case 2:
                    xx = xxStart - (64 * filaActual);                    
                break;
                case 3:
                    xx = xxStart + (64 * filaActual);
                break;
                case 4:
                    xx = xxStart - (64 * filaActual);
                break;
            }
        }     
    }        
                  
    contador = 0;     
    cantidadAnterior = cantidadTypo;
        
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
    actual = 0;
    with(unidad)
    {    
        while(tile_layer_find(1000,other.xx,other.yy) == -1)
        {
            if(room_width/2 < other.xx)
            {
                other.xx = other.xx - 64;
            }
            else            
            {
                other.xx = other.xx + 64;
            }
            if(room_height/2 < other.yy)
            {
                other.yy = other.yy -32;
            }
            else
            {
                other.yy = other.yy +32
            }                    
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
            objetivo = 0;                              
            instance_create(other.xx,other.yy,obj_stop);            
            switch(other.direccionMovimiento)
            {            
                case 1:
                case 4:
                    other.xx = other.xx + (64);            
                    other.yy = other.yy - (32);
                break;
                case 2:
                case 3:
                    other.xx = other.xx + (64);            
                    other.yy = other.yy + (32);
                break;
                
            }            
            other.contador++;
            other.actual++; 
            if(global.patrullar)
            {
                patrullar = true;                     
            } 
        }
        if(other.contador == other.columnas && other.cantidad >3 && other.cantidadTypo > other.actual)  // cuando coinciden saltamos a la siguiente fila
        {                
            other.fila = other.fila +1;
            other.filaActual = other.filaActual +1;
            switch(other.direccionMovimiento)
            {            
                case 1:
                    other.yy = other.yyStart + 32 * other.filaActual;
                    other.xx = other.xxStart + 64 * other.filaActual;
                break;
                case 2:
                    other.yy = other.yyStart + 32 * other.filaActual;
                    other.xx = other.xxStart - 64 * other.filaActual;
                break;
                case 3:
                    other.yy = other.yyStart - 32 * other.filaActual;
                    other.xx = other.xxStart + 64 * other.filaActual;
                break;
                case 4:
                    other.yy = other.yyStart - 32 * other.filaActual;
                    other.xx = other.xxStart - 64 * other.filaActual;
                break;
            }
            other.contador = 0;                        
        }              
    }        
    primeraUnidad = false;    
    minx = 9999;
    maxx = 0;
    miny = 9999;
    maxy = 0;         
}    
