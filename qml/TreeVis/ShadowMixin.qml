import QtQuick 1.0

BorderImage {
    anchors.fill: parent
    z: parent.z - 1

    anchors { leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
    border { left: 10; top: 10; right: 10; bottom: 10 }
    source: "shadow.png"; smooth: true
}
