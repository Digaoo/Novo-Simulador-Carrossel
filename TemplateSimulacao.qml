import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQml 2.0

// Layout em grade que dispõe o campo e elementos auxiliares.
GridLayout {

    id: layoutCampos
    width: parent.width
    height: parent.height
    rows: 2
    columns: 5

    property var componentes: []
    property var logs: []

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

            // Chama a função que checa se o componente foi pressionado e realiza as ações caso tenha sido.
            onPressed: {

                for (var i=0; i<componentes.length; i++) {

                    componentes[i].componentePressionado(mouseXReal, mouseYReal);
                }
            }

            // Chama a função que checa se o componente foi solto e realiza as ações caso tenha sido.
            onReleased: {

                for (var i=0; i<componentes.length; i++) {

                    componentes[i].componenteSolto(mouseXReal, mouseYReal, x, y, width, height);
                }
            }

            // Chama a função quando o mouse é movido, para checar se o mouse está sobre o objeto.
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

                y:1
                id: layoutLog
                width: parent.width - 2
                height: parent.height - mudaLogs.height
                anchors.horizontalCenter: parent.horizontalCenter
                currentIndex: 0

                property int numPag: 0

                //Quando esta propriedade é modificada o objeto e seu log do indice passado serão excluídos.
                property int indice: -1

                onIndiceChanged: {

                    if (indice === -1) {

                        return;
                    }

                    componentes[indice].destroy();
                    componentes.splice(indice,1);

                    if (logs[indice].tipo === "Bola") {

                        botaoNovaBola.enabled = true;
                    }

                    else if (logs[indice].tipo === "Robo") {

                        botaoNovoRobo.enabled = true;
                    }

                    logs[indice].destroy();
                    logs.splice(indice,1);

                    for (var i=indice; i < logs.length; i++) {

                        logs[i].indice -=1;
                    }

                    indice = -1;
                }

                onCountChanged: {

                    if (count > numPag) {

                        if (count > 1) {

                            botaoProximo.enabled = true;
                        }
                    }

                    else if (count < numPag) {

                        if (count < 2) {

                            botaoAnterior.enabled = false;
                            botaoProximo.enabled = false;
                        }

                        else if (currentIndex === count - 1) {

                            botaoProximo.enabled = false;
                        }

                        else if (currentIndex === count) {

                            currentIndex -=1;
                            botaoProximo.enabled = false;
                        }
                    }

                    numPag = count;
                }
            }

            RowLayout {

                id: mudaLogs
                width: parent.width - 2
                height: children.height
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0
                anchors.margins: 1

                Button {

                    id: botaoAnterior
                    Layout.maximumWidth: parent.width/2
                    Layout.maximumHeight: font.pointSize*2
                    text: qsTr("<b>◀</b>")
                    enabled: false

                    onClicked: {

                        if (layoutLog.currentIndex - 1 > 0) {

                            layoutLog.currentIndex -= 1;
                        }

                        else if (layoutLog.currentIndex - 1 === 0) {

                            layoutLog.currentIndex -= 1;
                            enabled=false;
                        }

                        else {

                            enabled=false;
                        }

                        botaoProximo.enabled = true;
                    }
                }

                Button {

                    id: botaoProximo
                    Layout.maximumWidth: parent.width/2
                    Layout.maximumHeight: font.pointSize*2
                    text: qsTr("<b>▶</b>")
                    enabled: false

                    onClicked: {

                        if (layoutLog.currentIndex + 1 < layoutLog.count - 1) {

                            layoutLog.currentIndex += 1;
                        }

                        else if (layoutLog.currentIndex + 1 === layoutLog.count - 1) {

                            layoutLog.currentIndex += 1;
                            enabled=false;
                        }

                        else {

                            enabled=false;
                        }

                        botaoAnterior.enabled = true;
                    }
                }
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
                    var novoLog = Qt.createComponent("TemplateItemLog.qml");

                    var x = componenteCampo.xAleatorioCampo(4.75*componenteCampo.proporcao);
                    var y = componenteCampo.yAleatorioCampo(4.75*componenteCampo.proporcao);

                    if( novaBola.status !== Component.Ready ){

                        if( novaBola.status === Component.Error )

                            console.debug("Erro:"+ novaBola.errorString());

                        return;
                    }

                    componentes.push(novaBola.createObject(componenteCampo, {"x":x, "y":y}));

                    if( novoLog.status !== Component.Ready ){

                        if( novoLog.status === Component.Error )

                            console.debug("Erro:"+ novoLog.errorString());

                        return;
                    }

                    logs.push(novoLog.createObject(layoutLog, {
                        "tipo":"Bola",
                        "indice":componentes.length-1,
                        "xAtual":x/componenteCampo.proporcao,
                        "yAtual":y/componenteCampo.proporcao,
                        "vel":50
                    }));


                    componentes[componentes.length-1].logAssociado = logs[logs.length -1];
                    logs[logs.length -1].objetoAssociado = componentes[componentes.length-1];

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
                    var novoLog = Qt.createComponent("TemplateItemLog.qml");

                    var x = componenteCampo.xAleatorioCampo(7.5*componenteCampo.proporcao);
                    var y = componenteCampo.yAleatorioCampo(7.5*componenteCampo.proporcao);

                    if( novoRobo.status !== Component.Ready ){

                        if( novoRobo.status === Component.Error )

                            console.debug("Erro:"+ novoRobo.errorString());

                        return;
                    }

                    componentes.push(novoRobo.createObject(componenteCampo, {"x":x, "y":y}));

                    if( novoLog.status !== Component.Ready ){

                        if( novoLog.status === Component.Error )

                            console.debug("Erro:"+ novoLog.errorString());

                        return;
                    }

                    logs.push(novoLog.createObject(layoutLog, {
                        "tipo":"Robo",
                        "indice":componentes.length-1,
                        "xAtual":x/componenteCampo.proporcao,
                        "yAtual":y/componenteCampo.proporcao,
                        "vel":50,
                        "corCirculoSuperior": componentes[componentes.length-1].corCirculoSuperior,
                        "corCirculoInferior": componentes[componentes.length-1].corCirculoInferior
                    }));

                    componentes[componentes.length-1].logAssociado = logs[logs.length -1];
                    logs[logs.length -1].objetoAssociado = componentes[componentes.length-1];

                    botaoNovoRobo.enabled = false;
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
                    var novoLog = Qt.createComponent("TemplateItemLog.qml");

                    var x = componenteCampo.xAleatorioCampo(3*componenteCampo.proporcao);
                    var y = componenteCampo.yAleatorioCampo(3*componenteCampo.proporcao);

                    if( novoObst.status !== Component.Ready ){

                        if( novoObst.status === Component.Error )

                            console.debug("Erro:"+ novoObst.errorString());

                        return;
                    }

                    componentes.push(novoObst.createObject(componenteCampo, {"x":x, "y":y}));

                    if( novoLog.status !== Component.Ready ){

                        if( novoLog.status === Component.Error )

                            console.debug("Erro:"+ novoLog.errorString());

                        return;
                    }

                    logs.push(novoLog.createObject(layoutLog, {
                        "tipo":"Obstaculo",
                        "indice":componentes.length-1,
                        "xAtual":x/componenteCampo.proporcao,
                        "yAtual":y/componenteCampo.proporcao,
                        "vel":50
                    }));

                    componentes[componentes.length-1].logAssociado = logs[logs.length -1];
                    logs[logs.length -1].objetoAssociado = componentes[componentes.length-1];
                }
            }
        }
    }
}
