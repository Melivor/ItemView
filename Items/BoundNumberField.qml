import QtQuick 2.12

NumberField
{
    validator: DoubleValidator{bottom:model.min;top:model.max}
}
