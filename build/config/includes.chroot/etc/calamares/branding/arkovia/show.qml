import QtQuick 2.15

Rectangle {
    width: 800
    height: 450
    color: "#102a43"

    Image {
        anchors.fill: parent
        source: "arkovia-welcome.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "#6608172a"
    }

    Text {
        anchors.centerIn: parent
        text: "Welcome to Arkovia OS"
        color: "white"
        font.pixelSize: 38
        font.bold: true
    }
}
