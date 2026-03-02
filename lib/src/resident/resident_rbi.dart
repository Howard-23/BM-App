part of barangaymo_app;

class ResidentRbiCardPage extends StatelessWidget {
  const ResidentRbiCardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RBI CARD'),
          backgroundColor: const Color(0xFFF7F8FF),
          bottom: TabBar(
            indicatorColor: const Color(0xFF3D53C8),
            indicatorWeight: 3,
            labelColor: const Color(0xFF8B4E46),
            unselectedLabelColor: const Color(0xFF616783),
            labelStyle: const TextStyle(fontWeight: FontWeight.w800),
            tabs: const [
              Tab(text: 'My Card'),
              Tab(text: 'Profile'),
              Tab(text: 'Transaction'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_RbiMyCard(), _RbiProfileData(), _RbiTransactions()],
        ),
      ),
    );
  }
}

class _RbiMyCard extends StatelessWidget {
  const _RbiMyCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F8FF), Color(0xFFF8F0EE)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFCF8F8), Color(0xFFF0ECF7)],
              ),
              border: Border.all(color: const Color(0xFFE3E1EC)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 178,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFE8ECFF), Color(0xFFF1F4FF)],
                          ),
                        ),
                      ),
                      Positioned(
                        right: -18,
                        top: -20,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      const Positioned.fill(
                        child: Center(
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, size: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Richard Portacio Perez',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F1A22),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'RBI-3-7-34-87709622',
                    style: TextStyle(
                      color: Color(0xFF595569),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        height: 162,
                        width: 162,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFE7E7EF)),
                        ),
                        child: const Center(
                          child: Icon(Icons.qr_code_2, size: 72),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _RbiMiniStat(
                              label: 'Status',
                              value: 'Active',
                              icon: Icons.verified,
                            ),
                            SizedBox(height: 8),
                            _RbiMiniStat(
                              label: 'Updated',
                              value: 'Feb 20, 2026',
                              icon: Icons.update,
                            ),
                            SizedBox(height: 8),
                            _RbiMiniStat(
                              label: 'Barangay',
                              value: 'Old Cabalan',
                              icon: Icons.location_on,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F8FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE4E8F4)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.verified_user_rounded, color: Color(0xFF3E56C8)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Verified by Barangay Records Office • Last sync Feb 20, 2026',
                            style: TextStyle(
                              color: Color(0xFF59607B),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: () =>
                        _showFeature(context, 'Digital RBI card shared.'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2E35D3),
                    ),
                    icon: const Icon(Icons.share),
                    label: const Text('Share Digital Card'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RbiProfileData extends StatelessWidget {
  const _RbiProfileData();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F8FF), Color(0xFFF8F0EE)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE3E8F4)),
            ),
            child: const Row(
              children: [
                Icon(Icons.account_box_rounded, color: Color(0xFF4A57BE)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Manage your personal identity records and linked credentials.',
                    style: TextStyle(
                      color: Color(0xFF5C637E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const _RbiInfoCard(
            title: 'Personal',
            subtitle:
                'Nationality, gender, date of birth, blood type, civil status, religion',
            icon: Icons.person_outline,
          ),
          const _RbiInfoCard(
            title: 'Government IDs',
            subtitle: 'SSS number, TIN, driver license, passport details',
            icon: Icons.badge_outlined,
          ),
          const _RbiInfoCard(
            title: 'Education / Health',
            subtitle: 'Attainment, profession, job status, height and weight',
            icon: Icons.school_outlined,
          ),
        ],
      ),
    );
  }
}

class _RbiTransactions extends StatelessWidget {
  const _RbiTransactions();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F8FF), Color(0xFFF8F0EE)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3F4EC8), Color(0xFF7181F2)],
              ),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0x33FFFFFF),
                  child: Icon(Icons.history_rounded, color: Colors.white),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Transaction log shows all recent RBI activities and verification events.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const _RbiTxnCard(
            title: 'RBI Profile Update',
            date: 'Feb 20, 2026',
            status: 'Completed',
          ),
          const _RbiTxnCard(
            title: 'Card Verification Check',
            date: 'Feb 18, 2026',
            status: 'Completed',
          ),
          const _RbiTxnCard(
            title: 'Barangay Service Access',
            date: 'Feb 14, 2026',
            status: 'Completed',
          ),
        ],
      ),
    );
  }
}

class _RbiMiniStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _RbiMiniStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E7F2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 17, color: const Color(0xFF4A55B8)),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF646A86),
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D3047),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RbiInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _RbiInfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E8F4)),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE4E8FF), Color(0xFFF2F4FF)],
            ),
          ),
          child: Icon(icon, color: const Color(0xFF4A55B8)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF2E3045),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF676C86),
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showFeature(context, 'Opening $title details'),
      ),
    );
  }
}

class _RbiTxnCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  const _RbiTxnCard({
    required this.title,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE6E8F4)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFE4E8FF),
            child: Icon(Icons.receipt_long, color: Color(0xFF4A55B8)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2E3045),
                  ),
                ),
                Text(date, style: const TextStyle(color: Color(0xFF676C86))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Color(0xFF2D8E55),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
