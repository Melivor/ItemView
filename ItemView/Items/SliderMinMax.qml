import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
Item{
    property var model:parent.dmodel
    implicitHeight: slider.implicitHeight+row.implicitHeight
    implicitWidth: slider.implicitWidth+row.implicitWidth
    Slider {
        id:slider

        from:model.min
        to:model.max
        value:model.display
        //Component.onCompleted: value=model.display
        onMoved: {model.display=value}
        implicitWidth: 200
//        Component.onCompleted:{
//            if(model.display>model.max){
//                model.max=model.display
//            }

//            if(model.display<model.min){
//                model.min=model.display
//            }


//        }
        //stepSize: 1
    }
    RowLayout{
        id:row
        implicitHeight: 15
    width:slider.width
    anchors.top:slider.bottom

    TextField{
        id:minInput
        Layout.alignment: Qt.AlignLeft
        placeholderText: "Min"
        validator: DoubleValidator{}
        text:model.min.toLocaleString(Qt.locale(), 'f', 3)
        implicitWidth: slider.implicitWidth/3
        onEditingFinished:{
           model.min=Number.fromLocaleString(text)
        }

        Component.onCompleted:{
//            if(model.display<model.min){
//                model.min=model.display
//            }

//            text=model.min.toLocaleString()
        }

    }
    TextField{
        id:valueField
        Layout.alignment: Qt.AlignLeft
        placeholderText: "Value"
        validator: DoubleValidator{}
        text:model.display.toLocaleString(Qt.locale(), 'f', 3)
        implicitWidth: slider.implicitWidth/3
        onEditingFinished:{
           model.display=Number.fromLocaleString(text)
        }

    }
    TextField{
        id:maxInput
        Layout.alignment: Qt.AlignRight
        placeholderText: "Max"
        validator: DoubleValidator{}
        implicitWidth: slider.implicitWidth/3
        text:model.max.toLocaleString(Qt.locale(), 'f', 3)
        Component.onCompleted:{
//            if(model.display>model.max){
//                model.max=model.display
//            }
//            text=model.max.toLocaleString()

        }
        onEditingFinished: {

            model.max=Number.fromLocaleString(text)
           // text=model.max.toLocaleString(Qt.locale(), 'f', 3)
        }
    }
    }


}
