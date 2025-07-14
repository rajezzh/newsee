import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_constants.dart';
import 'package:newsee/feature/creatempin/presentation/bloc/mpin_bloc.dart';
import 'package:newsee/feature/creatempin/presentation/bloc/mpin_event.dart';
import 'package:newsee/feature/creatempin/presentation/bloc/mpin_state.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/login_mpin.dart';

void createMpin(BuildContext context) {
  showModalBottomSheet(

    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
    return SizedBox(
      height: 500,
      width: 350,
      child: BlocProvider(
        create: (_) => MpinBloc(),
        child: const CreateMpinPage(),
      ),
    );
  },

    );
  }


class CreateMpinPage extends StatelessWidget {
  const CreateMpinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
    
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: BlocConsumer<MpinBloc, MpinState>(
            listener: (context, state) async {
              if (state.status == SaveStatus.success) {

              // Save MPIN to SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('user_mpin', state.mpin.join());
                print("MPIN saved successfully: ${state.mpin.join()}");

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('MPIN created successfully')),
                );

                Future.delayed(const Duration(seconds: 3), () {
                 mpin(context);
                 
                });
                // Navigate to MPIN login page
                if (state.mpin.isNotEmpty) {
                  context.pop(); 
                  mpin(context);
                  
                }
              } else if (state.status == SaveStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Set new 4 digit MPIN',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        for (int i = 0; i < value.length; i++) {
                          context.read<MpinBloc>().add(UpdateMpin(i, value[i]));
                        }
                      },
                    pinTheme: mpinTheme(size),
                    ),
                    const SizedBox(height: 24),
                    const Text(  
                      'Confirm new 4 digit MPIN',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        for (int i = 0; i < value.length; i++) {
                          context.read<MpinBloc>().add(UpdateConfirmMpin(i, value[i]));
                        }
                      },
                        pinTheme: mpinTheme(size),

                    ),
                    const SizedBox(height: 40),
                    Center(
                      
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 2, 59, 105),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(230, 40),
                        ),
                        onPressed: state.status == SaveStatus.loading
                            ? null
                            : () {
                                context.read<MpinBloc>().add(SubmitMpin());
                              },
                        child: state.status == SaveStatus.loading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Create"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  PinTheme mpinTheme(Size size) {
    return PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: size.height * 0.06,
                    fieldWidth: size.width * 0.15,
                    borderWidth: 0,
                    activeColor: Colors.black,
                    selectedColor: Colors.black,
                    inactiveColor: Colors.black26,
                  );
  }
}
