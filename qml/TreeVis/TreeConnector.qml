import QtQuick 1.0


Item {

    property alias toLeft: line.toLeft
    Line {
        id: line
        z: 2
        anchors.fill: parent
    }
}
/**//*
Rectangle {
    property bool toLeft

    border.color: "black"
    border.width: 1

    onWidthChanged: {
        console.log("width =",width);
    }

    Component.onCompleted: {
        console.log(x);
    }
}
/**/
