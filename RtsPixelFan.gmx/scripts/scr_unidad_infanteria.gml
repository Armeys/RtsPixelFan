///le da a cada unidad sus propiedades
//argument0 es el tipo de unidad que vamos a crear
switch(argument0)
{
    case "Soldado":
        ancho=26;
        alto=46;
        velMovi = 2;
        vision = 1.2;
        alcance = 15;
        vida = 150;
        vidaTotal = 150;
        damage = 10;
        vel_ataque = 100;
        vel_vuelo = 0;
        sprite_index = spr_char_prueba;
    break;
    case "Arquero":
        ancho=28;
        alto=46;
        velMovi = 2;
        vision = 1.6;
        alcance = 200;
        vida = 100;
        vidaTotal = 100;
        damage = 5;
        vel_ataque = 150;
        vel_vuelo = 5;
        sprite_index = spr_char_arquero;
    break;
}
