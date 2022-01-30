import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    width: 600
    height: 400
    visible: sub1Visible

    Rectangle{
        id: header
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 50
        color: "#eeeeee"
    }
    Rectangle{
        id: middle
        anchors{
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: footer.top
        }
        Image{
            id: image01
            rotation: 180   // 180度回転
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 8
            }
            source: "image://imagedata/evening3.jpg";
            //source: "image://imagedata/hayashida-risa-1024x576.jpg";
        }
        Label{
            id: message
            anchors{
                verticalCenter: parent.verticalCenter
                left: image01.right
                right: parent.right
            }
            text: "Everything's gonna be alright."
            font.pixelSize: 24
        }
    }
    Rectangle{
        id: footer
        anchors{
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 50
        color: "#cccccc"

        Button{
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 20
            }
            text: "Quit"
            onClicked:{
                sub1Visible = false
            }
        }
    }
}
