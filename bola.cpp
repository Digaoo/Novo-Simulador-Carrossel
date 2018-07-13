#include "bola.h"

Bola::Bola(QObject *parent) : QObject(parent){

}

int Bola::pegaX() const{

    return x;
}

void Bola::setaX(int value){

    x = value;
}

int Bola::pegaY() const{

    return y;
}

void Bola::setaY(int value){

    y = value;
}

void Bola::bolaClicada() {

    QObject* bolaQML;
    QQuickItem* bolaRetangulo;

    QQmlEngine engine;
    QQmlComponent component(&engine, QUrl::fromLocalFile("Bola.qml"));
    bolaQML = component.create();

    bolaRetangulo = bolaQML->findChild<QQuickItem*>("bola");

    bolaRetangulo->setX(50.0);
    bolaRetangulo->setY(50.0);
}
