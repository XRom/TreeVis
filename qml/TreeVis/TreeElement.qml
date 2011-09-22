import QtQuick 1.0

Rectangle {
    id: element

    width: 50
    height: 40

    property string key
    onKeyChanged: {
        if (key == null || key == "" || key == "NULL") {
            label.text = "NULL";
            element.color = "#FFFFFF";
        } else {
            label.text = key;
            element.color = "#35E865";
        }
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: "black"
    }
    state: "base"

    states: [
        State {
            name: "base"

            PropertyChanges {
                target: element

                border.color: "#35E865"
                border.width: 0
            }
        },

        State {
            name: "highlight"

            PropertyChanges {
                target: element

                border.color: "red"
                border.width: 8
            }
        }
    ] // states

    transitions: Transition {
        ColorAnimation  { properties: "border.color"; duration: 200 }
        NumberAnimation { properties: "border.width"; duration: 200; easing.type: Easing.InOutQuad }
    }


    Behavior on x {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    Behavior on y {
        NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
    }

    ShadowMixin {
    }

/*
    TreeConnector {
        id: left
        toLeft: true

        anchors.top: parent.bottom
        anchors.topMargin: -15
        anchors.right: parent.left
        anchors.rightMargin: -15
        height: 20
        width: 0
    }

    TreeConnector {
        id: right
        toLeft: false

        anchors.top: parent.bottom
        anchors.topMargin: -15
        anchors.left: parent.right
        anchors.leftMargin: -15
        height: 20
        width: 60
    }
    */
}
