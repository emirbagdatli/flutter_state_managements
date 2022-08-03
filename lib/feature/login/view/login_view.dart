import 'package:flutter/material.dart';
import 'package:flutter_state_managements/feature/login/viewModel/login_view_model.dart';
import 'package:flutter_state_managements/product/constants/image_enum.dart';
import 'package:flutter_state_managements/product/padding/page_padding.dart';
import 'package:flutter_state_managements/product/utility/input_decorations.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../product/model/state/user_context.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String rememberText = 'Remember me?';
  final String loginText = 'Login';
  final String nameText = 'Name';

  late final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    print(context.read<UserContext?>()?.name);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loginViewModel,
      builder: (context, child) {
        return _bodyView(context);
      },
    );
  }

  Scaffold _bodyView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _loadingWidget(),
      ),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            AnimatedContainer(
                duration: context.durationLow,
                height: context.isKeyBoardOpen ? 0 : context.dynamicHeight(0.25),
                width: context.dynamicWidth(0.5),
                child: ImageEnums.door.toImage),
            Text(loginText, style: context.textTheme.headline3),
            TextField(decoration: ProjectInputs(nameText)),
            ElevatedButton(
                onPressed: // context.watch<LoginViewModel>().isLoading
                    _loginViewModel.isLoading
                        ? null
                        : () {
                            //context.read<LoginViewModel>().controlTextValue();
                            _loginViewModel.controlTextValue();
                          },
                child: Center(child: Text(loginText))),
            CheckboxListTile(
              //value: _loginViewModel.isChecked,
              value: context.watch<LoginViewModel>().isChecked,
              title: Text(rememberText),
              onChanged: (value) {
                //_loginViewModel.checkBoxChanged(value ?? false);
                context.read<LoginViewModel>().checkBoxChanged(value ?? false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Selector<LoginViewModel, bool>(selector: (context, viewModel) {
      return viewModel.isLoading;
    }, builder: (context, value, child) {
      return value ? const Center(child: CircularProgressIndicator()) : const SizedBox();
    });

    // return Consumer<LoginViewModel>(builder: ((context, value, child) {
    //   return value.isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox();
    // }));
  }
}
