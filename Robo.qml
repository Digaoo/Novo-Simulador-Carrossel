import QtQuick 2.0

Rectangle {

    // Proporcao que baseando-se no tamanho disponível do pai, define o tamanho apropriado da bola.
    property int proporcao:  Math.min(Math.floor(parent.width/170), Math.floor(parent.height/130))
    property bool clicado: false
    property bool mouseOver: false

    x:-1
    y:-1
    width: 7.5 * proporcao
    height: width

    id: roboRetangulo
    color: "#333333"

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

            target: roboRetangulo
            properties: "scale"
            from: 1.0
            to: 1.5
            duration: 500
        }

        NumberAnimation {

            target: roboRetangulo
            properties: "scale"
            from: 1.5
            to: 1.0
            duration: 500
        }
    }

    function mudaCor() {

        if (mouseOver) {

            color = "#555555";
        }

        else {

            color = "333333";
        }
    }

    // Função que dada as coordenadas do mouse define se o robo foi clicado.
    function mouseEstaNoRobo(xMouse, yMouse) {

        return (xMouse >= x && xMouse <= x + width && yMouse >= y && yMouse <= y + height);
    }

    function roboClicado(xMouse, yMouse, xMouseArea, yMouseArea, largMouseArea, altMouseArea) {

        // O robo foi clicado ?
        if(mouseEstaNoRobo(xMouse, yMouse)) {

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

    Rectangle {

        id: circuloSuperior
        anchors.left: roboRetangulo.left
        anchors.leftMargin: 0.25*proporcao
        anchors.top: roboRetangulo.top
        anchors.topMargin: 0.25*proporcao
        width: parent.width/2
        height: width
        radius: width/2
        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
    }

    Rectangle {

        id: circuloInferior
        anchors.right: roboRetangulo.right
        anchors.rightMargin: 0.25*proporcao
        anchors.bottom: roboRetangulo.bottom
        anchors.bottomMargin: 0.25*proporcao
        width: parent.width/2
        height: width
        radius: width/2
        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
    }
}
