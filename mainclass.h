#ifndef MAINCLASS_H
#define MAINCLASS_H

#include <QObject>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "varianttest.h"

// 211208: 古いソースからマージ
#include <QQuickImageProvider>
class ImageProvider : public QQuickImageProvider
{
public:
    ImageProvider() :QQuickImageProvider(QQuickImageProvider::Image){}
    virtual QImage requestImage(const QString &id, QSize *size, const QSize& requestedSize);
};

class MainClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString readString READ readString NOTIFY notifyReadString)
    Q_PROPERTY(QVariant variantTest READ variantTest NOTIFY notifyVariantTest)
public:
    explicit MainClass(QObject *parent = nullptr);
    void initialize(QGuiApplication& app);

    // startTimer用
    void timerEvent(QTimerEvent* event) override;

    // QMLから直接呼べる
    Q_INVOKABLE QString getTextFromCpp(){
        return QString("This is the text from C++");
    }

signals:
    void notifyReadString(void);

    // startTimer用
    void notifyLabelCount(QVariant count);

    void notifyVariantTest(void);

private slots:
    void onButtonClicked(void);
    QString readString(void);
    QVariant variantTest(void);

private:
    QQmlApplicationEngine _engine;
    QObject* _obj;
    QString _str;
    VariantTest* _var;
};

#endif // MAINCLASS_H
