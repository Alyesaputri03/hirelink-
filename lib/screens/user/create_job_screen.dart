import 'package:flutter/material.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  String jobType = 'Penuh Waktu';
  final jobTypes = ['Penuh Waktu', 'Paruh Waktu', 'Kontrak', 'Magang', 'Remote'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: const Text('Buat Lowongan Kerja'),
        backgroundColor: const Color(0xFF3A4DDE),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("📝 Informasi Lowongan",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 20),

                _buildField("Judul Pekerjaan", "Contoh: Frontend Developer"),
                const SizedBox(height: 14),

                _buildField("Nama Perusahaan", "Contoh: PT Teknologi Cemerlang"),
                const SizedBox(height: 14),

                _buildDropdown("Jenis Pekerjaan", jobType, jobTypes),
                const SizedBox(height: 14),

                _buildField("Lokasi", "Contoh: Jakarta, Indonesia"),
                const SizedBox(height: 14),

                _buildField("Rentang Gaji", "Contoh: Rp8.000.000 - Rp12.000.000"),
                const SizedBox(height: 14),

                _buildField("Kualifikasi / Persyaratan",
                    "- Minimal S1\n- Pengalaman 2 tahun\n- Mampu bekerja dalam tim",
                    maxLines: 4),
                const SizedBox(height: 14),

                _buildField("Deskripsi Pekerjaan",
                    "- Mengembangkan tampilan website\n- Kolaborasi dengan tim UI/UX dan Backend\n- Menulis kode yang bersih dan optimal",
                    maxLines: 5),
                const SizedBox(height: 14),

                _buildField("Kontak / Email HRD", "Contoh: hrd@company.com"),
                const SizedBox(height: 28),

                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text(
                      "Simpan Lowongan",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A4DDE),
                      foregroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Lowongan berhasil disimpan!")),
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Bagian ini wajib diisi' : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8FAFF),
        labelStyle: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF3A4DDE), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8FAFF),
        labelStyle: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF3A4DDE), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      dropdownColor: Colors.white,
      onChanged: (newValue) => setState(() => jobType = newValue!),
      items: options
          .map((type) => DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              ))
          .toList(),
    );
  }
}
