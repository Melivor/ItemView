import QtQuick 2.12

NumberField
{
    validator: IntValidator{bottom:model.min;top:model.max}
    inputMethodHints: Qt.ImhDigitsOnly
    text:Number(model.display).toLocaleString(Qt.locale(),"f",0)
}
