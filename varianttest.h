#ifndef VARIANTTEST_H
#define VARIANTTEST_H

#include <QObject>

class VariantTest : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool judge READ judge WRITE setJudge NOTIFY notifyJudge)
    Q_PROPERTY(int id READ id WRITE setId NOTIFY notifyId)
    Q_PROPERTY(QString str READ str WRITE setStr NOTIFY notifyStr)
public:
    explicit VariantTest(QObject *parent = nullptr);
    void setJudge(bool judge);
    void setId(int id);
    void setStr(QString str);

signals:
    void notifyJudge(void);
    void notifyId(void);
    void notifyStr(void);

private:
    bool _judge;
    int _id;
    QString _str;

    bool judge(void);
    int id(void);
    QString str(void);
};

#endif // VARIANTTEST_H
