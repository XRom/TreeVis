import QtQuick 1.0

Rectangle {
    id: element
    width: 50
    height: 40
    radius: width / 8

    property string key
    onKeyChanged: {
        if(key == null || key == "" || key == "NULL") {
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

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (element.state != "highlight")
                element.state = "highlight";
            else
                element.state = "base";
        }
    }

    Rectangle {
        id: leftP
        width: parent.width / 4;
        height: parent.width / 4;
        radius: parent.width / 8;

        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
    }

    Rectangle {
        id: rightP
        width: parent.width / 4;
        height: parent.width / 4;
        radius: parent.width / 8;

        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
    }

}
