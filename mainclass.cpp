#include <QQmlContext>
#include "mainclass.h"

MainClass::MainClass(QObject *parent)
    : QObject(parent)
    , _var(new VariantTest)
{
}
void MainClass::initialize(QGuiApplication& app)
{
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&_engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    _engine.load(url);

    _engine.rootContext()->setContextProperty("MainClass", this);
    _obj = qobject_cast<QObject*>(_engine.rootObjects().constFirst());

    connect(_obj, SIGNAL(buttonClicked()), this, SLOT(onButtonClicked()));

    _engine.addImageProvider(QLatin1String("imagedata"),new ImageProvider);

    // startTimer用
    connect(this, SIGNAL(notifyLabelCount(QVariant)), _obj, SLOT(labelCountFunc(QVariant)));
    startTimer(3000);

    _var->setJudge(true);
    _var->setId(100);
    _var->setStr("Variant Test");
    emit notifyVariantTest();
}
QVariant MainClass::variantTest(void)
{
    return QVariant::fromValue(_var);
}

// startTimer用
void MainClass::timerEvent(QTimerEvent* event)
{
    static int count = 1;
    notifyLabelCount(QVariant(count++));
}

void MainClass::onButtonClicked(void)
{
    static int i = 0;
    _str = QString::number(i++);
    emit notifyReadString();
}

QString MainClass::readString(void)
{
    return _str;
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize& requestedSize)
{
    Q_UNUSED(size);
    Q_UNUSED(requestedSize);

    QImage image("E:/tmp/" + id);
    int height = image.height();
    int width = image.width();
    if(height > 800 || width > 1580)
    {
        QImage img = image.scaled(1580, 800, Qt::KeepAspectRatio);
        return img;
    }
    return image;
}

