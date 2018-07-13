import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

// Layout em grade que dispõe o campo e elementos auxiliares.
GridLayout {

    id: layoutCampos
    width: parent.width - 10
    height: parent.height - 10
    rows: 2
    columns: 5
    anchors.centerIn: parent

    // Combo box que determina se o campo utilizado será o simulado ou o de um vídeo.
    ComboBox {

        id: selecionadorTipoVisualizacao
        currentIndex: 0
        Layout.columnSpan: 4
        Layout.fillHeight: false
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        model: ["Campo Simulado", "Video de Jogo"]
    }

    // Botão que aplica a funcionalidade escolhida no combo box acima.
    Button {

        id: botaoDefinirVisualizacao
        text: qsTr("Definir")
        focusPolicy: Qt.NoFocus
        Layout.fillWidth: false
        Layout.fillHeight: false
        Layout.preferredWidth: elementosLateralCampo.width
        Layout.columnSpan: 1
        Layout.rowSpan: 1
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
    }

    // O campo e sua área no entorno.
    Campo {

        id: componenteCampo
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.columnSpan: 4

        // A bola.
        Bola{

            id:componenteBola
            x: parent.width/2
            y: parent.height/2
        }

        // Mouse Area sobre o campo que detecta ações sobre os elementos do campo como bola, robôs e obstáculos.
        MouseArea {

            id:componenteMouseCampo

            property int proporcaoMouse: componenteBola.proporcao
            property int mouseXReal: mouseX + x
            property int mouseYReal: mouseY + y

            width: 170*proporcaoMouse - 20*proporcaoMouse
            height: 130*proporcaoMouse
            anchors.centerIn: parent

            hoverEnabled: true

            onClicked: {

                // Chama a função da bola que checa se ela foi clicada e realiza as ações caso tenha sido.
                componenteBola.bolaClicada(mouseXReal, mouseYReal, x, y, width, height);
            }

            onPositionChanged: {

                if (componenteBola.mouseEstaNaBola(mouseXReal,mouseYReal, componenteBola.centroBolaX, componenteBola.centroBolaY)) {

                    componenteBola.mouseOver = true;
                    componenteBola.mudaCor();
                }

                else if (componenteBola.mouseOver === true) {

                    componenteBola.mouseOver = false;
                    componenteBola.mudaCor();
                }
            }
        }
    }

    // Layout à direita do campo.
    ColumnLayout {

        id: elementosLateralCampo
        width: 100
        height: 100
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        Layout.preferredWidth: -1
        spacing: 4
        Layout.fillHeight: true
        Layout.fillWidth: false

        // Este retângulo e seu filho representam uma caixa de logs onde serão disponibilizadas informações sobre os elementos do campo.
        Rectangle {

            border.color: "#000000"
            border.width: 1
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {

                id: displayDados
                text: qsTr("")
                wrapMode: Text.WordWrap
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }

        // Layout dos botões à direita do campo.
        ColumnLayout {

            id: layoutBotoesNovosElementos
            width: parent.width
            height: parent.height/2
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.preferredHeight: parent.height/2
            Layout.fillWidth: true

            // Botão para colocar a bola.
            Button {

                id: botaoNovaBola
                text: qsTr("Nova Bola")
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            // Botão para colocar os robôs.
            Button {

                id: botaoNovoRobo
                text: qsTr("Novo Robô")
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            // Botão para colocar os obstáculos.
            Button {

                id: botaoNovoObstaculo
                text: qsTr("Novo Obstáculo")
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
        }
    }
}
