import QtQuick 2.15
import QtQuick.VirtualKeyboard 2.15

Rectangle{
id: navSearchBox
radius: 5

Image {
    id: searchIcon
    source: "qrc:/UI/Assets/search.png"
    anchors{
    leftMargin: 20
    left: parent.left
    verticalCenter: parent.verticalCenter

    }
    fillMode: Image.PreserveAspectFit
    width: parent.width/12
}
Text {
    id: navigationPlaceHolderText
    visible: navigationTextInput.text===""
    color: "#373737"
    text: "Navigate"
    font.pixelSize: 12

    anchors{
    left: searchIcon.right
    leftMargin: 25
    verticalCenter: parent.verticalCenter
    topMargin: 20
    }
  }
TextInput{
id: navigationTextInput
font.pixelSize: 16
clip: true
anchors{
top: parent.top
bottom: parent.bottom
left: searchIcon.right
right: parent.right
leftMargin: 25

}
verticalAlignment: Text.AlignVCenter

 }
// Ensure the TextInput is focusable
   focus: true

   // When the TextInput gains focus, show the virtual keyboard
   onFocusChanged: {
       if (focus) {
           Qt.inputMethod.show()
       }
   }

   // Optional: Hide the keyboard when focus is lost
   onActiveFocusChanged: {
       if (!activeFocus) {
           Qt.inputMethod.hide()
       }
   }
}
