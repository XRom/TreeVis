import QtQuick 1.0

Rectangle {
    width: 640
    height: 480

    id: window

    color: "darkgrey"

    TreeVis {
        id: treeContainer
        x: 10
        y: 10
        height: 460
        width: 452

        color: "white"
        z: 0
        transformOrigin: Item.Center
        scale: 1
        clip: true
        anchors.rightMargin: 178
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent

        Behavior on anchors.rightMargin {
            NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
        }

    }

    Text {
        id: text2
        width: 33
        height: 22
        text: qsTr("Value:")
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: treeContainer.right
        anchors.leftMargin: 8
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12

    }

    TextInput {
        id: value
        x: 516
        y: 10
        width: 74
        height: 22
        text: qsTr("")
        font.family: "MS Serif"
        anchors.top: parent.top
        anchors.topMargin: 10
        cursorVisible: true
        anchors.left: treeContainer.right
        anchors.leftMargin: 54
        font.pixelSize: 12
        opacity: 1

    }


    Row {
        id: row1
        x: 470
        y: 44
        width: 165
        height: 30
        anchors.left: treeContainer.right
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 44
        spacing: 5


        Button {
            text: "Добавить"
            height: 30
            width: 80

            onClicked: {
                var tmp = parseInt(value.text);
                if(!tmp || tmp > 128 || tmp < -127) {
                    return;
                } else {
                    treeContainer.addElement(value.text);
                }
            }
        }

        Button {
            text: "Найти"
            height: 30
            width: 80

            onClicked: {

            }
        }


    }

    Text {
        id: text1
        width: 50
        height: 18
        text: qsTr("Code:")
        anchors.left: treeContainer.right
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 90
        font.pixelSize: 12
    }

    ListView {
        id: code
        x: 470
        y: 117
        width: 165
        height: 353
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 117
        anchors.left: treeContainer.right
        anchors.leftMargin: 8
        delegate: Item {
            x: 5
            height: 40
            Row {
                id: row2
                spacing: 10
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
            }
        }
        model: ListModel {
            ListElement {
                name: "Grey"
                colorCode: "grey"
            }

            ListElement {
                name: "Red"
                colorCode: "red"
            }

            ListElement {
                name: "Blue"
                colorCode: "blue"
            }

            ListElement {
                name: "Green"
                colorCode: "green"
            }
        }
    }
}
