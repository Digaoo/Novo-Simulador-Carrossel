import QtQuick 2.0

import QtQuick 2.0

Rectangle {

    // Proporcao que baseando-se no tamanho disponível do pai, define o tamanho apropriado do componente.
    property int proporcao:  Math.min(Math.floor(parent.width/170), Math.floor(parent.height/130))

    // Booleanos que indicam situações
    property bool clicado: false
    property bool mouseOver: false
    property bool reposicionado: false
    property bool pressionado: false

    // Variáveis que compõem a cor do componente
    property real corR: 0.5
    property real corG: 0.5
    property real corB: 0.5

    // Variáveis que guardam o x e y do componente caso ele seja pressionado
    property int xPress: -1
    property int yPress: -1

    // Variáveis que guardam o x e y do componente caso ele seja pressionado e depois solto
    property int xRelease: -1
    property int yRelease: -1

    property real distanciaPressRelease: Math.sqrt(Math.pow(xRelease - xPress ,2) + Math.pow(yRelease - yPress,2))

    // Velocidade do robo
    property int velocidade: 50

    x:-1
    y:-1

    id: componenteRetangulo
    color: Qt.rgba(corR,corG,corB, 1)

    signal clicked
    signal pressed
    signal released

    onPressed: {

        pressionado = !pressionado;
    }

    onClicked: {

        clicado = !clicado;
        scale = 1.0;
    }

    // Comportamento padrão para mudança de cor
    Behavior on color {

        ColorAnimation {}
    }

    // Animação para mostrar que o componente foi selecionado
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

    // Animação para movimentar o robo caso ele seja arrastado
    ParallelAnimation {

        id: movimento
        loops: 1

        NumberAnimation {

            target: componenteRetangulo
            properties: "x"
            from: xPress
            to: xRelease
            duration: (distanciaPressRelease / velocidade) * 1000
        }

        NumberAnimation {

            target: componenteRetangulo
            properties: "y"
            from: yPress
            to: yRelease
            duration: (distanciaPressRelease / velocidade)*1000
        }


    }

    // Função que torna a cor do componente mais clara caso o mouse esteja sobre ele
    function mudaCor() {

        if (mouseOver  || reposicionado) {

            color = Qt.rgba(corR+0.1, corG+0.1, corB+0.1, 1);
            reposicionado = false;
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

    function ajustaCoordenadasX(xMouse, xMouseArea, largMouseArea) {

        var ajusteX = 0;

        if (xMouse - width/2 < proporcao + xMouseArea) {

            ajusteX = proporcao + xMouseArea - xMouse + width/2 ;
        }

        else if (xMouse + width/2 > xMouseArea + largMouseArea - proporcao) {

            ajusteX = (xMouseArea + largMouseArea - proporcao) - (xMouse + width/2);
        }

        return ajusteX;
    }

    function ajustaCoordenadasY(yMouse, yMouseArea, altMouseArea) {

        var ajusteY = 0;

        if (yMouse - height/2 < proporcao + yMouseArea) {

            ajusteY = proporcao + yMouseArea - yMouse + height/2;
        }

        else if (yMouse + height/2 > yMouseArea + altMouseArea - proporcao) {

            ajusteY = (yMouseArea + altMouseArea - proporcao) - (yMouse + height/2);
        }

        return ajusteY;
    }

    // Função que cuida dos cliques no componente
    function componenteClicado(xMouse, yMouse, xMouseArea, yMouseArea, largMouseArea, altMouseArea) {

        // O componente foi clicado ?
        if(mouseEstaNoComponente(xMouse, yMouse)) {

            // Sim, então avise a ele que foi clicado.
            clicked();
            return;
        }

        // Se o componente já havia sido clicado, reposicione respeitando os limites do campo
        else if (clicado) {

            // Reposiciona a bola:
            var ajusteX = ajustaCoordenadasX(xMouse, xMouseArea, largMouseArea);
            var ajusteY = ajustaCoordenadasY(yMouse, yMouseArea, altMouseArea);

            x = xMouse - width/2 + ajusteX;
            y = yMouse - height/2 + ajusteY;

            reposicionado=true;

            mudaCor();
            clicked();
            pressed();
        }
    }

    function componentePressionado(xMouse, yMouse) {

        if(mouseEstaNoComponente(xMouse, yMouse)) {

            xPress = x;
            yPress = y;
            pressed();
            return;
        }
    }

    function componenteSolto (xMouse, yMouse, xMouseArea, yMouseArea, largMouseArea, altMouseArea) {

        if (pressionado && (xMouse !== xPress || yMouse !== yPress) && !clicado) {

            xRelease = xMouse - width/2 + ajustaCoordenadasX(xMouse, xMouseArea, largMouseArea);
            yRelease = yMouse - height/2 + ajustaCoordenadasY(yMouse, yMouseArea, altMouseArea);

            componenteArrastado();

            pressed();
            return;
        }
    }

    function componenteArrastado() {

        movimento.start();
    }
}
