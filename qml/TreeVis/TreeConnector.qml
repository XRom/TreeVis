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

    border.width: 1
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
        line.x = startX - 0.5;
        line.y = startY;
        line.height = Math.sqrt(dX*dX + dY*dY);
        if(line.height < 8) {
            counterclockwiseLine.height = line.height;
            clockwiseLine.height = line.height;
        } else {
            counterclockwiseLine.height = 8;
            clockwiseLine.height = 8;
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
        height: 8
        smooth: true
        border.color: "black"
        border.width: 1
        anchors.bottom:  parent.bottom
        transformOrigin: "BottomLeft"
        rotation: 12
    }

    Rectangle {
        id: clockwiseLine
        width: 1
        height: 8
        smooth: true
        border.color: "black"
        border.width: 1
        anchors.bottom:  parent.bottom
        transformOrigin: "BottomRight"
        rotation: -12
    }

    //Зажигание стрелок
    /*
    state: "base"

    states: [
        State {
            name: "base"

            PropertyChanges {
                target: line

                border.color: "black"
                border.width: 1
            }
        },

        State {
            name: "highlight"

            PropertyChanges {
                target: line

                border.color: "#993300"
                border.width: 2
            }
        }
    ]

    transitions: Transition {
        ColorAnimation  { properties: "border.color"; duration: 200 }
        NumberAnimation { properties: "border.width"; duration: 200; easing.type: Easing.InOutQuad }
    }
    */
}
