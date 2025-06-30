import 'dart:io';
import 'dart:typed_data'; // ✅ untuk Uint8List
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../main.dart'; // akses supabase global

class SupabaseService {
  // ============================
  // ====  Uploading Files  ====
  // ============================

  /// Versi universal: upload file dari web & mobile (pakai Uint8List)
  Future<String> uploadFile({
    required String bucketName,
    required String filePath,
    required Uint8List fileBytes, // ✅ tipe diperbaiki
  }) async {
    await supabase.storage.from(bucketName).uploadBinary(
          filePath,
          fileBytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

    return supabase.storage.from(bucketName).getPublicUrl(filePath);
  }

  /// Opsional: Versi mobile (pakai File), wrapper dari uploadFile
  Future<String> uploadFileFromMobile({
    required File file,
    required String bucketName,
    required String filePath,
  }) async {
    final bytes = await file.readAsBytes();
    return uploadFile(
      bucketName: bucketName,
      filePath: filePath,
      fileBytes: Uint8List.fromList(bytes), // ✅ pastikan dikonversi ke Uint8List
    );
  }

  /// Opsional: Versi web langsung (pakai Uint8List)
  Future<String> uploadFileBytes({
    required Uint8List bytes,
    required String bucketName,
    required String filePath,
  }) async {
    return uploadFile(
      bucketName: bucketName,
      filePath: filePath,
      fileBytes: bytes,
    );
  }

  // ============================
  // ====     Notes CRUD     ====
  // ============================

  Future<List<Map<String, dynamic>>> getNotes() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('notes')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return data;
  }

  Future<void> addNote({
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase.from('notes').insert({
      'user_id': userId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
    });
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    final updates = {
      'title': title,
      'content': content,
      'image_url': imageUrl,
    };
    await supabase.from('notes').update(updates).eq('id', id);
  }

  Future<void> deleteNote(int id) async {
    await supabase.from('notes').delete().eq('id', id);
  }

  // ============================
  // ====  User Profile     ====
  // ============================

  Future<Map<String, dynamic>?> getProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('profiles').select().eq('id', userId).single();
    return data;
  }

  Future<void> updateProfile({
    required String username,
    String? avatarUrl,
  }) async {
    final userId = supabase.auth.currentUser!.id;
    final updates = {
      'id': userId,
      'username': username,
      'avatar_url': avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    };
    await supabase.from('profiles').upsert(updates);
  }
}
