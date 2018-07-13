#ifndef BOLA_H
#define BOLA_H

#include <QObject>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QtQuick>

class Bola : public QObject{

    Q_OBJECT

public:

    explicit Bola(QObject *parent = nullptr);

    Q_INVOKABLE int pegaX() const;
    Q_INVOKABLE void setaX(int value);

    Q_INVOKABLE int pegaY() const;
    Q_INVOKABLE void setaY(int value);

    Q_INVOKABLE void bolaClicada();

private:

    int x = 0;
    int y = 0;

signals:

public slots:

};

extern Bola* bola;

#endif // BOLA_H
