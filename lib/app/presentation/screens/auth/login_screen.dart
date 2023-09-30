// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_project/app/presentation/widgets/custom_text_field.dart';
import 'package:login_project/app/presentation/widgets/custon_loading.dart';
import 'package:login_project/app/utils/helpers/email_valid.dart';

import '../../../utils/theme/theme_colors.dart';

class LoginScreem extends StatefulWidget {
  const LoginScreem({super.key});

  @override
  State<LoginScreem> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  /*==============================================================
    GlobalKey para validação do Formulario
  ===============================================================*/
  final _formKey = GlobalKey<FormState>();

  /*==============================================================
    Variaveis que serão usadas (Email e Password)
  ===============================================================*/
  String? email;
  String? password;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      /*==============================================================
        Safe Area para Inserir un escape de camera na ui
      ===============================================================*/
      
      body: SafeArea(
        /*==============================================================
          SingleChildScrollView resolve problemas de Owerflow
        ===============================================================*/
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /*==============================================================
                   Logo Inicial, pode ser Customizado Tranquilamente
                ===============================================================*/
                Container(
                  margin: const EdgeInsets.only(top: 15, right: 15, left: 15).w,
                  height: ScreenUtil().screenHeight / 5,
                  width: ScreenUtil().screenWidth,
                  child: Icon(
                    Icons.motion_photos_auto,
                    size: 120.w,
                    color: whiteColor,
                  ),
                ),
                /*==============================================================
                   Container Customizado con efeito de elevação
                ===============================================================*/
                Container(
                  margin: const EdgeInsets.all(20).w,
                  width: ScreenUtil().screenWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(85),
                      topRight: Radius.circular(3),
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(85),
                    ),
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black, //New
                          blurRadius: 20,
                          offset: Offset(0, 0))
                    ],
                  ),
                  /*==============================================================
                    Coluna de Informações Principal 
                  ===============================================================*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                color: greyColor,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().screenHeight / 16),
                      /*==============================================================
                        Campo de Email Customizado 
                      ===============================================================*/
                      CustomTextField(
                        hintText: 'E-mail',
                        icon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        onSaved: (text) => email = text,
                        validator: validatorEmail,
                      ),
                      /*==============================================================
                        Campo de Senha Customizado 
                      ===============================================================*/
                      CustomTextField(
                        hintText: 'Password',
                        icon: Icons.lock,
                        obscureText: isObscure,
                        validator: validatorPassword,
                        btnVisible: () {
                          if (isObscure) {
                            setState(() {
                              isObscure = false;
                            });
                          } else {
                            setState(() {
                              isObscure = true;
                            });
                          }
                        },
                        onSaved: (text) => password = text,
                      ),
                      /*==============================================================
                        Botão de Recuperação de Senha
                      ===============================================================*/
                      Container(
                        padding: const EdgeInsets.only(right: 12).w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => recoveryPass(),
                              child: Text(
                                'Recovery Password >',
                                style: TextStyle(
                                    color: greyColor,
                                    fontSize: 16.sp,
                                    decorationColor: greyColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*==============================================================
                        Campo com a ação de Login
                      ===============================================================*/
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20).w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: greenLigthColor,
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ).w,
                              ),
                          onPressed: () async {
                            await login();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.w),
                      /*==============================================================
                        Botão para a tela de Registro
                      ===============================================================*/
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20).w,
                        child: TextButton(
                            onPressed: () => Navigator.of(context).pushNamed('/signup'),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      SizedBox(height: 40.w),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório.';
    } else if (!value.isEmailValid()) {
      return 'Email inválido.';
    } else {
      return null;
    }
  }

  String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório.';
    } else if (value.length < 6) {
      return 'Obrigatório ao menos 6 caracteres.';
    } else {
      return null;
    }
  }

/*===========================================
  Função de Login
=============================================*/
  Future<void> login() async {
    /*===========================================
      FocusScope remove o teclado da tela
    =============================================*/
    FocusScope.of(context).unfocus();

    /*===========================================
      Verificando se o Formulario é valido!
    =============================================*/
    if (_formKey.currentState!.validate()) {
      CustomLoading.show(context);
      /*=============================================
      Salvando os dados informados nos campos em
      suas respectivas variaves (email e password)
    ===============================================*/
      _formKey.currentState!.save();

      /*=============================================
      Dilaogo para mostrar os dados de exemplo.
    ===============================================*/
      await Future.delayed(const Duration(seconds: 1));
      await CustomLoading().dismiss(context);
      
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Realizado'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Email: $email',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'Senha: $password',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
  }

/*===========================================
  Função de recuperar senha
=============================================*/
  void recoveryPass() {
    /*===========================================
      FocusScope remove o teclado da tela
    =============================================*/
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    if (email == null || email!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Insira um email, para recuperar sua senha',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Foi enviado um email para $email, verifique as instruções '
            'para recuperar sua senha',
          ),
        ),
      );
    }
  }
}
