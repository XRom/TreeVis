import QtQuick 1.0

Rectangle {
    id: element
    radius: 5
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

    //зажигание элементов
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

                border.color: "#ee7700"
                border.width: 4
            }
        },

        State {
            name: "highlight_red"

            PropertyChanges {
                target: element
                border.color: "red"
                border.width: 5
            }

        }

    ] // states

    Timer {
        id: timerTwink
        repeat: true
        interval: 200

        onTriggered: {
            if(element.state == "highlight_red") {
                element.state = "base";
            } else if(element.state == "base") {
                element.state = "highlight_red";
            }
        }
    }

    Timer {
        id: timerOffTwink
        repeat: true
        interval: 3000

        onTriggered: {
            if(element.state == "highlight_red") {
                element.state = "base";
            }

            timerTwink.stop();
            timerOffTwink.stop();
        }
    }

    function startTwink() {
        timerTwink.start();
        timerOffTwink.start();
    }

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

    Rectangle {
        width: 10
        height: 10
        radius: 5

        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Rectangle {
        width: 10
        height: 10
        radius: 5

        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

}
