import QtQuick 1.0

Rectangle {
    id: mainCodeRectangle
    width: 180
    height: 200
    radius: 10
    anchors.margins: 5

    //Переменная для смены "кода" в окошке "кода"
    property int sId: 1

    property int strId: 0

  ListView {
        //Модель пустого листа
        ListModel {id: emptyListModel}

        //Строки для вставки
        ListModel {
            id: addListModel
            ListElement {
                //0
                line: "p := root;"
            }
            ListElement {
                //ins_useless
                line: "while (true) do "
            }
            ListElement {
                //2
                line: "begin"
            }
            ListElement {
                //ins_ifTreeNull
                line: "    if (p = nil) then "
            }
            ListElement {
                //4
                line: "    begin"
            }
            ListElement {
                // ins_newElem
                line: "        new(p);"
            }
            ListElement {
                //6 ins_newElemAssign
                line: "        p^.left := nil;"
            }
            ListElement {
                line: "        p^.right := nil;"
            }
            ListElement {
                //8
                line: "        p^.val := newValue;"
            }
            ListElement {
                //ins_elemValAssign
                line: "        exit;"
            }
            ListElement {
                //10
                line: "    end"
            }
            ListElement {
                line: "    else"
            }
            ListElement {
                //12 ins_ifKeyMore
                line: "        if (newValue < p^.val) then"
            }
            ListElement {
                //ins_ifLeft
                line: "            p := p^.left;"
            }
            ListElement {
                //14
                line: "        else "
            }
            ListElement {
                //ins_ifRight
                line: "            p := p^.right;"
            }
            ListElement {
                //16
                line: "end;"
            }
        }

        //И для поиска тоже строки!
        ListModel {
            id: findListModel
            ListElement {
                line: "p := root;"
            }
            ListElement {
                //property string strId: "find_ifTreeNull"
                line: "while (p <> nil) do"
            }
            ListElement {
                line: "begin"
            }
            ListElement {
                //property string strId: "find_uselessCheck"
                line: "    if (findValue = p^.val) then"
            }
            ListElement {
                line: "    begin"
            }
            ListElement {
                //property string strId: "find_ifRightElse"
                line: "        find := true;"
            }
            ListElement {
                //property string strId: "find_finded"
                line: "        exit;"
            }
            ListElement {
                line: "    end;"
            }
            ListElement {
                //property string strId: "find_ifTreeNullElse"
                line: "    if (findValue < p^.val) then"
            }
            ListElement {
                //property string strId: "find_Left"
                line: "        p := p^.left"
            }
            ListElement {
                line: "    else"
            }
            ListElement {
                //11property string strId: "find_Right"
                line: "        p := p^.right;"
            }
            ListElement {
                line: "    end;"
            }
            ListElement {
                //13property string strId: "find_TreeNull"
                line: "find := false;"
            }
        }
        //Норм кирпичей заготовил.

        //Делегат отображения элементов листа
        Component {
            id: codeDelegate
            Item {
                width: 190
                height: 16
                Text { text: line }
            }
        }

        id: codeList
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.topMargin: 5
        highlightFollowsCurrentItem : true

        delegate: codeDelegate
        //Подсветка
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
    }


    //свич "кода" в окошке "кода"
    onSIdChanged: {
        if (sId == 1) {
            codeList.model = emptyListModel;
        }
        if (sId == 2) {
            codeList.model = addListModel;
        }
        if (sId == 3) {
            codeList.model = findListModel;
        }
        //Всё это не очень хорошо, но работает
    }

    onStrIdChanged: {
        codeList.currentIndex = strId;
        //Это ВРОДЕ БЫ работает правильно,
        //Насколько оно вообще может работать правильно
        //Т к алгоритмы в окошке продукта и в treeMachinery.js разные
        //Но очень смешно выглядит в деле
        //Надо анимацию поковырять или чтото такое
    }
}

