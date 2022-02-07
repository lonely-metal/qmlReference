import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: base
    width: 1024
    height: 480
    visible: true

    property bool sub1Visible: false
    property int strengthIndex: -1
    property bool sub2Visible: false
    property int labelCount: 0
    property int initIndex: 2

    signal buttonClicked()

    Flickable {
        id: flick1
        anchors.fill: parent
        width: base.width
        height: base.height
        clip: true
        boundsBehavior: Filckable.StopAtBounds
        contentHeight: 1200

        ScrollBar.vertical: ScrollBar {
            width: 20
        }
        Button {
            id: button1
            x:10; y:10
            width: 150
            text: MainClass.getTextFromCpp()
            onClicked: {
                buttonClicked()
            }
        }
        Label {
            id: label1
            anchors {
                top: button1.top
                left: button1.right
                leftMargin: 12
            }
            width: 50
            text: MainClass.readString
        }

        // textを<font></font>使って修飾
        Text {
            id: my_text
            anchors {
                top: button1.top
                left: label1.right
                leftMargin: 12
            }
            font.pixelSize:  30
            text: "<font color=\"#888888\">" + "Hello" + "</font>" + "World"
        }
        Timer{
            id: timer
            interval: 1000
            running: true
            repeat: true
            onTriggered: my_text.opacity = my_text.opacity === 0 ? 1 : 0
        }

        Loader {
            id: subWindow
        }
        Button {
            id: subWindowButton
            anchors {
                top: button1.top
                left: my_text.right
                leftMargin: 12
            }
            text: "Sub Window"
            onClicked: {
                console.log("onClicked")
                subWindow.source = "SubDialog.qml"
                base.sub1Visible = true
            }
        }
        TextField {
            id: textIn
            anchors {
                top: button1.top
                left: subWindowButton.right
                leftMargin: 12
            }
            width: 150
            height: 30
            echoMode: TextInput.Password    // パスワード入力
        }
        TextField {
            id: textFieldId
            anchors {
                top: button1.top
                left: textIn.right
                leftMargin: 12
            }
            width: 300
            height: 32
            text: "テキスト入力テストだぜ！"
            font.family: "Helvetica"
            font.pointSize: 12
            color: "blue"
            focus: true
        }


        Rectangle {
            id: rec1
            anchors {
                top: button1.bottom
                topMargin: 12
                //left: button1.left    これが有効だとアニメが動かない
            }
            width: 100; height: 10
            color: "red"
            NumberAnimation on x { to: 900; duration: 2000}//1000 }
        }
        Rectangle {
            id: rec2
            anchors {
                top: rec1.bottom
                topMargin: 12
                left: button1.left
            }
            width: 2
            height: 30
            color: "blue"
        }
        Rectangle {
            id: rec3
            anchors {
                top: rec2.top
                left: rec2.right
                leftMargin: 12
            }
            width: 30
            height: 2
            color: "navy"
        }
        Rectangle {
            id: rec4
            anchors {
                top: rec2.top
                left: rec3.right
                leftMargin: 12
            }
            width: 100
            height :20
            color: "lightblue"
            border{
                width: 1
                color: "black"
            }
        }

        Row {
            id: rowStrength
            anchors {
                top: rec2.bottom
                topMargin: 12
                left: rec2.left
            }
            spacing: 30
            Button {
                id: strengthButton1
                checked: true
                width: 150
                height: 40
                font.pixelSize: 24
                text: "Soft"
                checkable: true
                background: Rectangle {
                    border.width: 4
                    color: strengthButton1.checked ? "#0000FF" : "white"
                }
            }
            Button {
                id: strengthButton2
                checked: false
                width: strengthButton1.width
                height: strengthButton1.height
                font.pixelSize: strengthButton1.font.pixelSize
                text: "Normal"
                checkable: true
                background: Rectangle {
                    border.width: 4
                    color: strengthButton2.checked ? "#0000FF" : "white"
                }
            }
            Button {
                id: strengthButton3
                checked: false
                width: strengthButton1.width
                height: strengthButton1.height
                font.pixelSize: strengthButton1.font.pixelSize
                text: "Hard"
                checkable: true
                background: Rectangle {
                    border.width: 4
                    color: strengthButton3.checked ? "#0000FF" : "white"
                }
            }
        }
        ButtonGroup {
            id: buttonGroup
            buttons: rowStrength.children
            onClicked: {
                if (strengthButton1.checked) {
                    base.strengthIndex = 0
                } else if (strengthButton2.checked) {
                    base.strengthIndex = 1
                } else {
                    base.strengthIndex = 2
                }
                console.log("base.strengthIndex: " + base.strengthIndex)
            }
        }

        Button {
            id: quitButton
            anchors {
                top: rowStrength.top
                left: rowStrength.right
                leftMargin: 12
            }
            text: "Quit"
            onClicked: {
                Qt.quit()   // これだとアプリ全てが終了する
            }
        }

        Rectangle {
            id: gradientRectangle
            anchors {
                top: rowStrength.top
                left: quitButton.right
                leftMargin: 12
            }
            width: 100
            height: 70
            gradient: Gradient {
                stops: [
                    GradientStop { position: 0.0; color: "green" },
                    GradientStop { position: 1.0; color: "yellow" }]
            }
        }

        Rectangle {
            id: gradientRectangle2
            anchors {
                top: rowStrength.top
                left: gradientRectangle.right
                leftMargin: 12
            }
            width: 100
            height: 70
            gradient: Gradient {
                stops: [
                    GradientStop { position: 0.0; color: "pink" },
                    GradientStop { position: 1.0; color: "blue" }]
            }
        }

        // 初期値2から表示
        ComboBox {
            id: comboId
            property int comboIndex: base.initIndex
            onComboIndexChanged: {
                comboId.currentIndex = comboIndex
            }
            anchors {
                top: rowStrength.top
                left: gradientRectangle2.right
                leftMargin: 12
            }
            width: 100
            model: ["List0", "List1", "List2"]
            onCurrentIndexChanged:{
                //changeFunc(comboId.currentIndex)
            }
        }

        ButtonGroup {
            id:columnButtonGroup
            buttons: column.children
        }
        Column {
            id: column
            anchors {
                top: rowStrength.bottom
                topMargin: 12
                left: rowStrength.left
            }

            Button {
                id: columnButton1
                checked: true
                text: qsTr("button 1")
                checkable : true
                background: Rectangle {
                    color:columnButton1.checked ? "red" : "white"
                }
            }
            Button {
                id: columnButton2
                checked: true
                text: qsTr("button 2")
                checkable : true
                background: Rectangle {
                    color:columnButton2.checked ? "red" : "white"
                }
            }
            Button {
                id: columnButton3
                checked: true
                text: qsTr("button 3")
                checkable : true
                background: Rectangle {
                    color:columnButton3.checked ? "red" : "white"
                }
            }
        }

        // VariantTest
        Label {
            id: label2
            anchors {
                top: column.top
                left: column.right
                leftMargin: 12
            }
            text: MainClass.variantTest.judge + " : " + MainClass.variantTest.id + " : " + MainClass.variantTest.str
        }

        Loader {
            id: subWindow2
        }
        Button {
            id: subWindw2Button
            anchors {
                top: column.top
                horizontalCenter: parent.horizontalCenter
            }
            text: "Sub Window 2"
            onClicked: {
                console.log("onClicked")
                subWindow2.source = "SubDialog2.qml"
                base.sub2Visible = true
            }
        }
        BusyIndicator {
            id: busyIndicator
            anchors {
                top: column.bottom
                topMargin: 12
                left: rowStrength.left
            }
        }

        // startTimer用
        function labelCountFunc(count) {
            base.labelCount = count
        }
        Label {
            id: startTimerId
            anchors {
                top: busyIndicator.top
                left: busyIndicator.right
                leftMargin: 12
            }
            text: base.labelCount
        }

        Rectangle {
            id: heightTest
            anchors {
                top: busyIndicator.bottom
                topMargin: 12
                left: rowStrength.left
            }
            width: 200
            height: 1000
            color: "#DDEEFF"
        }
    }
}
