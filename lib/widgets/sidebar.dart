import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/user/profile_screen.dart'; // Ganti sesuai path sebenarnya

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final supabase = Supabase.instance.client;

  String username = 'Loading...';
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final response = await supabase
        .from('profiles')
        .select('first_name, last_name, avatar_url')
        .eq('id', user.id)
        .maybeSingle();

    if (response != null) {
      setState(() {
        final firstName = response['first_name'] ?? '';
        final lastName = response['last_name'] ?? '';
        username = '$firstName $lastName';
        avatarUrl = response['avatar_url'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  avatarUrl != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(avatarUrl!),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 40, color: Colors.white),
                        ),
                  const SizedBox(height: 12),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'UX Designer',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.verified, color: Colors.blue, size: 16),
                    ],
                  ),
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const Text(
                      'View Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 32, color: Colors.white24),
            _buildDrawerItem(Icons.info_outline, 'Personal Info'),
            _buildDrawerItem(Icons.article_outlined, 'Applications'),
            _buildDrawerItem(Icons.description_outlined, 'Proposals'),
            _buildDrawerItem(Icons.receipt_long_outlined, 'Resumes'),
            _buildDrawerItem(Icons.work_outline, 'Portfolio'),
            _buildDrawerItem(Icons.settings_outlined, 'Settings'),
            _buildDrawerItem(Icons.logout, 'Logout'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        // Navigasi ke halaman yang sesuai
      },
    );
  }
}
