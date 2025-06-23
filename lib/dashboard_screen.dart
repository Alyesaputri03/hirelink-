// dashboard_screen.dart (modern UI - updated with more jobs and refined UX)
import 'package:flutter/material.dart';
import 'job_detail_screen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredJobs = [
      {
        'title': 'Product Designer',
        'tags': ['Design', 'Full-Time', 'Remote'],
        'salary': '\$95,000/year',
        'location': 'Jakarta, ID'
      },
      {
        'title': 'Data Analyst',
        'tags': ['IT', 'Remote'],
        'salary': '\$100,000/year',
        'location': 'Bandung, ID'
      },
      {
        'title': 'UI/UX Designer',
        'tags': ['Design', 'Contract'],
        'salary': '\$70,000/year',
        'location': 'Semarang, ID'
      },
      {
        'title': 'DevOps Engineer',
        'tags': ['Engineering', 'Full-Time'],
        'salary': '\$120,000/year',
        'location': 'Yogyakarta, ID'
      },
    ];

    final recommendedJobs = [
      {'title': 'Web Developer', 'salary': '\$82,000/year', 'location': 'Surabaya, ID'},
      {'title': 'Cyber Security', 'salary': '\$91,000/year', 'location': 'Depok, ID'},
      {'title': 'Mobile Developer', 'salary': '\$88,000/year', 'location': 'Malang, ID'},
      {'title': 'System Analyst', 'salary': '\$85,000/year', 'location': 'Makassar, ID'},
      {'title': 'Network Engineer', 'salary': '\$78,000/year', 'location': 'Medan, ID'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1), // Dark Blue Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Buat Lowongan'),
                      onTap: () => Navigator.pushNamed(context, '/create_job'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Text('Welcome Back! 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
            const Text('HireLink', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search a job or position',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.filter_alt_outlined),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text('Featured Jobs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: featuredJobs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final job = featuredJobs[index] as Map<String, dynamic>;
                  final tags = job['tags'] as List<dynamic>? ?? [];

                  return Container(
                    width: 260,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job['title']?.toString() ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: tags.map<Widget>((tag) {
                            return Chip(
                              label: Text(tag.toString()),
                              backgroundColor: Colors.teal.shade50,
                            );
                          }).toList(),
                        ),
                        const Spacer(),
                        Text(job['salary']?.toString() ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                        Text(job['location']?.toString() ?? '', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            const Text('Recommended Jobs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            ...recommendedJobs.map((job) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(job['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
                  subtitle: Text(job['location'] ?? '', style: const TextStyle(color: Colors.grey)),
                  trailing: Text(job['salary'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailScreen(job: job),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
