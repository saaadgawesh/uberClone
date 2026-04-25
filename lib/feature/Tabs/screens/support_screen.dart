import '../../../core/App_Imports/app_imports.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  String _selectedType = 'inquiry';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'الدعم والاستفسارات',
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () => context.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppText(
              text: 'أرسل استفسارًا أو شكوى',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const VSpace(8),
            const CustomAppText(
              text: 'سيتم إرسال الرسالة مباشرة إلى تطبيق الأدمن للمتابعة.',
              textColor: AppColors.grey700,
            ),
            const VSpace(16),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('استفسار'),
                    selected: _selectedType == 'inquiry',
                    onSelected: (_) {
                      setState(() {
                        _selectedType = 'inquiry';
                      });
                    },
                  ),
                ),
                const HSpace(8),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('شكوى'),
                    selected: _selectedType == 'complaint',
                    onSelected: (_) {
                      setState(() {
                        _selectedType = 'complaint';
                      });
                    },
                  ),
                ),
              ],
            ),
            const VSpace(12),
            TextField(
              controller: _messageController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'اكتب تفاصيل رسالتك هنا',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: defaultElevatedButton(
          textbutton: _isSubmitting ? 'جارٍ الإرسال...' : 'إرسال',
          bgButtonColor: context.bgColor,
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
          onPressed: _isSubmitting ? () {} : _submitSupportRequest,
        ),
      ),
    );
  }

  Future<void> _submitSupportRequest() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      _showMessage('اكتب الرسالة أولًا');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showMessage('يجب تسجيل الدخول أولًا');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final riderDoc = await FirebaseFirestore.instance
          .collection('Rider')
          .doc(user.uid)
          .get();

      final riderName = (riderDoc.data()?['name'] ?? 'راكب').toString();

      await FirebaseFirestore.instance.collection('support_requests').add({
        'riderId': user.uid,
        'riderName': riderName,
        'type': _selectedType,
        'message': message,
        'status': 'open',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      _messageController.clear();
      _showMessage('تم إرسال رسالتك إلى الإدارة');
      context.pop();
    } catch (_) {
      if (!mounted) return;
      _showMessage('تعذر إرسال الرسالة حاليًا');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
