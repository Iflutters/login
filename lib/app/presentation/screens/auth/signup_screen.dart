// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_project/app/utils/helpers/email_valid.dart';

import '../../../utils/theme/theme_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custon_loading.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  /*==============================================================
    GlobalKey para validação do Formulario
  ===============================================================*/
  final _formKey = GlobalKey<FormState>();

  /*==============================================================
    Variaveis que serão usadas (Email e Password)
  ===============================================================*/
  String? fullName;
  String? phone;
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
                  margin: const EdgeInsets.only(top: 5, right: 15, left: 15).w,
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
                  margin: const EdgeInsets.only(left: 20, right: 20).w,
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
                      SizedBox(height: 10.w),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                color: greyColor,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().screenHeight / 50),
                      /*==============================================================
                        Campo de Nome Customizado
                      ===============================================================*/
                      CustomTextField(
                        hintText: 'Full Name',
                        icon: Icons.person,
                        textInputType: TextInputType.emailAddress,
                        onSaved: (text) => fullName = text,
                        validator: validatorFullName,
                      ),

                      /*==============================================================
                        Campo de Telefone Customizado
                      ===============================================================*/
                      CustomTextField(
                        hintText: 'Phone Number',
                        icon: Icons.phone_android,
                        textInputType: TextInputType.phone,
                        onSaved: (text) => phone = text,
                        validator: validatorPhone,
                      ),
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
                        Campo com a ação de Login
                      ===============================================================*/
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15).w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: greenLigthColor,
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ).w,),
                          onPressed: () async {
                            await signup();
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      /*==============================================================
                        Botão para a tela de Registro
                      ===============================================================*/
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20).w,
                        child: TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/login'),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      SizedBox(height: 20.w),
                    ],
                  ),
                ),
                SizedBox(height: 10.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validatorFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório.';
    } else if (!value.contains(' ')) {
      return 'Informe seu nome completo.';
    } else {
      return null;
    }
  }

  String? validatorPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório.';
    } else if (value.length < 6) {
      return 'Telefone inválido';
    } else {
      return null;
    }
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
  Função de Registro
=============================================*/
  Future<void> signup() async {
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
          title: const Text('Signup Realizado'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nome: $fullName',
                style:  TextStyle(fontSize: 12.sp),
              ),
              Text(
                'Telefone: $phone',
                style: TextStyle(fontSize: 12.sp),
              ),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 12.sp),
              ),
              Text(
                'Senha: $password',
                style: TextStyle(fontSize: 12.sp),
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
}
