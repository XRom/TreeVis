import QtQuick 1.0
import "treeMachinery.js" as M

Rectangle {
    id: treeVis
    width: 600
    height: 450
    BorderImage { source: "Core/images/lineedit.sci"; anchors.fill: parent }

    property int hId: 0
    property int hPid: 0
    property int hType: 0


    function createTree() {
        M.treeRoot = null;
        M.insTree(5);
        M.insTree(6);
        M.insTree(4);
        M.insTree(3);

        M.gSeq = [];
        viewTree();
    }

    function addElement(el) {
        M.insTree(el);
    }

    function findElement(el){
        M.findTree(el);
    }

    function viewTree() {
        M.showElems(treeVis);
        M.rebuildTree(treeVis);
    }

    Timer {
        interval: 750; running: true; repeat: true
        onTriggered: {
            if (M.gSeq.length <= 0)
                return;

            var step = M.gSeq.pop();
            for (var i in step) {
                var n = step[i].name;
                var v = step[i].value;

                if ("sethigh" == n) {
                    hType = 1;
                    hId = v;
                } else if ("unhigh" == n) {
                    hType = 1;
                    hId = 0;
                } else if ("shownode" == n){
                    M.showElems(treeVis);
                } else if ("movetohome" == n) {
                    M.rebuildTree(treeVis);
                }
            }
        }
    }

    Component.onCompleted: createTree()

    onHIdChanged: {
        if (hType == 1) {
            if (hPid != 0)
                M.getElem(hPid).state = "base";

            if (hId != 0)
                M.getElem(hId).state = "highlight";

            hPid = hId;
        }
    }

}
