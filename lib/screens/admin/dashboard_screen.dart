import 'package:flutter/material.dart';
import '../../../widgets/sidebar.dart';
import '../user/job_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> featuredJobs = [
      {
        'title': 'Product Designer',
        'tags': ['Design', 'Full-Time', 'Remote'],
        'salary': '\$95,000/year',
        'location': 'Jakarta, ID',
      },
      {
        'title': 'Data Analyst',
        'tags': ['IT', 'Remote'],
        'salary': '\$100,000/year',
        'location': 'Bandung, ID',
      },
      {
        'title': 'UI/UX Designer',
        'tags': ['Design', 'Contract'],
        'salary': '\$70,000/year',
        'location': 'Semarang, ID',
      },
      {
        'title': 'DevOps Engineer',
        'tags': ['Engineering', 'Full-Time'],
        'salary': '\$120,000/year',
        'location': 'Yogyakarta, ID',
      },
      {
        'title': 'Frontend Developer',
        'tags': ['Remote', 'Full-Time'],
        'salary': '\$85,000/year',
        'location': 'Depok, ID',
      },
      {
        'title': 'Backend Developer',
        'tags': ['Remote', 'Backend'],
        'salary': '\$90,000/year',
        'location': 'Bekasi, ID',
      },
      {
        'title': 'Project Manager',
        'tags': ['Management', 'Remote'],
        'salary': '\$110,000/year',
        'location': 'Bogor, ID',
      },
      {
        'title': 'Graphic Designer',
        'tags': ['Design'],
        'salary': '\$65,000/year',
        'location': 'Padang, ID',
      },
      {
        'title': 'AI Engineer',
        'tags': ['Engineering', 'AI'],
        'salary': '\$130,000/year',
        'location': 'Bali, ID',
      },
      {
        'title': 'QA Tester',
        'tags': ['Quality', 'Full-Time'],
        'salary': '\$75,000/year',
        'location': 'Solo, ID',
      },
    ];

    final List<Map<String, String>> recommendedJobs = [
      {'title': 'Web Developer', 'salary': '\$82,000/year', 'location': 'Surabaya, ID'},
      {'title': 'Cyber Security', 'salary': '\$91,000/year', 'location': 'Depok, ID'},
      {'title': 'Mobile Developer', 'salary': '\$88,000/year', 'location': 'Malang, ID'},
      {'title': 'System Analyst', 'salary': '\$85,000/year', 'location': 'Makassar, ID'},
      {'title': 'Network Engineer', 'salary': '\$78,000/year', 'location': 'Medan, ID'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
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
                      leading: const Icon(Icons.add, color: Colors.black),
                      title: const Text('Buat Lowongan', style: TextStyle(color: Colors.black)),
                      onTap: () => Navigator.pushNamed(context, '/create_job'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.black),
                      title: const Text('Logout', style: TextStyle(color: Colors.black)),
                      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Text(
              'Welcome Back! 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const Text(
              'HireLink',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                ],
              ),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search a job or position',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  suffixIcon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Featured Jobs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: featuredJobs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final job = featuredJobs[index];
                  final List<dynamic> tags = job['tags'] ?? [];

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailScreen(job: job),
                      ),
                    ),
                    child: Container(
                      width: 260,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFAFAFA), Color(0xFFE3F2FD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A237E),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            children: tags.map((tag) {
                              return Chip(
                                label: Text(
                                  tag.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF004D40),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                backgroundColor: const Color(0xFFB2DFDB),
                              );
                            }).toList(),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.monetization_on, size: 18, color: Colors.green),
                              const SizedBox(width: 6),
                              Text(
                                job['salary'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18, color: Colors.redAccent),
                              const SizedBox(width: 6),
                              Text(
                                job['location'] ?? '',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Recommended Jobs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 12),
            ...recommendedJobs.map((job) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    job['title'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.indigo,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        job['location'] ?? '',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    job['salary'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 14,
                    ),
                  ),
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
            }),
          ],
        ),
      ),
    );
  }
}