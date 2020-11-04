import QtQuick 2.12

Rectangle{
    id:rect
    property var model
    property int baseMargin: 10
    signal editingSetting(var index)
    color:palette.base
    border.color: palette.mid
    radius: 5
    implicitWidth: 200
    implicitHeight: 500
    property int unfoldHeight:0
    property int unfoldWidth:0
    property int sectionNamePointSize: 10
    //property int contentHeight: rect.model.sections.length*(rect.baseMargin*2+rect.baseMargin


    Flow{
        id:root
        anchors.top:parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin:  rect.baseMargin
        anchors.rightMargin:  rect.baseMargin
        anchors.topMargin:  rect.baseMargin
        flow:Flow.TopToBottom
        spacing:  rect.baseMargin*2

        Repeater {
            id:repeater
            model:rect.model.sections.length
            //anchors.fill:parent
            //width: parent.model.sectionNumber*250

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
                        text:rect.model.sections[index].name
                        font.pointSize: rect.sectionNamePointSize
                        color:palette.text
                    }
                    Rectangle{
                        //anchors.fill:advlistView
                        border.color: palette.mid
                        color: palette.alternateBase
                        radius: rect.radius
                        z:-1
                        implicitWidth:advListView.width+ 2*rect.baseMargin
                        implicitHeight: advListView.height+ 2*rect.baseMargin

                        ItemListView{
                            id:advListView
                            y: rect.baseMargin/2
                            x:rect.baseMargin
                            height: Math.min(contentHeight,root.height-100)
                            model:rect.model.sections[index]
                            width: Math.min(350,rect.width-rect.baseMargin*4)
                            Component.onCompleted: advListView.editingSetting.connect(rect.editingSetting)
                        }
                    }
                }
                Component.onCompleted: {
                    rect.unfoldWidth+=width
                    rect.unfoldHeight+=advListView.contentHeight
                    console.log("new unfold height is: ", rect.unfoldHeight)
                }
            }
        }
    }
}
