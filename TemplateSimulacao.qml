import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQml 2.0

// Layout em grade que dispõe o campo e elementos auxiliares.
GridLayout {

    id: layoutCampos
    width: parent.width - 10
    height: parent.height - 10
    rows: 2
    columns: 5
    anchors.centerIn: parent

    property var componentes: []

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

        // Mouse Area sobre o campo que detecta ações sobre os elementos do campo como bola, robôs e obstáculos.
        MouseArea {

            id:componenteMouseCampo

            property int proporcaoMouse: componenteCampo.proporcao
            property int mouseXReal: mouseX + x
            property int mouseYReal: mouseY + y

            width: 170*proporcaoMouse - 20*proporcaoMouse
            height: 130*proporcaoMouse
            anchors.centerIn: parent

            hoverEnabled: true

            // Chama a função que checa se o componente foi clicado e realiza as ações caso tenha sido.
            onClicked: {

                for (var i=0; i<componentes.length; i++) {

                    componentes[i].componenteClicado(mouseXReal, mouseYReal, x, y, width, height, containsMouse);
                }
            }

            onPressed: {

                for (var i=0; i<componentes.length; i++) {

                    componentes[i].componentePressionado(mouseXReal, mouseYReal);
                }
            }

            onReleased: {

                for (var i=0; i<componentes.length; i++) {

                    componentes[i].componenteSolto(mouseXReal, mouseYReal, x, y, width, height);
                }
            }

            onPositionChanged: {

                for (var i=0; i<componentes.length; i++) {

                    if (componentes[i].mouseEstaNoComponente(mouseXReal,mouseYReal)) {

                        componentes[i].mouseOver = true;
                        componentes[i].mudaCor();
                    }

                    else if (componentes[i].mouseOver === true) {

                        componentes[i].mouseOver = false;
                        componentes[i].mudaCor();
                    }
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

        Rectangle {

            border.color: "black"
            border.width: 1

            Layout.fillHeight: true
            Layout.fillWidth: true

            StackLayout {

                id: layoutLog
                anchors.fill: parent
                anchors.margins: 1
                currentIndex: 0
            }
        }

        // Layout dos botões à direita do campo.
        ColumnLayout {

            id: layoutBotoesNovosElementos
            width: parent.width
            height: parent.height/2
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.preferredHeight: parent.height/2
            Layout.maximumHeight: parent.height/2
            Layout.fillWidth: true

            // Botão para colocar a bola.
            Button {

                id: botaoNovaBola
                text: qsTr("Nova Bola")
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                onClicked: {

                    var novaBola = Qt.createComponent("Bola.qml");

                    var x = componenteCampo.xAleatorioCampo(4.75*componenteCampo.proporcao);
                    var y = componenteCampo.yAleatorioCampo(4.75*componenteCampo.proporcao);

                    componentes.push(novaBola.createObject(componenteCampo, {"x":x, "y":y}));

                    botaoNovaBola.enabled = false;
                }
            }

            // Botão para colocar os robôs.
            Button {

                id: botaoNovoRobo
                text: qsTr("Novo Robô")
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                onClicked: {

                    var novoRobo = Qt.createComponent("Robo.qml");

                    var x = componenteCampo.xAleatorioCampo(7.5*componenteCampo.proporcao);
                    var y = componenteCampo.yAleatorioCampo(7.5*componenteCampo.proporcao);

                    componentes.push(novoRobo.createObject(componenteCampo, {"x":x, "y":y}));
                }
            }

            // Botão para colocar os obstáculos.
            Button {

                id: botaoNovoObstaculo
                text: qsTr("Novo Obstáculo")
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                onClicked: {

                    var novoObst = Qt.createComponent("Obstaculo.qml");

                    var x = componenteCampo.xAleatorioCampo(3*componenteCampo.proporcao);
                    var y = componenteCampo.yAleatorioCampo(3*componenteCampo.proporcao);

                    componentes.push(novoObst.createObject(componenteCampo, {"x":x, "y":y}));
                }
            }
        }
    }
}
