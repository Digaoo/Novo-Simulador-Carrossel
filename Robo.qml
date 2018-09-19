import QtQuick 2.0

TemplateObjetos {

    id: robo
    width: 7.5 * proporcao
    height: width

    corR: 50/255
    corG: 50/255
    corB: 50/255

    property color corCirculoSuperior: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
    property color corCirculoInferior: Qt.rgba(Math.random(),Math.random(),Math.random(),1)

    property int maxVel: 7
    property bool mover: false
    property int rodaEsquerda: 6
    property int rodaDireita: 7

    property real mediaRodas: (rodaEsquerda+rodaDireita)/2
    property real distanciaRodas: 7.5

    property real anguloAtual: 0
    property real xAtual: x
    property real yAtual: y

    property real distAngular: (rodaEsquerda - rodaDireita)/2
    property real distX: (mediaRodas)/2*Math.cos(anguloAtual) *proporcao
    property real distY: (mediaRodas)/2*Math.sin(anguloAtual) * proporcao

    // Função que dada as coordenadas do mouse define se o robo foi clicado.
    function mouseEstaNoComponente(xMouse, yMouse) {

        return (xMouse >= x && xMouse <= x + width && yMouse >= y && yMouse <= y + height);
    }

    Rectangle {

        id: circuloSuperior
        anchors.left: parent.left
        anchors.leftMargin: 0.25*proporcao
        anchors.top: parent.top
        anchors.topMargin: 0.25*proporcao
        width: parent.width/2
        height: width
        radius: width/2
        color: corCirculoSuperior
    }

    Rectangle {

        id: circuloInferior
        anchors.right: parent.right
        anchors.rightMargin: 0.25*proporcao
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0.25*proporcao
        width: parent.width/2
        height: width
        radius: width/2
        color: corCirculoInferior
    }

    /*onDistXChanged: {

        console.log(distX)
        console.log(distY)
        console.log(distAngular)
        //simulaMov.start()
    }

    // Animação para mostrar o robo andando ao receber um comando do rádio
    ParallelAnimation {

        id:simulaMov
        loops: 1

        NumberAnimation {

            target: robo
            properties: "x"
            from: xAtual
            to: xAtual + distX
            duration: 1000
        }

        NumberAnimation {

            target: robo
            properties: "y"
            from: yAtual
            to: yAtual + distY
            duration: 1000
        }

        RotationAnimation {

            target: robo;
            from: anguloAtual;
            to: anguloAtual + distAngular;
            duration: 1000
            direction: RotationAnimation.Counterclockwise
        }

        onStopped: {

            anguloAtual+=distAngular
            console.log(anguloAtual)
        }
    }*/
}
