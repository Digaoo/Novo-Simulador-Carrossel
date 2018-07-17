import QtQuick 2.0

TemplateObjetos {

    property real centroBolaX: x + width/2
    property real centroBolaY: y + height/2

    width: 4.27 * proporcao
    height: width
    radius: width/2

    corR: 255/255
    corG: 165/255
    corB: 0/255

    function mouseEstaNoComponente(xMouse, yMouse) {

        var distanciaMouseCentro = Math.pow(centroBolaX - xMouse, 2) + Math.pow(centroBolaY - yMouse, 2);

        var raioAoQuadrado = Math.pow(Math.min(width, height) / 2, 2);

        var cliqueFoiNaBola = distanciaMouseCentro < raioAoQuadrado;

        return cliqueFoiNaBola;
    }
}
