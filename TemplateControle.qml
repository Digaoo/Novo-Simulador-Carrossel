import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

// Layout em grade que dispõe o campo e elementos auxiliares.
GridLayout {

    id: layoutCampos
    width: parent.width
    height: escolheAnim.height + botaoSimular.height
    rows: 2
    columns: 2

    Label {

        text: qsTr("Animação de Trajetória:")
        font.pixelSize: Qt.application.font.pixelSize
        padding: 4
        color: "black"
    }

    Label {

        text: qsTr("Simulação:")
        font.pixelSize: Qt.application.font.pixelSize
        padding: 4
        color: "black"
    }

    ComboBox {

        id: escolheAnim
        currentIndex: 0
        model: ["Ponto a Ponto", "Modelo Cinemático"]
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
    }

    // Botão que aplica a funcionalidade escolhida no combo box acima.
    Button {

        id: botaoSimular
        text: qsTr("Iniciar")
        focusPolicy: Qt.NoFocus
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        Layout.preferredWidth: parent.width/5

        property bool simulando: false

        onClicked: {

            simulando = !simulando;

            if (simulando) {

                text = "Parar"
            }

            else {

                text = "Iniciar"
            }
        }
    }
}
