import QtQuick 2.0

TemplateObjetos {

    width: 7.5 * proporcao
    height: width

    corR: 50/255
    corG: 50/255
    corB: 50/255

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
        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
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
        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
    }
}
