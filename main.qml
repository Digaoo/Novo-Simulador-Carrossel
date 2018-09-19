import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

// Janela da aplicação.
ApplicationWindow {
    id: applicationWindow

    visible: true
    visibility: ApplicationWindow.Maximized
    title: "Carrossel Caipira"
    minimumWidth: 800
    minimumHeight: 600

    // Layout de páginas controlado pelas abas.
    StackLayout {

        id: layoutPrincipal
        anchors.fill: parent
        currentIndex: abas.currentIndex

        // Página do Home.
        Page{

            header: Label {

                text: qsTr("Home")
                font.pixelSize: Qt.application.font.pixelSize * 2
                padding: 10
                color: "white"

                background: Rectangle {
                    color: "#2A2A2A"
                }
            }
        }

        // Página do Controle.
        Page{

            width: parent.width
            height: parent.height

            ColumnLayout {

                width: parent.width
                height: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: true

                TemplateSimulacao {


                    Layout.fillWidth: true
                    Layout.topMargin: 5
                    Layout.rightMargin: 10
                    Layout.leftMargin: 10
                }

                TemplateControle {

                    id: paramControle
                    Layout.fillWidth: true
                    Layout.topMargin: 5
                    Layout.rightMargin: 10
                    Layout.leftMargin: 10
                    Layout.bottomMargin: 5
                }
            }
        }

        // Página da Estratégia.
        Page{

            header: Label {

                text: qsTr("Estratégia")
                font.pixelSize: Qt.application.font.pixelSize * 2
                padding: 10
                color: "white"

                background: Rectangle {
                    color: "#2A2A2A"
                }
            }
        }
    }

    // Abas que controlam o layout de página.
    footer: TabBar {

        id: abas
        currentIndex: layoutPrincipal.currentIndex

        // Botão Home
        TabButton {

            id: homeBotao
            anchors.verticalCenter: parent.verticalCenter

            Image {

                id: homeImage
                height: parent.height/1.5
                anchors.rightMargin: 6
                anchors.right: homeText.left
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                source: "home.png"
            }

            Text {
                id: homeText
                text: qsTr("Home")
                anchors.left: homeImage.right
                anchors.centerIn: parent
            }
        }

        // Botão Controle.
        TabButton {

            id: controleBotao
            anchors.verticalCenter: parent.verticalCenter

            Image {

                id: controleImage
                height: parent.height/1.5
                anchors.rightMargin: 6
                anchors.right: controleText.left
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                source: "controle.png"
            }

            Text {
                id: controleText
                text: qsTr("Controle")
                anchors.left: controleImage.right
                anchors.centerIn: parent
            }
        }

        // Botão Estratégia.
        TabButton {

            id: estrategiaBotao
            anchors.verticalCenter: parent.verticalCenter

            Image {

                id: estrategiaImage
                height: parent.height/1.5
                anchors.rightMargin: 6
                anchors.right: estrategiaText.left
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                source: "estrategia.png"
            }

            Text {
                id: estrategiaText
                text: qsTr("Estratégia")
                anchors.left: estrategiaImage.right
                anchors.centerIn: parent
            }
        }

    }


}
