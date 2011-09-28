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

    function clearTree() {
        M.clearTree();
    }

    //Костыли
    //Может сбоить при изменении потомков или их порядка у объектов window и codeContainer
    //Блин, всё летает очень быстро
    //Но вроде бы правильно
    //По-моему выглядит забавно :D
    function findLinesSwitcher(str) {
        switch (str) {
        case "find_ifTreeNull" : window.children[3].children[1].strId = 1;
            break;
        case "find_TreeNull" : window.children[3].children[1].strId = 13;
            break;
        case "find_ifTreeNullElse" : window.children[3].children[1].strId = 8;
            break;
        case "find_Left" : window.children[3].children[1].strId = 9;
            break;
        case "find_ifLeftElse" : window.children[3].children[1].strId = 0;
            break;
        case "find_Right" : window.children[3].children[1].strId = 11;
            break;
        case "find_ifRightElse" : window.children[3].children[1].strId = 5;
            break;
        case "find_finded" : window.children[3].children[1].strId = 6;
            break;
        case "find_uselessCheck" : //window.children[3].children[1].strId = 3;
            break;
        }
    }

    function addLinesSwitcher(str) {
        switch (str) {
        case "ins_useless" : window.children[3].children[1].strId = 1;
            break;
        case "ins_ifTreeNull" : window.children[3].children[1].strId = 3;
            break;
        case "ins_newElem" : window.children[3].children[1].strId = 5;
            break;
        case "ins_elemValAssign" : window.children[3].children[1].strId = 9;
            break;
        case "ins_ifKeyMore" : window.children[3].children[1].strId = 12;
            break;
        case "ins_ifLeft" : window.children[3].children[1].strId = 13;
            break;
        case "ins_ifRight" : window.children[3].children[1].strId = 15;
            break;
        case "ins_newElemAssign" : window.children[3].children[1].strId = 6;
            break;
        }
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

                if(n == "codeline") {
                    if(v[0] == 'f') {
                        findLinesSwitcher(v);
                    } else {
                        addLinesSwitcher(v);
                    }

                }

                if(n == "codeline" && v == "find_finded") {
                    M.getElem(hId).startTwink();
                }

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
