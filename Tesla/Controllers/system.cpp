#include "system.h"
#include <QDateTime>
#include <QDebug>
System::System(QObject *parent)
    : QObject{parent}
    , m_carLock( true )
    , m_outdoorTemp( 64 )
    , m_userName( "Dashboard" )

{
    m_currentTimeTimer = new QTimer(this);
    m_currentTimeTimer->setInterval(500);
    m_currentTimeTimer->setSingleShot( true );
    connect(m_currentTimeTimer , &QTimer::timeout, this, &System::currentTimeTimerTimeout);
    currentTimeTimerTimeout();
}



bool System::carLock() const
{
    return m_carLock;
}

void System::setCarLock(bool newCarLock)
{
    if (m_carLock == newCarLock)
        return;
    m_carLock = newCarLock;
    emit carLockChanged();
      qDebug() << m_carLock;
}

int8_t System::outdoorTemp() const
{
    return m_outdoorTemp;
}

void System::setOutdoorTemp(int8_t newOutdoorTemp)
{
    if (m_outdoorTemp == newOutdoorTemp)
        return;
    m_outdoorTemp = newOutdoorTemp;
    emit outdoorTempChanged();
}

QString System::userName() const
{
    return m_userName;
}

void System::setUserName(const QString &newUserName)
{
    if (m_userName == newUserName)
        return;
    m_userName = newUserName;
    emit userNameChanged();

}

QString System::currentTime() const
{
    return m_currentTime;
}

void System::setCurrentTime(const QString &newCurrentTime)
{
    if (m_currentTime == newCurrentTime)
        return;
    m_currentTime = newCurrentTime;
    emit currentTimeChanged();
}

void System::currentTimeTimerTimeout()
{
    QDateTime dateTime;
    //qDebug() << currentTime;
    QString currentTime = dateTime.currentDateTime().toString("hh:mm ap");
    setCurrentTime(currentTime);
    m_currentTimeTimer->start();
}
