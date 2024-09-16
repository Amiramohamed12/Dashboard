import QtQuick 2.15
import QtLocation
import QtPositioning


Rectangle{
    id: rightScreen
    anchors{
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
    }

       width: 2*parent.width/3
    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(30.02, 31.13)
        zoomLevel: 14
        property geoCoordinate startCentroid

        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
            }
            onScaleChanged: (delta) => {
                map.zoomLevel += Math.log2(delta)
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            onRotationChanged: (delta) => {
                map.bearing -= delta
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }
    }
    Image {
        id: lockIcon
        anchors{
        top: parent.top
        left: parent.left
        margins: 10
        centerIn: verticalCenter

        }
        width: parent.width/20
        fillMode: Image.PreserveAspectFit
        source: (systemHandler.carLock ? "qrc:/UI/Assets/lock.png" : "qrc:/UI/Assets/padlock-unlock.png" )
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("MouseArea clicked")
                systemHandler.setCarLock(!systemHandler.carLock)
            }
            onPressed: {
                parent.opacity = 0.5  // Dim the image when pressed, as feedback
            }
            onReleased: {
                parent.opacity = 1.0  // Restore opacity after click
            }
        }

    }
    Text {
        id: dateTimeDisplay
        anchors{
        left:  lockIcon.right
        leftMargin: 40
        bottom: lockIcon.bottom
        }
        font.pixelSize: 15
        font.bold: true
        color: "black"
        text: systemHandler.currentTime
        }
    Text {
        id: outdoorTempDisplay
        anchors{
        left: dateTimeDisplay.right
        leftMargin: 40
        bottom: lockIcon.bottom
        }
        font.pixelSize: 15
        font.bold: true
        color: "black"
        text: systemHandler.outdoorTemp + "°F"
        }
    Text {
        id: userNameDisplay
        anchors{
        left: outdoorTempDisplay.right
        leftMargin: 40
        bottom: lockIcon.bottom
        }
        font.pixelSize: 15
        font.bold: true
        color: "black"
        text: systemHandler.userName
        }
    NavigationSearchBox{
    id: navigationSearchBox
    color: "#f5f5f2"
    anchors{
    left: parent.left
    leftMargin: 10
    top: lockIcon.bottom
    topMargin: 10

    }
     width: parent.width /2.5
     height: parent.height /12
    }
    }
