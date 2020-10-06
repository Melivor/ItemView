import QtQuick 2.12
import QtQuick.Controls 2.12



ComboBox {
    property var rootModel: parent.dmodel
     property string toolTip: rootModel.description?rootModel.description:""
    property var value:rootModel.display
    function post(){
        rootModel.display=value
    }
    function cancel(){
        value=rootModel.display
    }

    id:comboBox
    horizontalAlignement: Text.AlignLeft
    implicitHeight: 30
    implicitWidth: 110
    model:rootModel.choiceList
    currentIndex:value
    onActivated: {
        value=index
        post()
    }
}

