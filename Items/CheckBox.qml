import QtQuick 2.12
import "../../Style"
CheckBox {
    property bool editable: false
    property string toolTip: model.description?model.description:""
    property var initialValue
    property var model:parent.dmodel
    //visible: parent.delegateModel.enable?true:false

    function post(){
       // parent.delegateModel.display=value
    }
    function cancel(){
        model.display=initialValue
    }
    checkState: (model.display===true||model.display==="true")?Qt.Checked:Qt.Unchecked
    //enabled: (parent&&editable)?true:false

    onClicked: {
        checkState===Qt.Checked?model.display=true:model.display=false

    }

    //anchors.centerIn: parent
    Component.onCompleted: {
        initialValue=model.display
    }
}
