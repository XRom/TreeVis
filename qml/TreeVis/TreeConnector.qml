import QtQuick 1.0


Rectangle {
    id: line
    width: 1
//    property bool toLeft: true

    property int startX;
    property int startY;
    property int endX;
    property int endY;

    onStartXChanged: redraw();
    onStartYChanged: redraw();
    onEndXChanged: redraw();
    onEndYChanged: redraw();

    border.width: 2
    border.color: "black"
    smooth: true
    transformOrigin: "TopLeft"

    function redraw() {
        var dX = endX - startX;
        var dY = endY - startY;
        var angle = (dY != 0 ? (Math.atan(dX/dY) * (-180) / Math.PI) : ((dX > 0) ? -90 : 90));
        if(dY < 0) {
            angle += 180;
        }
        line.x = startX;
        line.y = startY;
        line.height = Math.sqrt(dX*dX + dY*dY);
        if(line.height < 15) {
            counterclockwiseLine.height = line.height;
            clockwiseLine.height = line.height;
        } else {
            counterclockwiseLine.height = 15;
            clockwiseLine.height = 15;
        }

        line.rotation = angle;
    }

    onWidthChanged: redraw()
    onHeightChanged: redraw()
    Component.onCompleted: redraw()

    Behavior on startX {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    Behavior on startY {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    Behavior on endX {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    Behavior on endY {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    Rectangle {
        id: counterclockwiseLine
        width: 1
        height: 15
        smooth: true
        border.color: "black"
        border.width: 2
        anchors.bottom:  parent.bottom
        transformOrigin: "BottomLeft"
        rotation: 20
    }

    Rectangle {
        id: clockwiseLine
        width: 1
        height: 15
        smooth: true
        border.color: "black"
        border.width: 2
        anchors.bottom:  parent.bottom
        transformOrigin: "BottomRight"
        rotation: -20
    }
}
