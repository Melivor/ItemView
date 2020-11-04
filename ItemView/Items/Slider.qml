import QtQuick 2.12
import QtQuick.Controls 2.12

Slider {
    property var model:parent.dmodel
    from:model.min
    to:model.max
    Component.onCompleted: value=model.display
    onMoved: {model.display=value}
    implicitWidth: 200
    //stepSize: 1
}
