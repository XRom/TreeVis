var treeRoot;

//function treeCon(key, parent) {
//    return {"key": key, "parent": parent, "left": null, "right": null, "elem": null};
//}

function newLeaf(parent, key, left, right, elem) {
    return {"key": key, "parent": parent, "left": left, "right": right, "elem": elem};
}

function stepCon(type, code, msg, key, act, undo) {
    return {"type": type,
            "msg": msg,
            "code": code,
            "key": key,
            "act": act,
            "undo": undo};
}

function initTree() {
    treeRoot = newLeaf(null, null, null, null, null);
}

function insTree(key) {

    var algoList

    var f = function (tree, up) {
        if(tree == null) {
            tree = newLeaf(null, null, null, null, null);
        } else if (tree.key == null) {
            tree.key = key;
            tree.left = newLeaf(tree, null, null, null, null);
            tree.right = newLeaf(tree, null, null, null, null)
        } else if (tree.key > key)
            tree.left = f(tree.left, tree); 
        else if (tree.key < key)
            tree.right = f(tree.right, tree);

        return tree;
    }

    treeRoot = f(treeRoot, null);
}

function getTree() {
    return treeRoot;
}

function getHeight() {
    var f = function(tree) {
        if (tree.key == null)
            return 0;
        else
            return 1 + Math.max(f(tree.left), f(tree.right));
    }

    return f(treeRoot);
}

function getElem() {
    var
}


