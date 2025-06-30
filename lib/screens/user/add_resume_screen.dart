import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // kIsWeb
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
      final file = result.files.first;
      final fileExtension = file.extension?.toLowerCase();

      if (fileExtension == null || !['pdf', 'doc', 'docx', 'jpg', 'png'].contains(fileExtension)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('❌ Format file tidak didukung.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() {
        selectedFile = file;
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
      final storagePath = 'resume/$userId/$fileName';
      String fileUrl;

      if (kIsWeb) {
        if (selectedFile!.bytes == null) throw 'File tidak memiliki data bytes.';
        fileUrl = await SupabaseService().uploadFileBytes(
          bytes: selectedFile!.bytes!,
          bucketName: 'resume-files',
          filePath: storagePath,
        );
      } else {
        if (selectedFile!.path == null) throw 'File path tidak tersedia.';
        final file = File(selectedFile!.path!);
        fileUrl = await SupabaseService().uploadFileFromMobile(
          file: file,
          bucketName: 'resume-files',
          filePath: storagePath,
        );
      }

      if (fileUrl.isEmpty) throw 'Upload gagal: URL tidak valid';

      await supabase.from('resume').insert({
        'user_id': userId,
        'file_url': fileUrl,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      setState(() {
        selectedFile = null;
        isLoading = false;
      });

      // Tampilkan snackbar berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("✅ Resume berhasil diupload."),
          backgroundColor: Colors.green.shade600,
          duration: const Duration(seconds: 2),
        ),
      );

      // Setelah snackbar selesai muncul, kembali ke halaman sebelumnya
      await Future.delayed(const Duration(seconds: 2));
      if (mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

    } catch (e) {
      debugPrint('Upload Error: $e');
      if (!mounted) return;
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Upload gagal: $e'),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FF),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.upload_file, color: Colors.blueAccent, size: 48),
                const SizedBox(height: 12),
                const Text(
                  'Upload your CV or Resume\nand use it when applying for jobs',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.folder_open),
                  label: const Text("Pilih File CV/Resume"),
                ),
                if (selectedFile != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    selectedFile!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (isLoading || selectedFile == null) ? null : uploadFile,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.grey.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Upload Resume',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
