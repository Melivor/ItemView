import QtQuick 2.12
import QtQuick.Controls 2.13
//
import QtQuick.Layouts 1.12
import "Items"

ListView {
    id:listView
    signal editingSetting(var index)
    orientation: Qt.Vertical
    boundsBehavior: Flickable.StopAtBounds
    clip:true
    property bool editable:true
    height:contentHeight
    ScrollBar.vertical:ScrollBar{
        policy: listView.height>=listView.contentHeight?ScrollBar.AlwaysOff:ScrollBar.AlwaysOn
    }
    Control{
        id:control
    }

    delegate:
        Item{
        id:containerItem
        enabled: loader.item
        visible: enabled
        width: parent?parent.width:0
        height: enabled?loader.item.implicitHeight+10:0
        MouseArea{
            anchors.fill:containerItem
            hoverEnabled: true
            onEntered: {
                listView.editingSetting(model);
            }
            propagateComposedEvents: true;
            onPositionChanged: {
                mouse.accepted = false;
            }
            onClicked: mouse.accepted = false;
            onPressed: mouse.accepted = false;
            onReleased: mouse.accepted = false;
            onDoubleClicked: mouse.accepted = false;
            onPressAndHold: mouse.accepted = false;
        }
        RowLayout{
            id:delegateRow
            anchors.top:parent.top
            anchors.topMargin: 5
            width: parent.width
            enabled: loader.item
            visible: enabled
            height: enabled?loader.item.implicitHeight+10:0
            Text {
                function generateHeader(){
                    var r=listView.model.headerData(model.row,Qt.Vertical)
                    r+=": "
                    text=r
                }
                Layout.preferredHeight: loader.item?loader.item.implicitHeight:0
                Layout.preferredWidth:  100
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                verticalAlignment: Text.AlignVCenter
                Component.onCompleted:generateHeader()
                color:control.palette.text
            }
            Loader{
                id:loader
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                source:model.flags&Qt.ItemIsEnabled?"Items/"+model.qmlFile:""

                property var dmodel: model
            }
        }

    }
}

