#ifndef SYSTEM_H
#define SYSTEM_H

#include <QObject>
#include <QTimer>

class System : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool carLock READ carLock WRITE setCarLock NOTIFY carLockChanged FINAL)
    Q_PROPERTY(int8_t outdoorTemp READ outdoorTemp WRITE setOutdoorTemp NOTIFY outdoorTempChanged FINAL)
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged FINAL)
    Q_PROPERTY(QString currentTime READ currentTime WRITE setCurrentTime NOTIFY currentTimeChanged FINAL)
public:
    explicit System(QObject *parent = nullptr);

    bool carLock() const;
    Q_INVOKABLE void setCarLock(bool newCarLock); // Make sure Q_INVOKABLE is here




    int8_t outdoorTemp() const;
    void setOutdoorTemp(int8_t newOutdoorTemp);

    QString userName() const;
    void setUserName(const QString &newUserName);

    QString currentTime() const;
    void setCurrentTime(const QString &newCurrentTime);

    void currentTimeTimerTimeout();

signals:
    void carLockChanged();


    void outdoorTempChanged();

    void userNameChanged();

    void currentTimeChanged();

private:
    bool m_carLock;
    int8_t m_outdoorTemp;
    QString m_userName;
    QString m_currentTime;
    QTimer * m_currentTimeTimer;
};

#endif // SYSTEM_H

