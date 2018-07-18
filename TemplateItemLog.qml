import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Page{

    id:pagina

    anchors.fill: parent

    property string tipo: "Padrão"
    property int indice: 0
    property int xAtual: 100
    property int yAtual: 100
    property int vel: 5
    property int tamFig: 40

    property var objetoAssociado: null

    property color corCirculoSuperior: "yellow"
    property color corCirculoInferior: "purple"

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
                color:  "#ffa500"
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
                    color: corCirculoSuperior
                    anchors.left: parent.left
                    anchors.leftMargin: tamFig/20
                    anchors.top: parent.top
                    anchors.topMargin: tamFig/20
                }

                Rectangle {

                    height: tamFig/2
                    width: height
                    radius: width/2
                    color: corCirculoInferior
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
                visible: false
                anchors.centerIn: parent

                RadialGradient {

                    anchors.fill: parent

                    gradient: Gradient {

                        GradientStop { position: 0.0; color: obstaculo.color }
                        GradientStop { position: 0.85; color: "black" }
                    }
                }
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

            onValueChanged: {

                if (objetoAssociado !== null)

                    objetoAssociado.velocidade = value;
            }
        }

        Button {

            text: qsTr("Excluir")
            scale: 0.6
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {

                pagina.parent.indice = indice;
            }
        }
    }
}
