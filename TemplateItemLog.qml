import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

Page{

    width: parent.width
    height: elementos.height

    property string tipo: "Padrão"
    property int indice: 0
    property int xAtual: 100
    property int yAtual: 100
    property int vel: 5
    property int tamFig: 40

    onTipoChanged: {

        if (tipo === "Bola") {

            bola.visible = true;
            padrao.visible = false;
        }

        else if (tipo === "Robo") {

            robo.visible = true;
            padrao.visible = false;
        }

        else if (tipo === "Obstaculo") {

            obstaculo.visible = true;
            padrao.visible = false;
        }

        else {

            bola.visible = false;
            robo.visible = false;
            obstaculo.visible = false;
            padrao.visible = true;
        }
    }

    header: Label {

        text: qsTr('<b>'+tipo+' ('+indice+')</b>')
        font.pixelSize: 12
        padding: 10
        color: "white"

        background: Rectangle {
            color: "#2A2A2A"
        }
    }

    ColumnLayout {

        id: elementos
        width: parent.width
        height: children.height
        anchors.centerIn: parent

        Item {

            id: figura
            width: parent.width
            height: tamFig+10
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {

                id: bola
                height: tamFig
                width: height
                radius: width/2
                color: "#ffa500"
                visible: false
                anchors.centerIn: parent
            }

            Rectangle {

                id: robo
                height: tamFig
                width: height
                color: "#333333"
                visible: false
                anchors.centerIn: parent

                Rectangle {

                    height: tamFig/2
                    width: height
                    radius: width/2
                    color: "yellow"
                    anchors.left: parent.left
                    anchors.leftMargin: tamFig/20
                    anchors.top: parent.top
                    anchors.topMargin: tamFig/20
                }

                Rectangle {

                    height: tamFig/2
                    width: height
                    radius: width/2
                    color: "purple"
                    anchors.right: parent.right
                    anchors.rightMargin: tamFig/20
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: tamFig/20
                }
            }

            Rectangle {

                id: obstaculo
                height: tamFig
                width: height
                color: "#8b4513"
                border.color: "black"
                border.width: 1
                visible: false
                anchors.centerIn: parent
            }

            Image {

                id: padrao
                width: tamFig
                fillMode: Image.PreserveAspectFit
                source: "pontoInt.png"
                visible: true
                anchors.centerIn: parent
            }
        }

        Label {

            id:labelCoords
            font.pointSize:10
            text: '<b>Coordenadas:</b>'
            anchors.horizontalCenter: parent.horizontalCenter
            padding: 10

        }

        Text {

            id:valorXY
            font.pointSize:10
            text: '<b>('+xAtual+', '+yAtual+')</b>'
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {

            id: labelVel
            font.pointSize:10
            text: '<b>Velocidade:</b>'
            anchors.horizontalCenter: parent.horizontalCenter
            padding: 10
        }

        SpinBox {

            value: vel
            scale: 0.6
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    footer: RowLayout {

        width: parent.width
        height: children.height
        spacing: 0

        Button {

            id: botaoAnterior
            Layout.maximumWidth: parent.width/2
            Layout.maximumHeight: font.pointSize*2
            text: qsTr("<b>◀</b>")
            anchors.margins: 1
        }

        Button {

            id: botaoProximo
            Layout.maximumWidth: parent.width/2
            Layout.maximumHeight: font.pointSize*2
            text: qsTr("<b>▶</b>")
            anchors.margins: 1
        }
    }
}


