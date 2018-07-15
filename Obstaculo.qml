import QtQuick 2.0

TemplateObjetos {

    width: 3 * proporcao
    height: width

    corR: 139/255
    corG: 69/255
    corB: 19/255

    // Função que dada as coordenadas do mouse define se o robo foi clicado.
    function mouseEstaNoComponente(xMouse, yMouse) {

        return (xMouse >= x && xMouse <= x + width && yMouse >= y && yMouse <= y + height);
    }

    function componenteSolto (xMouse, yMouse, xMouseArea, yMouseArea, largMouseArea, altMouseArea) {

        if (pressionado && (xMouse !== xPress || yMouse !== yPress) && !clicado) {

            pressed();

            var yFinal;

            if (yMouse >= yMouseArea + altMouseArea) {

                yFinal = yMouseArea + altMouseArea - proporcao;
            }

            else if (yMouse <= yMouseArea) {

                yFinal = yMouseArea + 2*proporcao;
            }

            else {

                yFinal = yMouse;
            }

            if (yFinal > y) {

                height = yFinal - y;
            }

            else {

                height = y - yFinal;
                y = yFinal - proporcao;
            }

            return;
        }
    }
}
