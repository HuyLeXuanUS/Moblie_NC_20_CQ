import 'package:final_project/utils/validate_email.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

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
                      const Text(
                        'PASSWORD',
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '********',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Viền bo tròn
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'REPASSWORD',
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: repasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '********',
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
                            if (emailController.text == '' ||
                                passwordController.text == '' ||
                                repasswordController.text == '') {
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: "Vui lòng nhập đầy đủ thông tin",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            } else if (!validateEmail(emailController.text)){
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: "Email không hợp lệ",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            } else if (passwordController.text.length < 6){
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: "Mật khẩu phải có ít nhất 6 ký tự",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            } else if (passwordController.text != repasswordController.text){
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: "Mật khẩu không khớp",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            } else {
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.success(
                                  message: "Đăng kí thành công",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            }
                          },
                          child: const Center(
                            child: Text(
                              'ĐĂNG KÍ',
                              style: TextStyle(
                                color: Colors.white, // Màu chữ
                                fontSize: 18,
                              ),
                            ),
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Center(
                            child: Text(
                              'QUAY LẠI',
                              style: TextStyle(
                                color: Colors.white, // Màu chữ
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
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
