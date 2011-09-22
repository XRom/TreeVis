import QtQuick 1.0
import "treeMachinery.js" as M

Rectangle {
    id: treeVis
    BorderImage { source: "Core/images/lineedit.sci"; anchors.fill: parent }

    function createTree() {
        M.treeRoot = null;
        M.insTree(5);
        M.insTree(6);
        M.insTree(4);
        M.insTree(3);

        viewTree();
    }

    function getX(left) {
        return 10 + 40 * left;
    }

    function getY(top) {
        return 10 + 60 * top;
    }

    function addElement(el) {
        M.insTree(el);

        viewTree();
    }

    function viewTree() {
        var h = M.getHeight();
        var mf = function(tree, top) {
            if (tree == null)
                return;
            if(tree.elem == null) {
                tree.elem = Qt.createComponent("TreeElement.qml").createObject(treeVis);
            }
            tree.elem.x = getX(Math.pow(2, top));
            tree.elem.y = getY(h - top);
            tree.elem.key = tree.key;
            f(tree.left, Math.pow(2, top) - Math.pow(2, top - 1), top - 1);
            f(tree.right, Math.pow(2, top) + Math.pow(2, top - 1), top - 1);
        }

        var f = function (tree, left, top) {
            if (tree == null) {
                //if(tree.elem == null) {
                //    var c = Qt.createComponent("NilElement.qml").createObject(treeVis);
                //}
                //c.x = getX(left);
                //c.y = getY(h - top);
                return;
            } else {
                if(tree.elem == null) {
                    tree.elem = Qt.createComponent("TreeElement.qml").createObject(treeVis);
                }

                if(tree.key == null) {
                    tree.elem.key = "NULL";
                } else {
                    tree.elem.key = tree.key;
                }

                tree.elem.x = getX(left);
                tree.elem.y = getY(h - top);

                if(tree.key == null) {
                    tree.elem.key = "NULL";
                } else if(tree.elem.key != tree.key) {
                    tree.elem.x = tree.elem.y = 0;
                }

                f(tree.left,  left - Math.pow(2, top - 1), top - 1);
                f(tree.right, left + Math.pow(2, top - 1), top - 1);
            }
        };
        mf(M.getTree(), h);
    }

    function calculateTreePos() {

    }

    Component.onCompleted: createTree()
}
