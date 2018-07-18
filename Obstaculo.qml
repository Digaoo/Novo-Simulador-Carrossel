import QtQuick 2.0
import QtGraphicalEffects 1.0

TemplateObjetos {

    id: obstaculo
    width: 3 * proporcao
    height: width

    corR: 139/255
    corG: 69/255
    corB: 19/255

    RadialGradient {

        anchors.fill: parent

        gradient: Gradient {

            GradientStop { position: 0.0; color: obstaculo.color }
            GradientStop { position: 0.85; color: "black" }
        }
    }

    // Função que dada as coordenadas do mouse define se o robo foi clicado.
    function mouseEstaNoComponente(xMouse, yMouse) {

        return (xMouse >= x && xMouse <= x + width && yMouse >= y && yMouse <= y + height);
    }

    function componenteSolto (xMouse, yMouse, xMouseArea, yMouseArea, largMouseArea, altMouseArea) {

        if (pressionado && (xMouse !== xPress || yMouse !== yPress) && !clicado) {

            pressed();

            var xFinal;
            var yFinal;

            if (xMouse >= xMouseArea + largMouseArea) {

                xFinal = xMouseArea + largMouseArea - proporcao;
            }

            else if (xMouse <= xMouseArea) {

                xFinal = xMouseArea + 2*proporcao;
            }

            else {

                xFinal = xMouse;
            }

            if (xFinal > x) {

                width = xFinal - x;
            }

            else {

                width = x - xFinal;
                x = xFinal - proporcao;
            }

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

            if(height < 3*proporcao) {

                height = 3*proporcao;
            }

            if (width < 3*proporcao) {

                width = 3*proporcao;
            }

            return;
        }
    }
}
