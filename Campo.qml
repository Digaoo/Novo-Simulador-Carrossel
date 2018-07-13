import QtQuick 2.0

// Canvas é o espaço máximo dado para que o campo seja desenhado.
Rectangle {

    id: canvas
    color: "#FFFFFF"
    width: parent.implicitWidth
    height: parent.implicitHeight
    border.color: "black"
    border.width: 1

    // Este retângulo representa todas as paredeas do campo (com exceção das paredes dos gols).
    Rectangle {

        property int proporcao:  Math.min(Math.floor(canvas.width/170), Math.floor(canvas.height/130))

        id: paredes
        width: 170*proporcao - 20*proporcao
        height: 130*proporcao
        color: "#6f370f"
        anchors.centerIn: canvas

        // Representa o gramado geral do campo.
        Rectangle {

            id: gramado
            width: paredes.width - 2*paredes.proporcao
            height: paredes.height - 2*paredes.proporcao
            color: "#526F35"
            anchors.centerIn: parent
        }

        // Representa linha de demarcação do gol no lado esquerdo.
        Rectangle {

            id: linhaGolEsquerdo
            width: paredes.proporcao
            height: 40*paredes.proporcao - 2*paredes.proporcao
            color: "#FFFFFF"
            anchors.left: paredes.left
            anchors.verticalCenter: paredes.verticalCenter
        }

        // Representa a meia-lua da área do lado esquerdo.
        Rectangle {

            id: linhaCirculoAreaEsquerda
            width: 10*paredes.proporcao
            height: 20*paredes.proporcao
            radius: width*0.5
            color: "#FFFFFF"
            anchors.horizontalCenter: linhaAreaEsquerda.right
            anchors.verticalCenter: paredes.verticalCenter
        }

        // Representa o gramado interno à meia lua da àrea do lado esquerdo.
        Rectangle {

            id: gramadoCirculoAreaEsquerda
            width: 10*paredes.proporcao - 2*paredes.proporcao
            height: 20*paredes.proporcao - 2*paredes.proporcao
            radius: width*0.5
            color: "#526F35"
            anchors.centerIn: linhaCirculoAreaEsquerda
        }

        // Representa as linhas da área do lado esquerdo.
        Rectangle {

            id: linhaAreaEsquerda
            width: 15*paredes.proporcao - paredes.proporcao
            height: 70*paredes.proporcao
            color: "#FFFFFF"
            anchors.left: gramado.left
            anchors.verticalCenter: paredes.verticalCenter
        }

        // Representa o gramado interno da área do lado esquerdo.
        Rectangle {

            id: gramadoAreaEsquerda
            width: 15*paredes.proporcao - 2* paredes.proporcao
            height: 70*paredes.proporcao - 2* paredes.proporcao
            color: "#526F35"
            anchors.left: gramado.left
            anchors.verticalCenter: paredes.verticalCenter
        }

        // Representa as linhas do círculo central do campo.
        Rectangle {

            id: linhaCirculoMeioCampo
            width: 40*paredes.proporcao
            height: 40*paredes.proporcao
            radius: width*0.5
            color: "#FFFFFF"
            anchors.centerIn: gramado
        }

        // Representa o gramado interno do círculo central do meio campo.
        Rectangle {

            id: gramadoCirculoMeioCampo
            width: 40*paredes.proporcao - 2*paredes.proporcao
            height: 40*paredes.proporcao - 2*paredes.proporcao
            radius: width*0.5
            color: "#526F35"
            anchors.centerIn: gramado
        }

        // Representa a linha central que divide o campo em dois lados.
        Rectangle {

            id: linhaMeioCampo
            width: paredes.proporcao
            height: gramado.height
            color: "#FFFFFF"
            anchors.centerIn: gramado
        }

        // Representa linha de demarcação do gol no lado direito.
        Rectangle {

            id: linhaGolDireito
            width: paredes.proporcao
            height: 40*paredes.proporcao - 2*paredes.proporcao
            color: "#FFFFFF"
            anchors.right: paredes.right
            anchors.verticalCenter: paredes.verticalCenter
        }

        // Representa a meia-lua da área do lado direito.
        Rectangle {

            id: linhaCirculoAreaDireita
            width: 10*paredes.proporcao
            height: 20*paredes.proporcao
            radius: width*0.5
            color: "#FFFFFF"
            anchors.horizontalCenter: linhaAreaDireita.left
            anchors.verticalCenter: paredes.verticalCenter
        }

        // Representa o gramado interno à meia lua da àrea do lado direito.
        Rectangle {

            id: gramadoCirculoAreaDireita
            width: 10*paredes.proporcao - 2*paredes.proporcao
            height: 20*paredes.proporcao - 2*paredes.proporcao
            radius: width*0.5
            color: "#526F35"
            anchors.centerIn: linhaCirculoAreaDireita
        }

        // Representa as linhas da área do lado direito.
        Rectangle {

            id: linhaAreaDireita
            width: 15*paredes.proporcao - paredes.proporcao
            height: 70*paredes.proporcao
            color: "#FFFFFF"
            anchors.right: gramado.right
            anchors.verticalCenter: paredes.verticalCenter
        }

        // Representa o gramado interno da área do lado direito.
        Rectangle {

            id: gramadoAreaDireita
            width: 15*paredes.proporcao - 2* paredes.proporcao
            height: 70*paredes.proporcao - 2* paredes.proporcao
            color: "#526F35"
            anchors.right: gramado.right
            anchors.verticalCenter: paredes.verticalCenter
        }
    }

    // Representa as paredes do gol do lado esquerdo.
    Rectangle {

        id: paredeGolEsquerdo
        width: 10*paredes.proporcao - paredes.proporcao
        height: 40*paredes.proporcao
        color: "#6f370f"
        anchors.right: paredes.left
        anchors.verticalCenter: paredes.verticalCenter

        // Representa o gramado interno ao gol do lado esquerdo.
        Rectangle {

            id: gramadoGolEsquerdo
            width: paredeGolEsquerdo.width - paredes.proporcao
            height: paredeGolEsquerdo.height - 2*paredes.proporcao
            color: "#526F35"
            anchors.right: paredeGolEsquerdo.right
            anchors.verticalCenter: paredeGolEsquerdo.verticalCenter
        }
    }

    // Representa as paredes do gol do lado direito.
    Rectangle {

        id: paredeGolDireito
        width: 10*paredes.proporcao - paredes.proporcao
        height: 40*paredes.proporcao
        color: "#6f370f"
        anchors.left: paredes.right
        anchors.verticalCenter: paredes.verticalCenter

        // Representa o gramado interno ao gol do lado direito.
        Rectangle {

            id: gramadoGolDireito
            width: paredeGolDireito.width - paredes.proporcao
            height: paredeGolDireito.height - 2*paredes.proporcao
            color: "#526F35"
            anchors.left: paredeGolDireito.left
            anchors.verticalCenter: paredeGolDireito.verticalCenter
        }
    }


}

