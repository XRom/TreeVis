Qt.include("json2.js");

//корешок
var treeRoot;
//Тут хранятся элементы дерева
var registry = [];
//Эта переменная хранит число элементов плюс единица
var ids = 1;
//Это будет скормлено таймеру в TreeVis.qml
var gSeq = [];

function createBind(target, prop, when, value) {
    var str = "import QtQuick 1.0; Binding {";
    str += "target: " + target + "; ";
    str += "property: \"" + prop + "\"; ";
    str += "when: " + when + "; ";
    str += "value: " + value + "} ";

    bind = Qt.createQmlObject(str);
}

function newLeaf(parent, key, left, right, elem) {
    var element = {"key": key, "parent": parent, "left": left,
                   "right": right, "elem": elem, "id": ids++};
    return element;
}

//генерация объекта шага последовательности
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
                     stepCon("codeline", "ins_useless"),
                 ]);
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
//        seq.push([
//                     stepCon("sethigh", tree.id),
//                     stepCon("codeline", "ins_ifEnd")
//                 ]);
//        seq.push([
//                     stepCon("sethigh", tree.id),
//                     stepCon("codeline", "ins_funend")
//                 ]);
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
                //Бесполезная проверка
                //Нужна т.к. тут алгоритм рекурсивный
                //А в тз и интерфейсе - итеративный
                //Я спокоен и не матерюсь.
                if (tree.key == key) {
                    seq.push([
                                 stepCon("codeline", "find_uselessCheck"),
                             ]);
                }
            }
//            seq.push([
//                         stepCon("sethigh", tree.id),
//                         stepCon("codeline", "find_ifEnd")
//                     ]);
//            seq.push([
//                         stepCon("sethigh", tree.id),
//                         stepCon("codeline", "find_funend")
//                     ]);
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

//Выдёргивает элемент по его id
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

//Считает положения элементов и стрелок в окне программы
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

        //КОСТЫЛЬ
        var x = getX(x + result / 2);
        var y = getY(y);

        tree.elem.x = x;
        tree.elem.y = y;

        var parent = tree.parent;
        if(parent != null) {
            var connector = (parent.left == tree) ? parent.leftConnector : parent.rightConnector;
            if(connector != null) {
                connector.endX = x + tree.elem.height / 2;
                connector.endY = y;
            }
        }

        if(tree.leftConnector != null) {
            tree.leftConnector.startX = x + 5;
            tree.leftConnector.startY = y + tree.elem.height - 5;
        }

        if(tree.leftNullPointer != null) {
            tree.leftNullPointer.startX = x + 5;
            tree.leftNullPointer.startY = y + tree.elem.height - 5;
        }

        if (tree.rightConnector != null) {
            tree.rightConnector.startX = x + tree.elem.width - 5;
            tree.rightConnector.startY = y + tree.elem.height - 5;
        }

        if(tree.rightNullPointer != null) {
            tree.rightNullPointer.startX = x + tree.elem.width - 5;
            tree.rightNullPointer.startY = y + tree.elem.height - 5;
        }
        return result;
    }
    sizes(treeRoot, 0, 0);
}

//отрисовывает элементы
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

//отрисовывает стрелки, которые добавлены в элемент дерева. если что их можно подсветить
function showArrows(canvas) {
    //Костыль
    var f = function(tree) {
        if(tree == null) {
            return;
        }

        if(tree.left != null) {
            if(tree.leftNullPointer != null) {
                tree.leftNullPointer.destroy();
            }
            if(tree.leftConnector == null) {
                tree.leftConnector = Qt.createComponent("TreeConnector.qml").createObject(canvas);
            }
        } else {
            if(tree.leftNullPointer == null) {
                tree.leftNullPointer = Qt.createComponent("TreeNullPointer.qml").createObject(canvas);
            }
        }

        if(tree.right != null) {
            if(tree.rightNullPointer != null) {
                tree.rightNullPointer.destroy();
            }
            if(tree.rightConnector == null) {
                tree.rightConnector = Qt.createComponent("TreeConnector.qml").createObject(canvas);
            }
        } else {
            if(tree.rightNullPointer == null) {
                tree.rightNullPointer = Qt.createComponent("TreeNullPointer.qml").createObject(canvas);
            }
        }

        f(tree.left);
        f(tree.right);
    }
    f(treeRoot);
}

function clearTree() {
    var ct = function(tree) {
        if (tree == null || tree.elem == null)
            return;
        ct(tree.left);
        ct(tree.right);
        tree.elem.destroy();

        if(tree.leftConnector != null) {
            tree.leftConnector.destroy();
        }

        if (tree.rightConnector != null) {
            tree.rightConnector.destroy();
        }

        if(tree.leftNullPointer != null) {
            tree.leftNullPointer.destroy();
        }

        if (tree.rightNullPointer != null) {
            tree.rightNullPointer.destroy();
        }

        tree = null;
    };

    ct(treeRoot);
    treeRoot = null;
}
