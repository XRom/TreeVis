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
        x: 31
        y: 19
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

    ShadowMixin {}
//Костыль
//    property TreeConnector lc: leftConnector;
//    property TreeConnector rc: rightConnector;

//    onLcChanged: leftConnector = lc;
//    onRcChanged: rightConnector = rc;

//    TreeConnector {
//        id: leftConnector
//        toLeft: true
//        anchors.top: parent.bottom
//        anchors.topMargin: -15
//        anchors.right: parent.left
//        anchors.rightMargin: -15
//    }

//    TreeConnector {
//        id: rightConnector
//        toLeft: false
//        anchors.top: parent.bottom
//        anchors.topMargin: -15
//        anchors.left: parent.right
//        anchors.leftMargin: -15
//    }

}
