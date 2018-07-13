#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "bola.h"

int main(int argc, char *argv[]){

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    //qmlRegisterType<Bola>("bolaUtils", 1, 0, "BolaClass");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
