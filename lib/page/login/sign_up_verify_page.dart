import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
final TextStyle _availableStyle = TextStyle(
  fontSize: 13.0,
  color: const Color(0xFF39cbe3),
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  fontSize: 13.0,
  color: const Color(0xFFB3B3B3),
);

class SignUpVerifyPage extends StatefulWidget {
  SignUpVerifyPage() {
  }
  String username;

  /// 倒计时的秒数，默认60秒。
  int countdown = 60;

  /// 用户点击时的回调函数。
  Function onTapCallback;

  /// 是否可以获取验证码，默认为`false`。
  bool available = true;

  @override
  _SignUpVerifyPageState createState() {
    return _SignUpVerifyPageState(this.username);
  }
}

class _SignUpVerifyPageState extends State<SignUpVerifyPage> {
  _SignUpVerifyPageState(String _Username) {
    this.Username = _Username;
  }
  String Username;
  TextField accountField;

  /// 倒计时的计时器。
  Timer _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = 'Resend code';

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.countdown;
        inkWellStyle = _availableStyle;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = 'Resend code $_seconds' + 's';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = 'Resend code';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          new IconButton(
            icon: Image.asset('assets/images/login/question.png',
                color: Color(0xff888888), width: 22, height: 22),
            onPressed: () {},
          )
        ],
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Image.asset('assets/images/login/nav-arrow-left.png',
              color: Color(0xff2A2A2A), width: 24, height: 24),
        ),
      ),
      body: _layoutSignUp(context),
    );
  }

  _layoutSignUp(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        height: 600,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            _getTitleText(),
            Text(
              "Your code was sent to $Username",
              style: TextStyle(color: Color(0xff888888), fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.blue.shade50,
              enableActiveFill: true,
              // errorAnimationController: errorController,
              // controller: textEditingController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  // currentText = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            SizedBox(
              height: 19,
            ),
            widget.available
                ? InkWell(
                    child: Text(
                      '$_verifyStr',
                      style: inkWellStyle,
                    ),
                    onTap: (_seconds == widget.countdown)
                        ? () {
                            _startTimer();
                            inkWellStyle = _unavailableStyle;
                            _verifyStr = 'resend code $_seconds' + 's';
                            setState(() {});
                            widget.onTapCallback();
                          }
                        : null,
                  )
                : InkWell(
                    child: Text(
                      'resend code',
                      style: _unavailableStyle,
                    ),
                  ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Didn't get a code?",
                      style: TextStyle(color: Color(0xff2A2A2A), fontSize: 13),
                ),
                InkWell(
                  child: Text(
                    ' Request phone call',
                    style: _availableStyle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 151,
            ),
            _getBottomLayout(context),
          ],
        ),
      ),
    );
  }

  _getTitleText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Text(
        "Enter 6-digit Code",
        style: TextStyle(color: Color(0xff2A2A2A), fontSize: 19, fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }

  _getBottomLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Text(
        "Login with password",
        style: TextStyle(color: Color(0xff2A2A2A), fontSize: 13),
      ),
    );
  }
}
