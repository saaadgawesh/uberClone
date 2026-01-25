import '../../../../core/App_Imports/app_imports.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Insets.s20.sp),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SuccessAuthState) {
                    context.pushReplacementNamed(Routes.navbar);
                  }

                  if (state is ErrorAuthState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                      final isLoading = state is LoadingAuthState;
                    if (state is LoadingAuthState) {

                      return const LoadingIndicator();
                    }

                    return BuildLoginForm(
                        isLoading: isLoading,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: _formKey,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
