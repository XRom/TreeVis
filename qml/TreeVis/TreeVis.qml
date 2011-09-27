import QtQuick 1.0
import "treeMachinery.js" as M

Rectangle {
    id: treeVis
    width: 600
    height: 450
    radius: 10
    BorderImage { source: "Core/images/lineedit.sci"; anchors.fill: parent }

    property int hId: 0
    property int hPid: 0
    property int hType: 0
    signal animationOver

    function isAnimationLaunch() {
        return animationTimer.running;
    }

    function createTree() {
        //создание начального дерева
        M.treeRoot = null;
        M.insTree(50);
        M.insTree(60);
        M.insTree(40);
        M.insTree(30);

        M.gSeq = [];
        viewTree();
    }

    function addElement(el) {
        M.insTree(el);
        animationTimer.start();
    }

    function findElement(el){
        M.findTree(el);
        animationTimer.start();
    }

    function viewTree() {
        M.showElems(treeVis);
        M.showArrows(treeVis);
        M.rebuildTree(treeVis);
        //Костыль
    }

    Timer {
        id: animationTimer
        interval: 500;
        repeat: true

        onTriggered: {
            //тут обрабатывается последовательность команд из treeMachinery.js
            if (M.gSeq.length <= 0) {
                //анимация кончилась, пора разблокировать кнопки
                animationTimer.stop();
                treeVis.animationOver();
                return;
            }

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
                    M.showArrows(treeVis);
                } else if ("movetohome" == n) {
                    M.rebuildTree(treeVis);
                    //Костыль
                }
            }
        }
    }

    Component.onCompleted: createTree()

    onHIdChanged: {
        if (hType == 1) {
            //погасить предыдущий
            if (hPid != 0)
                M.getElem(hPid).state = "base";
            //зажечь текущий
            if (hId != 0)
                M.getElem(hId).state = "highlight";
            //текущий становится предыдущим
            hPid = hId;
        }
    }

}
