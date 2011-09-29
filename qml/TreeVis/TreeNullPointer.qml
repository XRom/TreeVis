import QtQuick 1.0

Rectangle {
    id: container
    height: 20
    width: 10
    color: "#00000000"

    property int startX;
    property int startY;

    onStartXChanged: redraw();
    onStartYChanged: redraw();

    smooth: true

    function redraw() {
        container.x = startX - 5 - 0.5;
        container.y = startY;
    }

    Component.onCompleted: redraw()

    Behavior on startX {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    Behavior on startY {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    Rectangle {
        id: verticalLine
        width: 1
        height: 20
        smooth: true
        border.color: "black"
        border.width: 1
        anchors.top:  parent.top
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    Rectangle {
        id: horizontalLine
        width: 10
        height: 1
        smooth: true
        border.color: "black"
        border.width: 1
        anchors.bottom:  parent.bottom
    }
}
