import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/presentation/widgets/language_switch_button.dart';
import '../../../../core/presentation/widgets/theme_switch_button.dart';
import '../../../../gen/assets.gen.dart';
import '../enums/login_field_type.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';
import '../widgets/admin_text_field.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;
    final messageKey = switch (authState) {
      AuthUnauthenticated(:final messageKey) => messageKey,
      _ => null,
    };

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: loginMaxWidth,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(pagePadding),
                  child: AutofillGroup(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(rXl),
                            child: Assets.icons.logo.image(
                              width: icon90,
                              height: icon90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: sectionGap),
                        Text(
                          'login.title'.tr(),
                          style: Theme.of(context).textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: sectionGap),
                        if (messageKey != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: contentGap,
                            ),
                            child: Text(
                              messageKey.tr(),
                              style: bodyMedium.copyWith(color: RED),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        AdminTextField(
                          type: LoginFieldType.email,
                          controller: emailController,
                        ),
                        const SizedBox(height: contentGap),
                        AdminTextField(
                          type: LoginFieldType.password,
                          controller: passwordController,
                        ),
                        const SizedBox(height: sectionGap),
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => ref
                                    .read(authProvider.notifier)
                                    .login(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: contentGap,
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: progressIndicatorSize,
                                  width: progressIndicatorSize,
                                  child: CircularProgressIndicator(
                                    strokeWidth: progressStrokeWidth,
                                  ),
                                )
                              : Text('login.submit'.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: pagePadding,
            right: pagePadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThemeSwitchButton(),
                LanguageSwitchButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
