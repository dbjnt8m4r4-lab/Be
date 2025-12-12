import 'package:flutter/material.dart';

class TurnstileAuthWrapper extends StatefulWidget {
  final Widget child;
  final Function()? onVerified;
  final String siteKey;
  final String baseUrl;

  const TurnstileAuthWrapper({
    super.key,
    required this.child,
    this.onVerified,
    required this.siteKey,
    required this.baseUrl,
  });

  @override
  TurnstileAuthWrapperState createState() => TurnstileAuthWrapperState();
}

class TurnstileAuthWrapperState extends State<TurnstileAuthWrapper> {
  String? _token;
  final bool _isVerifying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_token == null) ...[
          SizedBox(
            height: 100, // Slightly taller to accommodate the widget
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified_user, color: Colors.grey),
                    const SizedBox(height: 8),
                    Text(
                      'Verification Required',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: () {
                        // Simulate verification for now
                        setState(() {
                          _token = 'mock_token';
                        });
                        widget.onVerified?.call();
                      },
                      child: const Text('Verify'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (_token != null) ...[
          const Icon(Icons.verified, color: Colors.green),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => setState(() => _token = null),
            child: const Text('Not you? Reset verification'),
          ),
          const SizedBox(height: 8),
        ],
        Opacity(
          opacity: _token != null ? 1.0 : 0.5,
          child: AbsorbPointer(
            absorbing: _token == null,
            child: widget.child,
          ),
        ),
      ],
    );
  }

  bool get isVerified => _token != null;
  String? get token => _token;
}
