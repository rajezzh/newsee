import 'package:flutter/material.dart';
import 'package:newsee/widgets/success_bottom_sheet.dart';

class CheckPage extends StatelessWidget {
  final String title;

  const CheckPage(String s, {required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
                  _buildInfoRow(Icons.face, "Name", "Rajesh"),
                  _buildInfoRow(Icons.person, "Type", "Applicant | Existing Customer"),
                  _buildInfoRow(Icons.badge, "Product", "Kisan Credit Card"),
                  _buildInfoRow(Icons.badge, "CIF ID", "121212"),
                  _buildInfoRow(Icons.currency_rupee, "Loan Amount", "7,50,000"),
                  _buildInfoRow(Icons.location_on, "Location", "Chennai"),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 3, 9, 110),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        ),
                        ),
                    onPressed: () {
                        showSuccessBottomSheet(
                          context,
                          "Submitted",
                          "Lead ID : LEAD/202526/00008213",
                          "Lead details successfully submitted",
                          );
                           
                      },
                    child: Text('Push to LENDperfect'),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
