// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:login_project/app/utils/theme/theme_colors.dart';

class CustomLoading {
  /*==========================================================
    Funcion que verifica si hay estancias de Dialogs abiertas
    ===========================================================*/
  static show(BuildContext context,{ String? title}) async {
    if (context == null) return;

    _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

    /*==========================================================
    Verificadno se ya no tiene una instancia de Dialog Abierta,
    para no tener errores de ejecución de sobreponer instancias de DIALOG.
    ===========================================================*/
    if (_isThereCurrentDialogShowing(context) == false) {
       showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 30,
                bottom: MediaQuery.of(context).size.height / 30,
                left: 10,
                right: 10),
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    title ?? 'Aguarde Carregando...',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ),
                 const CircularProgressIndicator(
                  color: primaryColor,
                ),
              ],
            ),
          ));
        },
      );
    }
  }

  Future<void> dismiss(BuildContext context) async {
    /*==========================================================
        Verificadno se hay una instancia de Dialog Abiert para 
        poder cerrar
    ===========================================================*/
    _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
      
    if (_isThereCurrentDialogShowing(context) == true) {
      await Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    }
  }
}
