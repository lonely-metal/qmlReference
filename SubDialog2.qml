/*
  210408:
  これまで使ってきたstateによる画面遷移と、画像ボタン押下の動作確認

  ３つの画像をボタン押下で切り替え
*/
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12    // 追加

Window {
    width: 640
    height: 480
    visible: sub2Visible

    Rectangle{
        id : rect
        anchors.fill: parent
        state: "FirstColor"

        MouseArea{
            anchors.fill: parent
            onClicked:{
                switch(rect.state){
                case "FirstColor":
                    rect.state = "SecondColor"
                    break
                case "SecondColor":
                    rect.state = "FirstColor"
                    break
                }
            }
        }
        states:[
            State{
                name: "FirstColor"
                PropertyChanges{
                    target: rect
                    color: "#EEEEFF"
                }
            },
            State{
                name: "SecondColor"
                PropertyChanges{
                    target: rect
                    color: "#EEFFEE"
                }
            }
        ]
    }

    Rectangle {
        id:rectangle1
        width: 300
        height: 200
        property int i: 0
        state:"state1"

        Image1 {    // Image1.qml
            id:image1
            visible:false
            anchors.fill: parent
            x: 10
            y: 10
            //width:400
            //height:201
            MouseArea {
                property int j: 0
                id: mouse_area1
                anchors.fill: parent
                onClicked:{
                    if (rectangle1.state == "state1")
                       rectangle1.state = "state2"
                    else
                       rectangle1.state = "state1"
                    console.log(rectangle1.state)
                }
            }
        }
        Image {
            id:image2
            visible:false
            anchors.fill: parent
            x: 10
            y: 10
            //width:360
            //height:270
            source: "images/35673322.2280836.jpg"
            MouseArea {
                property int j: 0
                id: mouse_area2
                anchors.fill: parent
                onClicked:{
                    if (rectangle1.state == "state2")
                       rectangle1.state = "state3"
                    else
                       rectangle1.state = "state2"
                    console.log(rectangle1.state)
                }
            }
        }
        Image {
            id:image3
            visible:false
            anchors.fill: parent
            x: 10
            y: 10
            //width:600
            //height:300
            source: "images/EkiYfS4VMAEIDI5.jpg"
            MouseArea {
                property int j: 0
                id: mouse_area3
                anchors.fill: parent
                onClicked:{
                    if (rectangle1.state == "state3")
                       rectangle1.state = "state1"
                    else
                       rectangle1.state = "state3"
                    console.log(rectangle1.state)
                }
            }
        }

        states: [
            State {
                name: "state1"
                PropertyChanges {
                    target: image1
                    visible:true
                }
            },
            State{
                name: "state2"
                PropertyChanges {
                    target: image2
                    visible:true
                }
            },
            State{
                name: "state3"
                PropertyChanges {
                    target: image3
                    visible:true
                }
            }
        ]
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
                sub2Visible = false
            }
        }
    }
}
