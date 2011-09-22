Qt.include("json2.js");

var treeRoot;
var registry = [];
var ids = 1;
var gSeq = [];

function createBind(target, prop, when, value) {
    var str = "import QtQuick 1.0; Binding {";
    str += "target: " + target + "; ";
    str += "property: \"" + prop + "\"; ";
    str += "when: " + when + "; ";
    str += "value: " + value + "} ";

    bind = Qt.createQmlObject(str);
}


//function treeCon(key, parent) {
//    return {"key": key, "parent": parent, "left": null, "right": null, "elem": null};
//}

function newLeaf(parent, key, left, right, elem) {
    var element = {"key": key, "parent": parent, "left": left,
                   "right": right, "elem": elem, "id": ids++};
    return element;
}

function stepCon(name, value) {
    return {"name" : name, "value" : value};
}

function initTree() {
    treeRoot = null;
}

function insTree(key) {
    var seq = [];

    var f = function (tree, up) {                
        seq.push([
                     stepCon("codeline", "ins_ifTreeNull"),
                 ]);
        if (tree == null) {
            tree = newLeaf(up, key, null, null, null);
            seq.push([
                         stepCon("codeline", "ins_newElem"),
                         stepCon("shownode", tree.id),
                         stepCon("sethigh", tree.id)
                     ]);
            seq.push([
                         stepCon("codeline", "ins_newElemAssign"),
                         stepCon("movetohome", tree.id)
                     ]);
            seq.push([
                         stepCon("codeline", "ins_elemValAssign")
                     ]);
        } else {
            seq.push([
                         stepCon("codeline", "ins_ifKeyMore"),
                         stepCon("sethigh", tree.id)
                     ]);
            if (tree.key > key) {
                seq.push([
                             stepCon("codeline", "ins_ifLeft"),
                             stepCon("sethighleft", tree.id)
                         ]);
                tree.left = f(tree.left, tree);
            }
            else {
                seq.push([
                             stepCon("codeline", "ins_ifKeyMoreElse")
                         ]);
                seq.push([
                             stepCon("codeline", "ins_ifRight"),
                             stepCon("sethighright", tree.id)
                         ]);
                tree.right = f(tree.right, tree);
            }
        }
        seq.push([
                     stepCon("sethigh", tree.id),
                     stepCon("codeline", "ins_ifEnd")
                 ]);
        seq.push([
                     stepCon("sethigh", tree.id),
                     stepCon("codeline", "ins_funend")
                 ]);
        return tree;
    }

    treeRoot = f(treeRoot, null);

    // turn off lights
    seq.push([stepCon("unhigh", 0)]);

    //console.log("\n");
    //console.log(JSON.stringify(seq));
    gSeq = seq.reverse();
}


function findTree(key) {
    var seq = [];

    var f = function (tree) {
        seq.push([
                     stepCon("codeline", "find_ifTreeNull"),
                 ]);
        if (tree == null) {
            seq.push([
                         stepCon("codeline", "find_TreeNull"),
                     ]);
        } else {
            seq.push([
                         stepCon("codeline", "find_ifTreeNullElse"),
                         stepCon("sethigh", tree.id)
                     ]);
            if (tree.key > key) {
                seq.push([
                             stepCon("codeline", "find_Left"),
                             stepCon("sethighleft", tree.id)
                         ]);
                f(tree.left);
            } else {
                seq.push([
                             stepCon("codeline", "find_ifLeftElse"),
                         ]);
                if (tree.key < key) {
                    seq.push([
                                 stepCon("codeline", "find_Right"),
                                 stepCon("sethighright", tree.id)
                             ]);
                    f(tree.right);
                } else {
                    seq.push([
                                 stepCon("codeline", "find_ifRightElse"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "find_finded"),
                             ]);
                }
            }
            seq.push([
                         stepCon("sethigh", tree.id),
                         stepCon("codeline", "find_ifEnd")
                     ]);
            seq.push([
                         stepCon("sethigh", tree.id),
                         stepCon("codeline", "find_funend")
                     ]);
        }
    }

    // build seq
    f(treeRoot);

    // turn off lights
    seq.push([stepCon("unhigh", 0)]);

    gSeq = seq.reverse();
}
function getTree() {
    return treeRoot;
}

function getHeight() {
    var f = function(tree) {
        if (tree == null)
            return 0;
        else
            return 1 + Math.max(f(tree.left), f(tree.right));
    }

    return f(treeRoot);
}

function getElem(id) {    
    for (var i in registry) {
        if (registry[i].id == id)
            return registry[i].element;
    }

    console.log("getElem: no such id --", id);
    return null;
}

function getX(left) {
    return 10 + 40 * left;
}

function getY(top) {
    return 10 + 60 * top;
}

function rebuildTree(canvas) {

    var sz = function (tree) {
        if (tree == null)
            return 0;
        var left = sz(tree.left);
        var right = sz(tree.right);
        return left + right > 1 ? left + right : 1;
    }

    var sizes = function (tree, x, y) {
        if (tree == null)
            return 0;
        var left = sizes(tree.left, x, y + 1);
        var right, result;

        right = sizes(tree.right, x +  1.25 + left, y + 1);
        result = left + 1.25 + right;
        tree.elem.x = getX(x + result / 2);
        tree.elem.y = getY(y);

        return result;
    }

    sizes(treeRoot, 0, 0);
}

function showElems(canvas) {

    var mf = function(tree) {
        if (tree == null)
            return;
        if(tree.elem == null) {
            tree.elem = Qt.createComponent("TreeElement.qml").createObject(canvas);
            registry.push({"id" : tree.id, "element" : tree.elem});
            tree.elem.x = 10;
            tree.elem.y = 10;
        }
        tree.elem.key = tree.key;
        mf(tree.left);
        mf(tree.right);
    };

    mf(treeRoot);
}

function showArrows(canvas) {
    var f = function (tree) {
        if (tree == null)
            return;

        if (tree.left == null) {
            //tree.leftArrow.type = "null";
        } else {
            //tree.elem.left.anchors.bottom = tree.left.top;
            //tree.elem.left.anchors.left = tree.left.horizontalCenter;
        }

        if (tree.right == null) {
            //tree.rightArrow.type = "null";
        } else {
            //tree.rightArrow.anchors.bottom = tree.right.top;
            //tree.rightArrow.anchors.right = tree.right.horizontalCenter;
        }

        f(tree.left);
        f(tree.right);
    } // var f =

    f(treeRoot);
}
