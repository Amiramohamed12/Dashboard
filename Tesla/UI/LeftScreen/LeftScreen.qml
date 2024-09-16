import QtQuick 2.15


Rectangle {
    id: leftScreen
    anchors{
    left: parent.left
    right: rightScreen.left
    top: parent.top
    bottom: bottomBar.top

    }
    color: "black"

    Image{
    id: carRender
    anchors.centerIn: parent
    width: parent.width*0.95
    fillMode: Image.PreserveAspectFit
    source: "qrc:/UI/Assets/images.jpeg"

    }
}
