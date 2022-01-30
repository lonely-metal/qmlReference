#include "varianttest.h"

VariantTest::VariantTest(QObject *parent) : QObject(parent)
{

}
void VariantTest::setJudge(bool judge)
{
    _judge = judge;
}
void VariantTest::setId(int id)
{
    _id = id;
}
void VariantTest::setStr(QString str)
{
    _str = str;
}
bool VariantTest::judge(void)
{
    return _judge;
}
int VariantTest::id(void)
{
    return _id;
}
QString VariantTest::str(void)
{
    return _str;
}
