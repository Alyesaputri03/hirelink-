import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../services/supabase_service.dart';

class AddResumeScreen extends StatefulWidget {
  const AddResumeScreen({super.key});

  @override
  State<AddResumeScreen> createState() => _AddResumeScreenState();
}

class _AddResumeScreenState extends State<AddResumeScreen> {
  PlatformFile? selectedFile;
  bool isLoading = false;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null) return;

    setState(() => isLoading = true);

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw 'User belum login';

      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${selectedFile!.name}';
      final filePath = 'resume/$userId/$fileName';

      final fileBytes = selectedFile!.bytes ??
          await File(selectedFile!.path!).readAsBytes();

      // Upload file ke bucket
      final fileUrl = await SupabaseService().uploadFileBytes(
        bytes: fileBytes,
        bucketName: 'resume-files',
        filePath: filePath,
      );

      debugPrint('File berhasil diupload ke: $fileUrl');

      // Simpan URL file ke tabel resume
      final insertResponse = await supabase.from('resume').insert({
        'user_id': userId,
        'file_url': fileUrl,
        'created_at': DateTime.now().toIso8601String(), // opsional
      }).select();

      debugPrint('Insert Response: $insertResponse');

      Get.snackbar('Sukses', 'Resume berhasil diupload');
      setState(() => selectedFile = null);
    } catch (e) {
      debugPrint('Upload Error: $e');
      Get.snackbar('Error', e.toString());
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Resume or CV'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Upload your CV or Resume and\nuse it when you apply for jobs',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: isLoading ? null : pickFile,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Upload a Doc/Docx/PDF',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        isLoading || selectedFile == null ? null : uploadFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Upload Resume'),
                  ),
                ),
                if (selectedFile != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    'File: ${selectedFile!.name}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
