#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <Controllers/system.h>
#include <QtWebEngineQuick/QtWebEngineQuick>


int main(int argc, char *argv[])
{
    // Set the environment variable for the virtual keyboard
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QtWebEngineQuick::initialize();
    System m_systemHandler;


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    QQmlContext * context (engine.rootContext());
    context->setContextProperty("systemHandler",&m_systemHandler);

    return app.exec();
}
