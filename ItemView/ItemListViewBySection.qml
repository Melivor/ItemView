import QtQuick 2.12
import QtQuick.Controls 2.12
Rectangle{
    Control{
        id:control
    }

    id:rect
    property var model
    property int baseMargin: 10
    signal editingSetting(var index)
    color:control.palette.base
    border.color: control.palette.mid
    radius: 0
    implicitWidth: 200
    implicitHeight: 500
    property int sectionNamePointSize: 8
    property int unfoldHeight:root.contentHeight+rect.baseMargin*2
    //property int contentHeight: rect.model.sections.length*(rect.baseMargin*2+rect.baseMargin

    ListView{
        id:root
        anchors.top:parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin:  rect.baseMargin
        anchors.rightMargin:  rect.baseMargin
        anchors.topMargin:  rect.baseMargin
        anchors.bottomMargin: rect.baseMargin
        //flow:Flow.TopToBottom
        spacing:  rect.baseMargin*2
        model:rect.model.sections
        clip:true
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical:ScrollBar{
            policy: root.height>=root.contentHeight?ScrollBar.AlwaysOff:ScrollBar.AlwaysOn
        }
        delegate:
            Item{
            //Layout.preferredHeight:childrenRect.height
            //Layout.preferredWidth:  childrenRect.width
            implicitHeight: childrenRect.height
            implicitWidth: childrenRect.width

            Column{
                spacing: rect.baseMargin
                Text{
                    id:label
                    text:modelData.name
                    font.pointSize: sectionNamePointSize
                    color:control.palette.text
                }
                Rectangle{
                    //anchors.fill:advlistView
                    border.color: control.palette.mid
                    color: control.palette.alternateBase
                    radius: rect.radius
                    z:-1
                    implicitWidth:advListView.width+ 2*rect.baseMargin
                    implicitHeight: advListView.height+ 2*rect.baseMargin

                    ItemListView{
                        id:advListView
                        y: rect.baseMargin/2
                        x:rect.baseMargin
                        height: Math.min(contentHeight,root.height-100)
                        model:modelData
                        width:rect.width-rect.baseMargin*5// Math.min(350,rect.width-rect.baseMargin*4)
                        Component.onCompleted: advListView.editingSetting.connect(rect.editingSetting)
                    }
                }
            }
        }
    }
}
