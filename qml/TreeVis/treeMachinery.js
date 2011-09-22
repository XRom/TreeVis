Qt.include("json2.js");

var treeRoot;
var registry = [];
var ids = 1;

//function treeCon(key, parent) {
//    return {"key": key, "parent": parent, "left": null, "right": null, "elem": null};
//}

function newLeaf(parent, key, left, right, elem) {
    var element = {"key": key, "parent": parent, "left": left,
                   "right": right, "elem": elem, "id": ids};
    registry.push({"id" : ids++, "element" : element});
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
                         stepCon("shownode", tree.id)
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
                     stepCon("unhigh", 0),
                     stepCon("codeline", "ins_ifEnd")
                 ]);
        seq.push([
                     stepCon("codeline", "ins_funend")
                 ]);
        return tree;
    }

    treeRoot = f(treeRoot, null);
    //console.log("\n");
    //console.log(JSON.stringify(seq));
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

    return null;
}


