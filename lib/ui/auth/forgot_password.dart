import 'package:final_project/services/api/api_user.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pic/bg_login.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: Image.asset(
                  "assets/pic/icon_lettutor.png",
                  width: 150,
                  height: 150,
                ),
              ),
              const Text(
                "Lettutor",
                style: TextStyle(
                  fontSize: 35,
                  color: Color.fromARGB(255, 7, 81, 208),
                  fontFamily: "MyFont",
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ĐỊA CHỈ EMAIL',
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'mail@example.com',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Viền bo tròn
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10.0), // Bo tròn góc
                          color:
                              const Color.fromARGB(255, 3, 117, 210), // Màu nền
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (emailController.text == "") {
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: "Vui lòng nhập đầy đủ thông tin",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            } else {
                              var dataResponse = await UserFunctions
                                  .forgotPassword(emailController.text.trim());

                              bool isSuccess =
                                  dataResponse['isSuccess'] as bool;

                              if (!isSuccess) {
                                showTopSnackBar(
                                  // ignore: use_build_context_synchronously
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: "Xác thực email không thành công!",
                                  ),
                                  displayDuration: const Duration(seconds: 0),
                                );
                              } else {
                                showTopSnackBar(
                                  // ignore: use_build_context_synchronously
                                  Overlay.of(context),
                                  const CustomSnackBar.success(
                                    message: "Xác thực email thành công!",
                                  ),
                                  displayDuration: const Duration(seconds: 0),
                                );
                              }
                            }
                          },
                          child: const Center(
                            child: Text(
                              'LÂY LẠI MẬT KHẨU',
                              style: TextStyle(
                                color: Colors.white, // Màu chữ
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Đã có tài khoản?",
                              style: TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Đăng nhập',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
