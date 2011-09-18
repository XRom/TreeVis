import QtQuick 1.0

Rectangle {
    id: button
    width: 30; height: 60
    color: "blue"
    smooth: true; radius: 9

    property alias text: label.text
    property alias textColor: label.color
    property alias textFont: label.font

    signal clicked
    signal hovered


    border {color: "#B9C5D0"; width: 1}


    gradient: Gradient {

        GradientStop {color: "#CFF7FF"; position: 0.0}
        GradientStop {color: "#99C0E5"; position: 0.57}
        GradientStop {color: "#719FCB"; position: 0.9}
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: "Click Me Baby!"
        font.pointSize: 12
        color: "blue"
    }

    MouseArea {
        id: area
        anchors.fill: parent
        Component.onCompleted: {
            clicked.connect(button.clicked)
        }

        /*
        onPressed:  button.state = "pressed"
        onReleased: button.state = "hovered"
        onEntered:  button.state = "hovered"
        onExited:   button.state = "base"*/
    }
}
