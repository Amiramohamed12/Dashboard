import QtQuick 2.15
import QtWebEngine

Rectangle{

      id: bottomBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        color: "black"
        height: parent.height/12
        Image {
            id: carSettingsIcon
            anchors{
                left: parent.left
                leftMargin: 30
                verticalCenter: parent.verticalCenter
            }
            height: parent.height*0.85
            fillMode: Image.PreserveAspectFit
            source: "qrc:/UI/Assets/sedan-car-front.png"
        }

}
