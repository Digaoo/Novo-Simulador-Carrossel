import QtQuick 2.0

Rectangle {

    // Proporcao que baseando-se no tamanho disponível do pai, define o tamanho apropriado da bola.
    property int proporcao:  Math.min(Math.floor(parent.width/170), Math.floor(parent.height/130))
    property bool clicada: false
    property bool mouseOver: false
    property real centroBolaX: x + width/2
    property real centroBolaY: y + height/2

    x:-1
    y:-1
    width: 4.27 * proporcao
    height: width

    id: bolaRetangulo
    color: "#FFA500"
    radius: width/2

    signal clicked

    onClicked: {

        clicada = !clicada;
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
        running: clicada

        NumberAnimation {

            target: bolaRetangulo
            properties: "scale"
            from: 1.0
            to: 1.5
            duration: 500
        }

        NumberAnimation {

            target: bolaRetangulo
            properties: "scale"
            from: 1.5
            to: 1.0
            duration: 500
        }
    }

    function mudaCor() {

        if (mouseOver) {

            color = "#FFC966";
        }

        else {

            color = "#FFA500";
        }
    }

    // Função que dada as coordenadas do mouse e do centro da bola define se o a bola foi clicada.
    function mouseEstaNaBola(xMouse, yMouse, xCentro, yCentro) {

        var distanciaMouseCentro = Math.pow(xCentro - xMouse, 2) + Math.pow(yCentro - yMouse, 2);

        var raioAoQuadrado = Math.pow(Math.min(width, height) / 2, 2);

        var cliqueFoiNaBola = distanciaMouseCentro < raioAoQuadrado;

        return cliqueFoiNaBola;
    }

    function bolaClicada(xMouse, yMouse, xMouseArea, yMouseArea, largMouseArea, altMouseArea) {

        var centroBolaX = x + width/2;
        var centroBolaY = y + height/2;

        // A bola foi clicada ?
        if(mouseEstaNaBola(xMouse, yMouse, centroBolaX, centroBolaY)) {

            // Sim, então avise a ela que foi clicada.
            clicked();
            return;
        }

        // Se a bola não foi clicada mas ela já tiver sido clicada...
        else if (clicada) {

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
