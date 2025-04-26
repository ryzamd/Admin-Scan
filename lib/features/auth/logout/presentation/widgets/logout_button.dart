import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/services/get_translate_key.dart';
import '../../../../../core/widgets/confirmation_dialog.dart';
import '../../../../../core/widgets/error_dialog.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/logout_event.dart';
import '../bloc/logout_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogoutButton extends StatelessWidget {
  final double width;
  final double height;
  
  const LogoutButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {

    final multiLanguage = AppLocalizations.of(context);

    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login,
            (route) => false,
          );
        } else if (state is LogoutFailure) {
          ErrorDialog.showAsync(
            context,
            title: multiLanguage.logoutFailedUPCASE,
            message: TranslateKey.getStringKey(multiLanguage, state.message),
          );
        }
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ConfirmationDialog.showAsync(
              context,
              title: multiLanguage.logoutButtonUPCASE,
              message: multiLanguage.logoutConfirmMessage,
              confirmText: StringKey.confirmButtonDialog,
              cancelText: StringKey.cancelButtonDialog,
              confirmColor: AppColors.alert,
              onConfirm: () {
                context.read<LogoutBloc>().add(LogoutButtonPressed());
              },
              onCancel: () {},
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: BlocBuilder<LogoutBloc, LogoutState>(
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.whiteCommon,
                      strokeWidth: 2,
                    ),
                  );
                }
                return Text(
                  multiLanguage.logoutButtonUPCASE,
                  style: TextStyle(
                    color: AppColors.whiteCommon,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}