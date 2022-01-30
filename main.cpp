#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDateTime>
#include <QDir>
#include <QFile>

#include "mainclass.h"

// UTF-8(BOM)のテキストファイル出力
void utf8BOMoutput(void)
{
    QFile fp("UTF8.txt");

    if (fp.open(QIODevice::WriteOnly)) {
        QTextStream out(&fp);
        out.setCodec("UTF-8");
        out.setGenerateByteOrderMark(true);
        out << "Test" << Qt::endl;
        fp.close();
    }
}

void func(int i){
    Q_UNUSED(i);    // iが未使用だというwarningが出なくなる
}
void downCast(void);

void makeDir(void);

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    MainClass mainthread;
    mainthread.initialize(app);

    // QString().asprintf
    QString st = QString().asprintf("[%3d][%03d][%3.3f][0x%08x][%s]", 1, 22, 33333.33333, 4444444, "Test");
    qDebug() << st;

    func(1);

    QDateTime dt = QDateTime::fromString("20211205175000", "yyyyMMddhhmmss");   // ここの桁数が合ってないと、ちゃんと出力されない
    qDebug() << dt.toString("yyyyMMddhhmmss");

    downCast();

    qDebug() << QString("%1 (%2)").arg("title", "01");

    // QMapテスト
    QMap<QString, int> qmap;
    qmap["void"] = 100;
    qmap["int"] = 100;
    qDebug() << qmap.value("void", 0);
    qDebug() << qmap.value("int", 0);
    qDebug() << qmap.value("double", 0);

    QMap<QString, QVariant> varMap;
    varMap["one"] = QVariant("aaa");
    varMap["two"] = QVariant(2);
    varMap["three"] = QVariant(33.33);
    QString varMap1 = varMap["one"].toString();
    int varMap2 = varMap["two"].toInt();
    double varMap3 = varMap["three"].toDouble();
    qDebug() << varMap1 << varMap2 << varMap3;

    // QMapイテレータ
    QMap<QString, int> qmap2 {{"AAA", 1}, {"BBB", 2}, {"CCC", 3}};
    QMap<QString, int>::const_iterator it = qmap2.constBegin();
    while (it != qmap2.constEnd()) {
        qDebug() << it.key() << " " << it.value();
        ++it;
    }

    makeDir();

    utf8BOMoutput();

    return app.exec();
}

void makeDir(void)
{
    QDir dir("E:/work/testMkdir");
    QList<QString> addDir;
    addDir.append("test");
    addDir.append("test/test");
    for (int cnt=0; cnt<addDir.size(); ++cnt) {
        if (!dir.exists(addDir[cnt])) {
            dir.mkdir(addDir[cnt]);
        }
    }
}

// 何でこんな動き見るプログラム作ったんやったっけ？
void shared_ptr210606(void)
{
    QList<int>  qlist{};
    QList<int>* q1 = &qlist;
    QList<int>* q2 = &qlist;
    qlist.append(1);
    q1->append(2);
    q2->append(3);

    for(int cnt=0; cnt<q2->size(); cnt++){
        printf("%d\n", qlist[cnt]);    fflush(stdout);
        printf("%d\n", q1->at(cnt));    fflush(stdout);
        printf("%d\n", q2->at(cnt));    fflush(stdout);
    }
}

/*
    211207:
    QPair動作確認
*/
struct St {
    int         i;
    QString     st;
};
void qpairFunc(QPair<int, St>& pai)
{
    pai.first = 3;
    pai.second.i = 5;
    pai.second.st = "AAA";
}
void qpairFuncCall()
{
    int i{};
    St st{};
    QPair<int, St>  pai{i, st};
    qpairFunc(pai);
}

/*
 * 211207:
 * ダウンキャスト確認
*/
class Base{
public:
    virtual ~Base(){}
    void setValue(int i){
        _value = i;
    }
    int getValue(void) {
        return _value;
    }
private:
    int _value;
};
class Derived : public Base{
public:
    void func(void){}
};
void downCast(void)
{
    Base* b = new Derived;
    b->setValue(100);
    //b->func();    エラー
    Derived* d = dynamic_cast<Derived*>(b);
    d->func();
    qDebug() << "down cast: " << d->getValue();
}
