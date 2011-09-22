import QtQuick 1.0

Item {
    id: container
    property bool toLeft: true

    Rectangle {
        id: line
        height: 1
        border.width: 1
        border.color: "black"
        smooth: true
        transformOrigin: "TopLeft"
    }

    function redraw() {
        var rw = container.width;
        var rh = container.height;

        line.width = Math.sqrt(rw*rw + rh*rh);
        if (line.width < 1)
            return;

        if (toLeft == true) {
            line.rotation = 90 + Math.atan(rh/rw) * 180 / 3.1415926;
        } else {
            line.rotation = Math.atan(rh/rw) * 180 / 3.1415926;
        }
    }

    onWidthChanged: redraw()
    onHeightChanged: redraw()
    Component.onCompleted: redraw()
}
