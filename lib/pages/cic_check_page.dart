import 'package:flutter/material.dart';
import 'package:newsee/widgets/loader.dart';

/*
  @author     : akshayaa.p
  @date       : 16/07/2025
  @desc       : Stateless widget for CIC Check screen.
                - Displays Applicant and Co-Applicant CIBIL/CRIF check options.
                - Results toggle between "Check" and "View".
*/

class CicCheckPage extends StatelessWidget {
  const CicCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> applicantCibilCheck = ValueNotifier(false);
    final ValueNotifier<bool> applicantCrifCheck = ValueNotifier(false);
    final ValueNotifier<bool> coApplicantCibilCheck = ValueNotifier(false);
    final ValueNotifier<bool> coApplicantCrifCheck = ValueNotifier(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CIC Check'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.person, color: Colors.teal, size: 32),
                        SizedBox(width: 16),
                        Text(
                          'Applicant',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<bool>(
                      valueListenable: applicantCibilCheck,
                      builder: (context, cibilChecked, _) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: applicantCrifCheck,
                          builder: (context, crifChecked, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!cibilChecked) {
                                      presentLoading(context, 'Checking CIBIL...');
                                      await Future.delayed(const Duration(seconds: 2));
                                      dismissLoading(context);
                                      applicantCibilCheck.value = true;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 3, 9, 110),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(cibilChecked ? Icons.picture_as_pdf : Icons.check),
                                      const SizedBox(width: 8),
                                      Text(cibilChecked ? 'View CIBIL' : 'Check CIBIL'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!crifChecked) {
                                      presentLoading(context, 'Checking CRIF...');
                                      await Future.delayed(const Duration(seconds: 2));
                                      dismissLoading(context);
                                      applicantCrifCheck.value = true;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 3, 9, 110),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(crifChecked ? Icons.picture_as_pdf : Icons.check),
                                      const SizedBox(width: 8),
                                      Text(crifChecked ? 'View CRIF' : 'Check CRIF'),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.group, color: Colors.teal, size: 32),
                        SizedBox(width: 16),
                        Text(
                          'Co-Applicant',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<bool>(
                      valueListenable: coApplicantCibilCheck,
                      builder: (context, cibilChecked, _) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: coApplicantCrifCheck,
                          builder: (context, crifChecked, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!cibilChecked) {
                                      presentLoading(context, 'Checking CIBIL...');
                                      await Future.delayed(const Duration(seconds: 2));
                                      dismissLoading(context);
                                      coApplicantCibilCheck.value = true;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 3, 9, 110),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(cibilChecked ? Icons.picture_as_pdf : Icons.check),
                                      const SizedBox(width: 8),
                                      Text(cibilChecked ? 'View CIBIL' : 'Check CIBIL'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!crifChecked) {
                                      presentLoading(context, 'Checking CRIF...');
                                      await Future.delayed(const Duration(seconds: 2));
                                      dismissLoading(context);
                                      coApplicantCrifCheck.value = true;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 3, 9, 110),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(crifChecked ? Icons.picture_as_pdf : Icons.check),
                                      const SizedBox(width: 8),
                                      Text(crifChecked ? 'View CRIF' : 'Check CRIF'),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
