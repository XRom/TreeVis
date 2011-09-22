Список действий
===============

DoSequence -- это последовательность действий, наглядно описывающая работу со
структурой данных. Представляет из себе JSON структуру.


Команды
-------

> Здесь "nodeId" -- идентификатор элемента дерева

### sethigh "nodeId"
Тушит текущий подсвеченый элемент, подсвечивает "nodeId"

### sethighleft "nodeId"
Тушит текущий подсвеченый элемент, подсвечивает левую ссылку "nodeId"

### sethighright "nodeId"
Тушит текущий подсвеченый элемент, подсвечивает правую ссылку "nodeId"

### unhigh "nodeId"
Тушит текущий подсвеченый элемент

### codeline "codeLine"
Указывает подсвеченую строку в CodeView. Номер задаётся строкой-идентификатором

### shownode "nodeId"
Показывает ранее неотображенный элемент "nodeId" в правом верхнем углу

### movetohome "nodeId"
Вставляет "nodeId" на своё место в дереве, при этом перестраивает дерево (меняет
координаты существующих элементов), устанавливает ссылку из элемента родителя


Реальный пример
---------------
Пример добавления 5ки в стандартое дерево

    [
        [{
            "name": "codeline",
            "value": "ins_ifTreeNull"
        }],
        [{
            "name": "codeline",
            "value": "ins_ifKeyMore"
        }, {
            "name": "sethigh",
            "value": 1
        }],
        [{
            "name": "codeline",
            "value": "ins_ifKeyMoreElse"
        }],
        [{
            "name": "codeline",
            "value": "ins_ifRight"
        }, {
            "name": "sethighright",
            "value": 1
        }],
        [{
            "name": "codeline",
            "value": "ins_ifTreeNull"
        }],
        [{
            "name": "codeline",
            "value": "ins_ifKeyMore"
        }, {
            "name": "sethigh",
            "value": 2
        }],
        [{
            "name": "codeline",
            "value": "ins_ifLeft"
        }, {
            "name": "sethighleft",
            "value": 2
        }],
        [{
            "name": "codeline",
            "value": "ins_ifTreeNull"
        }],
        [{
            "name": "codeline",
            "value": "ins_newElem"
        }, {
            "name": "shownode",
            "value": 5
        }],
        [{
            "name": "codeline",
            "value": "ins_newElemAssign"
        }, {
            "name": "movetohome",
            "value": 5
        }],
        [{
            "name": "codeline",
            "value": "ins_elemValAssign"
        }],
        [{
            "name": "unhigh",
            "value": 0
        }, {
            "name": "codeline",
            "value": "ins_ifEnd"
        }],
        [{
            "name": "codeline",
            "value": "ins_funend"
        }],
        [{
            "name": "unhigh",
            "value": 0
        }, {
            "name": "codeline",
            "value": "ins_ifEnd"
        }],
        [{
            "name": "codeline",
            "value": "ins_funend"
        }],
        [{
            "name": "unhigh",
            "value": 0
        }, {
            "name": "codeline",
            "value": "ins_ifEnd"
        }],
        [{
            "name": "codeline",
            "value": "ins_funend"
        }]
    ]
