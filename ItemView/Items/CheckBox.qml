import QtQuick 2.12
import QtQuick.Controls 2.12
//Item{

//    implicitHeight: checkBox.height
//    implicitWidth:checkBox.width
    CheckBox {
        id:checkBox
        property bool editable: model.flags&Qt.ItemIsEditable
        property string toolTip: model.description?model.description:""
        property var initialValue
        property var model:parent.dmodel
        //anchors.right: parent.right
        //anchors.rightMargin: 10

       // implicitWidth:25+contentItem.width
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
            console.log("Clicked checkbox")
            checkState===Qt.Checked?model.display=true:model.display=false

        }

        //anchors.centerIn: parent
        Component.onCompleted: {
            initialValue=model.display
            console.log("Checkbox", height, width)
        }
    }
//}
