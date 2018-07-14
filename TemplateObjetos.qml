import QtQuick 2.0

import QtQuick 2.0

Rectangle {

    // Proporcao que baseando-se no tamanho disponível do pai, define o tamanho apropriado do componente.
    property int proporcao:  Math.min(Math.floor(parent.width/170), Math.floor(parent.height/130))
    property bool clicado: false
    property bool mouseOver: false

    property real corR: 0.5
    property real corG: 0.5
    property real corB: 0.5

    x:-1
    y:-1
    //width: 7.5 * proporcao
    //height: width

    id: componenteRetangulo
    color: Qt.rgba(corR,corG,corB, 1)

    signal clicked

    onClicked: {

        clicado = !clicado;
        scale = 1.0;
    }

    Behavior on x {

        NumberAnimation { duration: 500 }
    }

    Behavior on y {

        NumberAnimation { duration: 500 }
    }

    Behavior on color {

        ColorAnimation {}
    }

    SequentialAnimation {

        loops: Animation.Infinite
        running: clicado

        NumberAnimation {

            target: componenteRetangulo
            properties: "scale"
            from: 1.0
            to: 1.5
            duration: 500
        }

        NumberAnimation {

            target: componenteRetangulo
            properties: "scale"
            from: 1.5
            to: 1.0
            duration: 500
        }
    }

    function mudaCor() {

        if (mouseOver) {

            color = Qt.rgba(corR+0.1, corG+0.1, corB+0.1, 1);
        }

        else {

            color = Qt.rgba(corR, corG, corB, 1);
        }
    }

    // Função que dada as coordenadas do mouse define se o robo foi clicado.
    function mouseEstaNoComponente(xMouse, yMouse) {

        console.log("A função mouseEstaNoComponente deve ser implementada")

        return true;
    }

    function componenteClicado(xMouse, yMouse, xMouseArea, yMouseArea, largMouseArea, altMouseArea) {

        // O robo foi clicado ?
        if(mouseEstaNoComponente(xMouse, yMouse)) {

            // Sim, então avise a ele que foi clicado.
            clicked();
            return;
        }

        // Se o robo não foi clicado mas já havia sido clicado...
        else if (clicado) {

            // Reposiciona a bola:
            var ajusteX = 0;
            var ajusteY = 0;

            if (xMouse - width/2 < proporcao + xMouseArea) {

                ajusteX = proporcao + xMouseArea - xMouse + width/2 ;
            }

            else if (xMouse + width/2 > xMouseArea + largMouseArea - proporcao) {

                ajusteX = (xMouseArea + largMouseArea - proporcao) - (xMouse + width/2);
            }

            if (yMouse - height/2 < proporcao + yMouseArea) {

                ajusteY = proporcao + yMouseArea - yMouse + height/2;
            }

            else if (yMouse + height/2 > yMouseArea + altMouseArea - proporcao) {

                ajusteY = (yMouseArea + altMouseArea - proporcao) - (yMouse + height/2);
            }

            x = xMouse - width/2 + ajusteX;
            y = yMouse - height/2 + ajusteY;
            clicked();
        }
    }
}
