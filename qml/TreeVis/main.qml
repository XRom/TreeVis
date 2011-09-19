import QtQuick 1.0
import "Core"

Rectangle {
    width: 640
    height: 480

    id: window

    color: "#343434";
    Image { source: "Core/images/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

    TreeVis {
        id: treeContainer
        x: 10
        y: 10
        height: 460
        width: 452

        color: "white"
        z: 0
        transformOrigin: Item.Center
        clip: true
        anchors.rightMargin: 225
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent

        Behavior on anchors.rightMargin {
            NumberAnimation {duration: 1000; easing.type: Easing.OutBack}
        }

    }

    Column {
        anchors.top: window.top
        anchors.topMargin: 10

        anchors.left: treeContainer.right
        anchors.leftMargin: 10
        anchors.right: window.right
        anchors.rightMargin: 5

        spacing: 20
        Column {
            spacing: 4
            Text {
                text: "Значение:"
                font.pixelSize: 16; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
                horizontalAlignment: Qt.AlignRight
            }

            Input {
                id: value
                focus: true
            }
        }

        Row {

            spacing: 5

            Button {
                text: "Добавить"
                width: 100
                height: 32
                keyUsing: true;
                opacity: 1

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
                width: 100
                height: 32
                keyUsing: true;
                opacity: 1

                onClicked: {
                    var tmp = parseInt(value.text);
                    if(!tmp || tmp > 128 || tmp < -127) {
                        return;
                    } else {
                        treeContainer.addElement(value.text);
                    }
                }
            }
        } // Row

        Column {
            spacing: 4
            Text {
                text: "Код:"
                font.pixelSize: 16; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
                horizontalAlignment: Qt.AlignRight
            }

            /*
            CodeView {
                id: code
                focus: true
            }
            /* */
        }

    } // Column
}
