import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

Rectangle {

    border.color: "black"
    border.width: 1
    height: elementos.height

    property string tipo: "Padrão"
    property int indice: 0
    property int xAtual: 100
    property int yAtual: 100
    property int vel: 5

    anchors.topMargin: 1
    anchors.leftMargin: 1
    anchors.rightMargin: 1

    Column {

        id: elementos
        anchors.centerIn: parent
        width: parent.width

        Text {

            id: texto1
            font.pointSize: 10
            text: '<b>'+ tipo + ' ' + '(' + indice + ')' +'</b>'
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {

            width: parent.width
            height: 15
        }

        RowLayout {

            Layout.fillWidth: true

            Text {

                id:texto2
                font.pointSize:10
                text: '<b>X:</b> ' + xAtual
                Layout.fillWidth: true
            }

            Text {

                id:texto3
                font.pointSize:10
                text: '<b>Y:</b> ' + yAtual
                Layout.fillWidth: true
            }

        }

        RowLayout {

            id: linha

            Text {

                id: texto4
                font.pointSize:10
                text: '<b>Vel:</b> '
                anchors.verticalCenter: parent.verticalCenter
            }

            SpinBox {

                value: vel
                scale: 0.5
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

}

