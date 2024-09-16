import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.VirtualKeyboard 2.15
import "UI/BottomBar"
import "UI/RightScreen"
import "UI/LeftScreen"
import QtWebEngine
Window {
    id: window
    width: 1280
    height: 720
    visible: true
    title: qsTr("Tesla Infotainment")

    BottomBar{
    id: bottomBar
    }
    RightScreen{
    id: rightScreen
    }
    LeftScreen{
    id: leftSCreen
    }
    Image {
        id: youtubeDisplay
        anchors{
            right: bottomBar.right
            margins: 15
            verticalCenter: bottomBar.verticalCenter
        }
        height: bottomBar.height*0.95
        width: parent.width /30
        fillMode: Image.PreserveAspectFit
        source: "qrc:/UI/Assets/youtube.png"

        MouseArea {
                   id: youtubeMouseArea
                   anchors.fill: parent
                   onClicked: {
                       youtubeView.visible = !youtubeView.visible
                   }
               }
           }

           WebEngineView {
               id: youtubeView
               anchors.fill: parent
               url: "https://www.youtube.com"
               visible: false

           }
    Image {
               id: facebookDisplay
               anchors{
                   right: youtubeDisplay.left
                   margins: 40
                   verticalCenter: bottomBar.verticalCenter
               }
               height: bottomBar.height*0.95
               width: parent.width /30
               fillMode: Image.PreserveAspectFit
               source: "qrc:/UI/Assets/facebook.png"
               visible: !youtubeView.visible

     MouseArea {
                          id: facebookMouseArea
                          anchors.fill: parent
                          onClicked: {
                              facebookView.visible = !facebookView.visible
                          }
                      }
                  }

       WebEngineView {
                      id: facebookView
                      anchors.fill: parent
                      url: "https://www.facebook.com"
                      visible: false
                  }
}
