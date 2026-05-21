/*
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// The image_picker import has been removed.

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  bool _agreeToTerms = false;
  String? _openDropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0FFFF), Color(0xFFE0F7FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Icon(Icons.rocket_launch_outlined, color: Color(0xFF6A1B9A), size: 50),
                  const SizedBox(height: 16),
                  Text('Join GOराही as Courier!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                  const SizedBox(height: 8),
                  Text('Start your earning journey with us', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  const SizedBox(height: 32),
                  _buildStepper(),
                  const SizedBox(height: 32),
                  _buildDocumentsCard(),
                  const SizedBox(height: 24),
                  _buildAgreementCheckbox(),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                  _buildFooterText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Step(label: 'Basic Info', isCompleted: true),
        Expanded(child: Container(height: 2, color: const Color(0xFF4CAF50))),
        const _Step(label: 'Documents', number: '2', isActive: true),
      ],
    );
  }

  Widget _buildDocumentsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Required Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
          const SizedBox(height: 16),
          _buildDocumentUploadTile(icon: Icons.badge_outlined, title: 'Aadhaar Card'),
          const SizedBox(height: 12),
          _buildDocumentUploadTile(icon: Icons.credit_card_outlined, title: 'PAN Card'),
          const SizedBox(height: 12),
          _buildDocumentUploadTile(icon: Icons.directions_car_outlined, title: 'Driving License'),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadTile({required IconData icon, required String title}) {
    final bool isOpen = _openDropdown == title;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _openDropdown = isOpen ? null : title;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey[800]))),
                Text('Upload', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[600])),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            height: isOpen ? null : 0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera_alt_outlined),
                      title: const Text('Take Photo'),
                      onTap: () {
 No action
 },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library_outlined),
                      title: const Text('Choose from Gallery'),
                      onTap: () {
 No action
 },
                    ),
                    ListTile(
                      leading: const Icon(Icons.picture_as_pdf_outlined),
                      title: const Text('Upload PDF'),
                      onTap: () {
 No action
 },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (bool? value) => setState(() => _agreeToTerms = value ?? false),
          activeColor: const Color(0xFF6A1B9A),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I agree to the ',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            label: const Text('Back', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8E24AA), Color(0xFF1E88E5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton.icon(
              // MODIFIED: Added navigation logic here
              onPressed: () {
                // This will push the homepage onto the stack and remove all previous routes.
                Navigator.pushNamedAndRemoveUntil(context, '/homepage', (route) => false);
              },
              icon: const Text('🚀', style: TextStyle(fontSize: 16)),
              label: const Text('Create Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                shadowColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterText() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            children: [
              TextSpan(
                text: 'Sign In',
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/signin');
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Secure registration powered by GOराही', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final String label;
  final String? number;
  final bool isCompleted;
  final bool isActive;

  const _Step({required this.label, this.number, this.isCompleted = false, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? const Color(0xFF4CAF50) : (isActive ? const Color(0xFF6A1B9A) : Colors.grey.shade300),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(number ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isActive || isCompleted ? Colors.black87 : Colors.grey.shade600,
            fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
*/
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// The image_picker import has been removed.

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  bool _agreeToTerms = false;
  String? _openDropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0FFFF), Color(0xFFE0F7FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Icon(Icons.rocket_launch_outlined, color: Color(0xFF6A1B9A), size: 50),
                  const SizedBox(height: 16),
                  Text('Join GOà¤°à¤¾à¤¹à¥€ as Courier!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                  const SizedBox(height: 8),
                  Text('Start your earning journey with us', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  const SizedBox(height: 32),
                  _buildStepper(),
                  const SizedBox(height: 32),
                  _buildDocumentsCard(),
                  const SizedBox(height: 24),
                  _buildAgreementCheckbox(),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                  _buildFooterText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Step(label: 'Basic Info', isCompleted: true),
        Expanded(child: Container(height: 2, color: const Color(0xFF4CAF50))),
        const _Step(label: 'Documents', number: '2', isActive: true),
      ],
    );
  }

  Widget _buildDocumentsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Required Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
          const SizedBox(height: 16),
          _buildDocumentUploadTile(icon: Icons.badge_outlined, title: 'Aadhaar Card'),
          const SizedBox(height: 12),
          _buildDocumentUploadTile(icon: Icons.credit_card_outlined, title: 'PAN Card'),
          const SizedBox(height: 12),
          _buildDocumentUploadTile(icon: Icons.directions_car_outlined, title: 'Driving License'),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadTile({required IconData icon, required String title}) {
    final bool isOpen = _openDropdown == title;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _openDropdown = isOpen ? null : title;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey[800]))),
                Text('Upload', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[600])),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            height: isOpen ? null : 0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera_alt_outlined),
                      title: const Text('Take Photo'),
                      onTap: () { /* No action */ },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library_outlined),
                      title: const Text('Choose from Gallery'),
                      onTap: () { /* No action */ },
                    ),
                    ListTile(
                      leading: const Icon(Icons.picture_as_pdf_outlined),
                      title: const Text('Upload PDF'),
                      onTap: () { /* No action */ },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (bool? value) => setState(() => _agreeToTerms = value ?? false),
          activeColor: const Color(0xFF6A1B9A),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I agree to the ',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            label: const Text('Back', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8E24AA), Color(0xFF1E88E5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton.icon(
              // MODIFIED: Added navigation logic here
              onPressed: () {
                // This will push the homepage onto the stack and remove all previous routes.
                Navigator.pushNamedAndRemoveUntil(context, '/homepage', (route) => false);
              },
              icon: const Text('ðŸš€', style: TextStyle(fontSize: 16)),
              label: const Text('Create Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                shadowColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterText() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            children: [
              TextSpan(
                text: 'Sign In',
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/signin');
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Secure registration powered by GOà¤°à¤¾à¤¹à¥€', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final String label;
  final String? number;
  final bool isCompleted;
  final bool isActive;

  const _Step({required this.label, this.number, this.isCompleted = false, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? const Color(0xFF4CAF50) : (isActive ? const Color(0xFF6A1B9A) : Colors.grey.shade300),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(number ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isActive || isCompleted ? Colors.black87 : Colors.grey.shade600,
            fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}