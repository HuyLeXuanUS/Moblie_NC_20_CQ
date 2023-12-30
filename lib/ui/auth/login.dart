import 'package:final_project/main.dart';
import 'package:final_project/ui/auth/register.dart';
import 'package:final_project/utils/validate_email.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/api/api_auth.dart';
import 'package:final_project/services/models/user/user_model.dart';
import 'package:final_project/services/api/token_manager.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    children: [
                      Column(
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('MẬT KHẨU'),
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            // Xử lí sự kiện quên mật khẩu
                          },
                          child: const Text('Quên mật khẩu?'),
                        ),
                      ),
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
                            // Xử lí sự kiện khi nút được nhấn
                            if (emailController.text == '' ||
                                passwordController.text == '') {
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: "Vui lòng nhập đầy đủ thông tin",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            } else if (!validateEmail(emailController.text)) {
                              showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: "Email không hợp lệ",
                                ),
                                displayDuration: const Duration(seconds: 0),
                              );
                            } else {
                              var dataResponse = await AuthFunctions.login(User(
                                  emailController.text,
                                  passwordController.text));
                              if (dataResponse['isSuccess'] == false) {
                                showTopSnackBar(
                                  // ignore: use_build_context_synchronously
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: "Email hoặc mật khẩu không đúng",
                                  ),
                                  displayDuration:
                                      const Duration(seconds: 0),
                                );
                                setState(() {});
                              } else {
                                if (!mounted) return;
                                await TokenManager.saveToken(dataResponse['token'].toString());
                                showTopSnackBar(
                                // ignore: use_build_context_synchronously
                                  Overlay.of(context),
                                  const CustomSnackBar.success(
                                    message: "Đăng nhập thành công",
                                  ),
                                  displayDuration: const Duration(seconds: 0),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyHomePage(),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Center(
                            child: Text(
                              'ĐĂNG NHẬP',
                              style: TextStyle(
                                color: Colors.white, // Màu chữ
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Hoặc tiếp tục với:',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromARGB(255, 3, 117, 210),
                                width: 1.0,
                              ),
                            ),
                            child: const Icon(
                              Icons.facebook,
                              color: Color.fromARGB(255, 3, 117, 210),
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              color: null,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/pic/icon_google.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromARGB(255, 3, 117, 210),
                                width: 1.0,
                              ),
                            ),
                            child: const Icon(
                              Icons.phone_android,
                              color: Color.fromARGB(255, 3, 117, 210),
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Chưa có tài khoản?",
                              style: TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text('Đăng kí',
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
