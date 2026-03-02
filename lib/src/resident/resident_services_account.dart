part of barangaymo_app;

class ResidentAnnouncementPage extends StatelessWidget {
  const ResidentAnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Announcements')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search announcement...',
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _AnnouncementChip(label: 'Civic Engagement'),
                _AnnouncementChip(label: 'Community Events'),
                _AnnouncementChip(label: 'Education & Training'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: const [
              _AnnouncementTile(
                title: 'Tree Planting Day',
                category: 'Environmental Announcements',
                dateRange: 'Nov 17 to Nov 17',
              ),
              _AnnouncementTile(
                title: 'Year-End Celebration',
                category: 'Civic Engagement & Outreach',
                dateRange: 'Dec 21 to Dec 21',
              ),
              _AnnouncementTile(
                title: 'Monthly Meeting',
                category: 'Meetings & Schedules',
                dateRange: 'Dec 1 to Dec 1',
              ),
              _AnnouncementTile(
                title: 'Power Outage Alert',
                category: 'Public Announcements',
                dateRange: 'Nov 15 to Nov 15',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnnouncementChip extends StatelessWidget {
  final String label;
  const _AnnouncementChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(label: Text(label, style: const TextStyle(fontSize: 12))),
    );
  }
}

class _AnnouncementTile extends StatelessWidget {
  final String title;
  final String category;
  final String dateRange;
  const _AnnouncementTile({
    required this.title,
    required this.category,
    required this.dateRange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.attachment, color: Color(0xFF2E35D3)),
            ),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(category),
            const SizedBox(height: 4),
            Text(
              dateRange,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => _showFeature(context, '$title details'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2E35D3),
              ),
              child: const Text('More Info'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentSpecialDocsPage extends StatelessWidget {
  const ResidentSpecialDocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Docs'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F8FF), Color(0xFFF9F2EE)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3F4EC8), Color(0xFF7181F2)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x223A48C2),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Digital Identity & Priority Docs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Access RBI, QR verification, and responder tools in one secure place.',
                          style: TextStyle(
                            color: Color(0xFFDDE3FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.security_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _docActionCard(
              context: context,
              title: 'QR ID Scanner',
              subtitle: 'Validate resident identity and scan barangay IDs.',
              icon: Icons.qr_code_scanner_rounded,
              accent: const Color(0xFFD83D3D),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScanQrPage()),
              ),
            ),
            const SizedBox(height: 10),
            _docActionCard(
              context: context,
              title: 'RBI Card',
              subtitle: 'Open your profile, card details, and transactions.',
              icon: Icons.badge_rounded,
              accent: const Color(0xFF4557CA),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ResidentRbiCardPage()),
              ),
            ),
            const SizedBox(height: 10),
            _docActionCard(
              context: context,
              title: 'Responder',
              subtitle:
                  'Fast access to emergency contacts and location sharing.',
              icon: Icons.emergency_rounded,
              accent: const Color(0xFF8A5A44),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ResponderPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _docActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accent,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE3E7F4)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 9,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: accent.withValues(alpha: 0.14),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF2F334A),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF646C88),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: accent, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class ResidentRequestsPage extends StatefulWidget {
  const ResidentRequestsPage({super.key});

  @override
  State<ResidentRequestsPage> createState() => _ResidentRequestsPageState();
}

class _ResidentRequestsPageState extends State<ResidentRequestsPage> {
  String _query = '';
  String _selectedStatus = 'All';

  static const _statusFilters = [
    'All',
    'Pending',
    'Approved',
    'Rejected',
    'Completed',
  ];

  static const _history = [
    _ResidentRequestEntry(
      category: 'Clearance',
      title: 'Barangay Clearance',
      requestId: 'BC-26-0220',
      status: 'Approved',
      purpose: 'Residency requirement',
      date: 'Feb 20, 2026',
    ),
    _ResidentRequestEntry(
      category: 'Assistance',
      title: 'Medical Assistance Form',
      requestId: 'MA-26-0218',
      status: 'Pending',
      purpose: 'Hospital bill support',
      date: 'Feb 18, 2026',
    ),
    _ResidentRequestEntry(
      category: 'Clearance',
      title: 'Certificate of Indigency',
      requestId: 'CI-26-0217',
      status: 'Rejected',
      purpose: 'Scholarship document',
      date: 'Feb 17, 2026',
    ),
    _ResidentRequestEntry(
      category: 'Business',
      title: 'Business Endorsement',
      requestId: 'BE-26-0210',
      status: 'Approved',
      purpose: 'Market stall permit',
      date: 'Feb 10, 2026',
    ),
    _ResidentRequestEntry(
      category: 'Clearance',
      title: 'Barangay Clearance',
      requestId: 'BC-26-0204',
      status: 'Completed',
      purpose: 'Claimed and downloaded copy',
      date: 'Feb 04, 2026',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final rows = _history.where((item) {
      final matchesStatus =
          _selectedStatus == 'All' || item.status == _selectedStatus;
      final bag =
          '${item.title} ${item.requestId} ${item.purpose} ${item.category}'
              .toLowerCase();
      final matchesQuery = q.isEmpty || bag.contains(q);
      return matchesStatus && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F8FF), Color(0xFFF9F1ED)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3B4CC7), Color(0xFF6F80F1)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29424FC2),
                    blurRadius: 15,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -18,
                    top: -16,
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.16),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Track Your Requests',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Monitor clearances and assistance applications in one place.',
                              style: TextStyle(
                                color: Color(0xFFE4E8FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Color(0x34FFFFFF),
                        child: Icon(
                          Icons.assignment_turned_in_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE3E7F4)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: 'Search requests, ID, purpose...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _statusFilters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 6),
                itemBuilder: (_, i) {
                  final label = _statusFilters[i];
                  final active = label == _selectedStatus;
                  final count = label == 'All'
                      ? _history.length
                      : _history.where((item) => item.status == label).length;
                  return ChoiceChip(
                    label: Text('$label ($count)'),
                    selected: active,
                    onSelected: (_) => setState(() => _selectedStatus = label),
                    selectedColor: const Color(0xFFDCE4FF),
                    side: BorderSide(
                      color: active
                          ? const Color(0xFF576DD8)
                          : const Color(0xFFD9DFEF),
                    ),
                    labelStyle: TextStyle(
                      color: active
                          ? const Color(0xFF32419A)
                          : const Color(0xFF626983),
                      fontWeight: FontWeight.w800,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            _requestActionCard(
              context: context,
              title: 'Clearance Requests',
              subtitle:
                  'Generate and track barangay clearance and residency certificates.',
              icon: Icons.description_outlined,
              buttonLabel: 'Request Clearance',
              color: const Color(0xFF4A66CB),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClearancePage()),
              ),
            ),
            const SizedBox(height: 10),
            _requestActionCard(
              context: context,
              title: 'Assistance Requests',
              subtitle:
                  'Submit social, financial, educational, and medical support applications.',
              icon: Icons.volunteer_activism,
              buttonLabel: 'Request Assistance',
              color: const Color(0xFFAE5A4E),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AssistancePage()),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Request History (${rows.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF2F334A),
              ),
            ),
            const SizedBox(height: 8),
            if (rows.isEmpty)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E6F2)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search_off_rounded, color: Color(0xFF7A829D)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'No request records found',
                        style: TextStyle(
                          color: Color(0xFF565D79),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...rows.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE4E6F3)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _statusIcon(item.status),
                            color: _statusColor(item.status),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2D3148),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor(
                                item.status,
                              ).withValues(alpha: 0.13),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              item.status,
                              style: TextStyle(
                                color: _statusColor(item.status),
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${item.requestId} | ${item.date}',
                        style: const TextStyle(
                          color: Color(0xFF676D88),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Purpose: ${item.purpose}',
                        style: const TextStyle(
                          color: Color(0xFF5D627D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor(
                                item.status,
                              ).withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              item.category,
                              style: TextStyle(
                                color: _statusColor(item.status),
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () => _openRequestDetails(context, item),
                            icon: const Icon(
                              Icons.visibility_rounded,
                              size: 18,
                            ),
                            label: const Text('Details'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF3F4FC8),
                  side: const BorderSide(color: Color(0xFFC4CEEE)),
                ),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Return Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required String buttonLabel,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E7F4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2F334A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '2-3 days',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF656B85),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: color.withValues(alpha: 0.4)),
                foregroundColor: color,
              ),
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF2F965D);
      case 'Completed':
        return const Color(0xFF3B56C8);
      case 'Rejected':
        return const Color(0xFFD34F42);
      case 'Pending':
      default:
        return const Color(0xFFB77A2F);
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Approved':
        return Icons.verified_rounded;
      case 'Completed':
        return Icons.download_done_rounded;
      case 'Rejected':
        return Icons.cancel_rounded;
      case 'Pending':
      default:
        return Icons.schedule_rounded;
    }
  }

  IconData _entryIcon(_ResidentRequestEntry item) {
    final title = item.title.toLowerCase();
    if (title.contains('medical')) return Icons.local_hospital_rounded;
    if (title.contains('business')) return Icons.store_rounded;
    if (title.contains('residency')) return Icons.home_rounded;
    if (title.contains('indigency')) return Icons.assignment_ind_rounded;
    return Icons.description_rounded;
  }

  void _openRequestDetails(BuildContext context, _ResidentRequestEntry item) {
    final accent = _statusColor(item.status);
    final subtitle = switch (item.status) {
      'Approved' => 'Approved on ${item.date}',
      'Rejected' => 'Rejected on ${item.date}',
      'Completed' => 'Completed and downloaded',
      _ => 'Pending review and verification',
    };
    final detail = switch (item.status) {
      'Rejected' => 'Reason: ${item.purpose}',
      'Completed' => 'Released to resident on ${item.date}',
      _ => 'Purpose: ${item.purpose}',
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _DocumentStatusDetailPage(
          status: item.status,
          accent: accent,
          entry: _DocEntry(
            title: item.title,
            subtitle: subtitle,
            detail: detail,
            reference: item.requestId,
            icon: _entryIcon(item),
          ),
        ),
      ),
    );
  }
}

class _ResidentRequestEntry {
  final String category;
  final String title;
  final String requestId;
  final String status;
  final String purpose;
  final String date;
  const _ResidentRequestEntry({
    required this.category,
    required this.title,
    required this.requestId,
    required this.status,
    required this.purpose,
    required this.date,
  });
}

class ResidentServicesPage extends StatelessWidget {
  const ResidentServicesPage({super.key});

  static const _commonServices = [
    _ServiceAction('Assistance', Icons.volunteer_activism, AssistancePage()),
    _ServiceAction('BPAT', Icons.shield, BpatPage()),
    _ServiceAction('Clearance', Icons.description, ClearancePage()),
    _ServiceAction('Council', Icons.groups, CouncilPage()),
    _ServiceAction('Health', Icons.health_and_safety, HealthPage()),
    _ServiceAction('Community', Icons.forum, CommunityPage()),
  ];

  static const _allServices = [
    _ServiceAction('Requests', Icons.assignment, ResidentRequestsPage()),
    _ServiceAction('Assistance', Icons.volunteer_activism, AssistancePage()),
    _ServiceAction('BPAT', Icons.shield, BpatPage()),
    _ServiceAction('Clearance', Icons.description, ClearancePage()),
    _ServiceAction('Council', Icons.groups, CouncilPage()),
    _ServiceAction('Disclosure', Icons.table_chart, DisclosureBoardPage()),
    _ServiceAction(
      'Special Docs',
      Icons.stars,
      SimpleSerbilisPage(title: 'Special Docs', isOfficial: false),
    ),
    _ServiceAction('Responder', Icons.local_shipping, ResponderPage()),
    _ServiceAction('Provincial Gov', Icons.apartment, GovAgenciesPage()),
    _ServiceAction('Health', Icons.health_and_safety, HealthPage()),
    _ServiceAction('Community', Icons.forum, CommunityPage()),
    _ServiceAction('QR ID', Icons.qr_code_scanner, ScanQrPage()),
    _ServiceAction('RBI', Icons.badge, ResidentRbiCardPage()),
    _ServiceAction(
      'Education',
      Icons.menu_book,
      SimpleSerbilisPage(title: 'Education', isOfficial: false),
    ),
    _ServiceAction(
      'Police',
      Icons.local_police,
      SimpleSerbilisPage(title: 'Police', isOfficial: false),
    ),
    _ServiceAction(
      'Other Barangay',
      Icons.travel_explore,
      SimpleSerbilisPage(title: 'Other Barangay', isOfficial: false),
    ),
    _ServiceAction(
      'SK Education',
      Icons.school,
      SimpleSerbilisPage(title: 'SK Education', isOfficial: false),
    ),
    _ServiceAction('Officials', Icons.groups_2, CouncilPage()),
    _ServiceAction(
      'Programs',
      Icons.assignment,
      SimpleSerbilisPage(title: 'Programs', isOfficial: false),
    ),
    _ServiceAction('Scholarship', Icons.card_giftcard, AssistancePage()),
    _ServiceAction(
      'Sports',
      Icons.sports_basketball,
      SimpleSerbilisPage(title: 'Sports', isOfficial: false),
    ),
  ];

  void _openService(BuildContext context, _ServiceAction action) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => action.page));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5F7FF), Color(0xFFF8F1ED)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3E4CC7), Color(0xFF6775E6)],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x262E35D3),
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Barangay Services',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Access permits, requests, support, and emergency channels.',
                        style: TextStyle(color: Color(0xFFDDE1FF)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0x33FFFFFF),
                  child: Icon(
                    Icons.miscellaneous_services,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentSpecialDocsPage(),
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF3C48BD),
                  ),
                  icon: const Icon(Icons.stars),
                  label: const Text('Special Docs'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentRequestsPage(),
                    ),
                  ),
                  icon: const Icon(Icons.assignment),
                  label: const Text('My Requests'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Common Services',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2F3146),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Frequently used resident services',
            style: TextStyle(
              color: Color(0xFF6A7089),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _commonServices.length,
              separatorBuilder: (_, _) => const SizedBox(width: 9),
              itemBuilder: (_, i) => _servicePill(context, _commonServices[i]),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'All Services',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2F3146),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Tap any tile to open the service page',
            style: TextStyle(
              color: Color(0xFF6A7089),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allServices.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (_, i) => _serviceGridTile(context, _allServices[i]),
          ),
        ],
      ),
    );
  }

  Widget _servicePill(BuildContext context, _ServiceAction action) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => _openService(context, action),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 128,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFFFF), Color(0xFFF2F4FF)],
            ),
            border: Border.all(color: const Color(0xFFE2E5FF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x15000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(action.icon, color: const Color(0xFF4753B8)),
              const SizedBox(height: 6),
              Text(
                action.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF424760),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceGridTile(BuildContext context, _ServiceAction action) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => _openService(context, action),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE7E8F3)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE3E8FF), Color(0xFFF1F3FF)],
                  ),
                ),
                child: Icon(
                  action.icon,
                  size: 19,
                  color: const Color(0xFF4D59BF),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                action.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF43485E),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResidentProfilePhotoValue {
  final String? url;
  final Uint8List? bytes;
  final String? fileName;

  const _ResidentProfilePhotoValue({this.url, this.bytes, this.fileName});
}

class _ResidentProfilePhotoStore {
  static const presetUrls = [
    'https://i.pravatar.cc/600?img=47',
    'https://i.pravatar.cc/600?img=32',
    'https://i.pravatar.cc/600?img=44',
    'https://i.pravatar.cc/600?img=20',
    'https://i.pravatar.cc/600?img=16',
    'https://i.pravatar.cc/600?img=11',
  ];

  static final ValueNotifier<_ResidentProfilePhotoValue> photo =
      ValueNotifier<_ResidentProfilePhotoValue>(
        _ResidentProfilePhotoValue(url: presetUrls.first),
      );
}

String _fileDisplayName(String value) {
  if (value.isEmpty) return 'selected_image';
  final normalized = value.replaceAll('\\', '/');
  final parts = normalized.split('/');
  return parts.isEmpty ? value : parts.last;
}

Future<({Uint8List bytes, String fileName})?> _pickResidentPhotoData() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 1200,
    imageQuality: 90,
  );
  if (picked == null) return null;
  final bytes = await picked.readAsBytes();
  return (bytes: bytes, fileName: picked.name);
}

Future<void> _openResidentProfilePhotoEditor(BuildContext context) async {
  final current = _ResidentProfilePhotoStore.photo.value;
  final urlController = TextEditingController(text: current.url ?? '');
  String selectedUrl =
      current.url ?? _ResidentProfilePhotoStore.presetUrls.first;
  Uint8List? selectedBytes = current.bytes;
  String? selectedFileName = current.fileName;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (context, setModal) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFF8FAFF), Color(0xFFF8F0F2)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Change Profile Photo',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2E3248),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Choose a high-quality portrait or paste image URL.',
                    style: TextStyle(
                      color: Color(0xFF687089),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await _pickResidentPhotoData();
                        if (picked == null) return;
                        setModal(() {
                          selectedBytes = picked.bytes;
                          selectedFileName = picked.fileName;
                          selectedUrl = '';
                          urlController.clear();
                        });
                      },
                      icon: const Icon(Icons.upload_file_rounded, size: 18),
                      label: const Text('Upload Photo'),
                    ),
                  ),
                  if (selectedBytes != null) ...[
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDCE2F2)),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 46,
                              height: 46,
                              child: Image.memory(
                                selectedBytes!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedFileName == null
                                  ? 'Uploaded photo selected'
                                  : _fileDisplayName(selectedFileName!),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF3E465F),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Clear',
                            onPressed: () {
                              setModal(() {
                                selectedBytes = null;
                                selectedFileName = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Color(0xFF7B829F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 210,
                    child: GridView.builder(
                      itemCount: _ResidentProfilePhotoStore.presetUrls.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (_, i) {
                        final url = _ResidentProfilePhotoStore.presetUrls[i];
                        final selectedItem =
                            selectedBytes == null && selectedUrl == url;
                        return InkWell(
                          onTap: () {
                            setModal(() {
                              selectedUrl = url;
                              selectedBytes = null;
                              selectedFileName = null;
                            });
                            urlController.text = url;
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: selectedItem
                                    ? const Color(0xFF4B59C5)
                                    : const Color(0xFFD9DEEE),
                                width: selectedItem ? 2 : 1,
                              ),
                              boxShadow: selectedItem
                                  ? const [
                                      BoxShadow(
                                        color: Color(0x334B59C5),
                                        blurRadius: 8,
                                        offset: Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                  if (selectedItem)
                                    const Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Color(0xFF4B59C5),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelText: 'Or paste profile image URL',
                      hintText: 'https://...',
                    ),
                    onChanged: (value) => setModal(() {
                      selectedUrl = value.trim();
                      selectedBytes = null;
                      selectedFileName = null;
                    }),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            final seed = DateTime.now().microsecondsSinceEpoch;
                            final urls = _ResidentProfilePhotoStore.presetUrls;
                            final next = urls[seed % urls.length];
                            setModal(() {
                              selectedUrl = next;
                              selectedBytes = null;
                              selectedFileName = null;
                              urlController.text = next;
                            });
                          },
                          icon: const Icon(Icons.refresh_rounded, size: 18),
                          label: const Text('Randomize'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _ResidentProfilePhotoStore.photo.value =
                                const _ResidentProfilePhotoValue();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                          ),
                          label: const Text('Remove'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        final value = selectedUrl.trim();
                        _ResidentProfilePhotoStore.photo.value =
                            _ResidentProfilePhotoValue(
                              url: selectedBytes == null
                                  ? (value.isEmpty ? null : value)
                                  : null,
                              bytes: selectedBytes,
                              fileName: selectedFileName,
                            );
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF3E4CC7),
                      ),
                      icon: const Icon(Icons.check_circle_outline_rounded),
                      label: const Text('Apply Profile Photo'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  urlController.dispose();
}

class _ResidentEditableProfileAvatar extends StatelessWidget {
  final double size;
  final VoidCallback onEdit;
  const _ResidentEditableProfileAvatar({
    required this.size,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_ResidentProfilePhotoValue>(
      valueListenable: _ResidentProfilePhotoStore.photo,
      builder: (_, photo, __) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFFFFF), Color(0xFFDCE2FF)],
                ),
                border: Border.all(color: const Color(0x99FFFFFF), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (photo.bytes != null && photo.bytes!.isNotEmpty)
                        Image.memory(
                          photo.bytes!,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFFE2E7FF),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF5B64A6),
                              size: 38,
                            ),
                          ),
                        )
                      else if (photo.url != null && photo.url!.isNotEmpty)
                        Image.network(
                          photo.url!,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFFE2E7FF),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF5B64A6),
                              size: 38,
                            ),
                          ),
                        )
                      else
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFDEE2FF), Color(0xFFBAC2FF)],
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 38,
                            color: Colors.white,
                          ),
                        ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: size * 0.35,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withValues(alpha: 0.28),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3E4CC7),
                    border: Border.all(color: Colors.white, width: 1.8),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ResidentProfilePage extends StatelessWidget {
  const ResidentProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF6F8FF), Color(0xFFF8F0EE)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3E4CC7), Color(0xFF6573E3)],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x262E35D3),
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                _ResidentEditableProfileAvatar(
                  size: 72,
                  onEdit: () => _openResidentProfilePhotoEditor(context),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shamira Balandra',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'RBI-3-7-34-53541212',
                        style: TextStyle(color: Color(0xFFDDE0FF)),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Tap camera icon to change profile photo',
                        style: TextStyle(
                          color: Color(0xFFD8DCFF),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentVerifyProfilePage(),
                    ),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFE6E7F2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Profile Completion',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2F3146),
                  ),
                ),
                SizedBox(height: 6),
                LinearProgressIndicator(
                  value: 0.78,
                  minHeight: 8,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  backgroundColor: Color(0xFFE9ECFA),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4250C4)),
                ),
                SizedBox(height: 4),
                Text(
                  'Complete remaining details to unlock all services.',
                  style: TextStyle(color: Color(0xFF666B86)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _profileAction(
                  context,
                  title: 'Verify',
                  icon: Icons.verified_user,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentVerifyProfilePage(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _profileAction(
                  context,
                  title: 'RBI Card',
                  icon: Icons.badge,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentRbiCardPage(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _profileAction(
                  context,
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentSettingsPage(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _profileInfoCard(
            context,
            title: 'Personal Information',
            subtitle: 'Full name, birth details, sex, and civil status',
            icon: Icons.person_outline,
          ),
          _profileInfoCard(
            context,
            title: 'Residence Details',
            subtitle: 'House number, street, barangay, city, and province',
            icon: Icons.home_work_outlined,
          ),
          _profileInfoCard(
            context,
            title: 'Education and Employment',
            subtitle: 'Attainment, occupation, skills, and job status',
            icon: Icons.school_outlined,
          ),
          _profileInfoCard(
            context,
            title: 'Health Information',
            subtitle: 'Height, weight, blood type, and medical details',
            icon: Icons.health_and_safety_outlined,
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResidentSupportPage()),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF3A47BA),
            ),
            icon: const Icon(Icons.support_agent),
            label: const Text('Need Help? Contact Support'),
          ),
        ],
      ),
    );
  }

  Widget _profileAction(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 84,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE6E7F2)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF4854BA)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF4A4F68),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileInfoCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E7F2)),
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
              colors: [Color(0xFFE4E8FF), Color(0xFFF1F3FF)],
            ),
          ),
          child: Icon(icon, color: const Color(0xFF4D59BE)),
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
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ResidentVerifyProfilePage()),
        ),
      ),
    );
  }
}

class ResidentCartPage extends StatefulWidget {
  const ResidentCartPage({super.key});

  @override
  State<ResidentCartPage> createState() => _ResidentCartPageState();
}

class _ResidentCartHub {
  static final ValueNotifier<int> refresh = ValueNotifier<int>(0);

  static final List<_CartLineItem> items = [
    _CartLineItem(
      title: 'Lenovo IdeaPad 15.6"',
      seller: 'L. Nadong Electronics',
      price: 14999,
      qty: 1,
      icon: Icons.laptop_mac,
      imageAsset: 'public/item-laptop.jpg',
    ),
    _CartLineItem(
      title: 'Epson EcoTank L3210',
      seller: 'Cabalan Office Depot',
      price: 8290,
      qty: 1,
      icon: Icons.print,
      imageAsset: 'public/item-printer.jpg',
    ),
  ];

  static final List<_OrderHistoryEntry> orders = [];

  static void _emit() => refresh.value++;

  static void addProduct(_ResidentProductData product, {int qty = 1}) {
    final safeQty = qty < 1 ? 1 : qty;
    final index = items.indexWhere(
      (item) => item.title == product.title && item.seller == product.seller,
    );

    if (index >= 0) {
      items[index].qty = (items[index].qty + safeQty).clamp(1, 99);
      _emit();
      return;
    }

    items.insert(
      0,
      _CartLineItem(
        title: product.title,
        seller: product.seller,
        price: product.price,
        qty: safeQty,
        icon: product.icon,
        imageAsset: product.imageAsset,
      ),
    );
    _emit();
  }

  static void changeQty(int index, int delta) {
    if (index < 0 || index >= items.length) {
      return;
    }
    final next = items[index].qty + delta;
    items[index].qty = next.clamp(1, 99);
    _emit();
  }

  static _CartLineItem removeAt(int index) {
    final removed = items.removeAt(index);
    _emit();
    return removed;
  }

  static void clearItems() {
    items.clear();
    _emit();
  }

  static void addOrder(_OrderHistoryEntry order) {
    orders.insert(0, order);
    _emit();
  }
}

class _ResidentCartPageState extends State<ResidentCartPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _nameOnCardController = TextEditingController(text: 'Shamira Balandra');
  final _cardNumberController = TextEditingController(
    text: '4242 4242 4242 4242',
  );
  final _expiryController = TextEditingController(text: '12/28');
  final _cvvController = TextEditingController(text: '123');
  final _addressController = TextEditingController(
    text: '1953 Purok 7, Old Cabalan, Olongapo City, PH',
  );

  bool _placingOrder = false;
  List<_CartLineItem> get _cartItems => _ResidentCartHub.items;
  List<_OrderHistoryEntry> get _orders => _ResidentCartHub.orders;

  void _onCartUpdated() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _ResidentCartHub.refresh.addListener(_onCartUpdated);
  }

  @override
  void dispose() {
    _ResidentCartHub.refresh.removeListener(_onCartUpdated);
    _tabController.dispose();
    _nameOnCardController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.qty));
  double get _deliveryFee => _cartItems.isEmpty ? 0 : 85;
  double get _serviceFee => _cartItems.isEmpty ? 0 : 35;
  double get _grandTotal => _subtotal + _deliveryFee + _serviceFee;

  String _currency(double amount) => 'PHP ${amount.toStringAsFixed(2)}';

  String _formatOrderDate(DateTime now) =>
      '${now.month}/${now.day}/${now.year}';

  void _changeQty(int index, int delta) {
    _ResidentCartHub.changeQty(index, delta);
  }

  void _removeItem(int index) {
    final item = _ResidentCartHub.removeAt(index);
    _showFeature(context, '${item.title} removed from cart');
  }

  Future<void> _placeOrder() async {
    if (_cartItems.isEmpty) {
      _showFeature(context, 'Your cart is empty.');
      return;
    }
    if (_nameOnCardController.text.trim().isEmpty ||
        _cardNumberController.text.trim().isEmpty ||
        _expiryController.text.trim().isEmpty ||
        _cvvController.text.trim().isEmpty) {
      _showFeature(context, 'Please complete billing details.');
      return;
    }

    setState(() => _placingOrder = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) {
      return;
    }
    final now = DateTime.now();
    final orderItems = List<_CartLineItem>.from(
      _cartItems.map(
        (e) => _CartLineItem(
          title: e.title,
          seller: e.seller,
          price: e.price,
          qty: e.qty,
          icon: e.icon,
          imageAsset: e.imageAsset,
        ),
      ),
    );
    final order = _OrderHistoryEntry(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch % 100000}',
      date: _formatOrderDate(now),
      status: 'Processing',
      total: _grandTotal,
      items: orderItems,
    );
    _ResidentCartHub.addOrder(order);
    _ResidentCartHub.clearItems();
    setState(() => _placingOrder = false);
    _tabController.animateTo(1);
    _showFeature(context, 'Order placed successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: const Color(0xFFF7F8FF),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
            color: const Color(0xFFDCE2FF),
            borderRadius: BorderRadius.circular(999),
          ),
          labelColor: const Color(0xFF2D3150),
          unselectedLabelColor: const Color(0xFF717793),
          labelStyle: const TextStyle(fontWeight: FontWeight.w800),
          tabs: const [
            Tab(text: 'My Cart'),
            Tab(text: 'My Orders'),
            Tab(text: 'Billing'),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FF), Color(0xFFF8F0EE)],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF3E4CC7), Color(0xFF6E7DE9)],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x262E35D3),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0x33FFFFFF),
                        child: Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cart Summary',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '${_cartItems.length} item(s) | Total ${_currency(_grandTotal)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFFDDE1FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (_cartItems.isEmpty)
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.remove_shopping_cart),
                      title: Text('Your cart is empty'),
                      subtitle: Text('Add products from the marketplace.'),
                    ),
                  )
                else
                  ...List.generate(_cartItems.length, (i) => _cartItemCard(i)),
                const SizedBox(height: 10),
                _billRow('Subtotal', _currency(_subtotal)),
                _billRow('Delivery Fee', _currency(_deliveryFee)),
                _billRow('Service Fee', _currency(_serviceFee)),
                const Divider(),
                _billRow('Grand Total', _currency(_grandTotal), bold: true),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _cartItems.isEmpty
                      ? null
                      : () => _tabController.animateTo(2),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2E35D3),
                  ),
                  icon: const Icon(Icons.payment),
                  label: const Text('Proceed to Checkout'),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
              children: [
                if (_orders.isEmpty)
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.inventory_2_outlined),
                      title: Text('No orders yet'),
                      subtitle: Text(
                        'Your confirmed checkout orders appear here.',
                      ),
                    ),
                  )
                else
                  ..._orders.map(
                    (o) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E8F4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                o.id,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2E3046),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5ECFF),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  o.status,
                                  style: const TextStyle(
                                    color: Color(0xFF3A4CB2),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Date: ${o.date} | Total: ${_currency(o.total)}',
                            style: const TextStyle(
                              color: Color(0xFF666C86),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...o.items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                '${item.qty}x ${item.title} (${_currency(item.price * item.qty)})',
                                style: const TextStyle(
                                  color: Color(0xFF4F5672),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE5E8F4)),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameOnCardController,
                        decoration: const InputDecoration(
                          labelText: 'Name on Card',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _cardNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Card Number',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _expiryController,
                              decoration: const InputDecoration(
                                labelText: 'Expiry Date',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _cvvController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'CVV',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _addressController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Delivery Address',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _billRow('Subtotal', _currency(_subtotal)),
                _billRow('Delivery Fee', _currency(_deliveryFee)),
                _billRow('Service Fee', _currency(_serviceFee)),
                const Divider(),
                _billRow('Payable Amount', _currency(_grandTotal), bold: true),
                const SizedBox(height: 10),
                FilledButton.icon(
                  onPressed: (_placingOrder || _cartItems.isEmpty)
                      ? null
                      : _placeOrder,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2E35D3),
                  ),
                  icon: const Icon(Icons.check_circle),
                  label: Text(
                    _placingOrder ? 'Placing Order...' : 'Place Order',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartItemCard(int i) {
    final item = _cartItems[i];

    Widget thumbnail() {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFE8ECFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: item.imageAsset == null
            ? Icon(item.icon, color: const Color(0xFF4C57BB))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.imageAsset!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(item.icon, color: const Color(0xFF4C57BB)),
                ),
              ),
      );
    }

    Widget qtyControls() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FF),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFDDE2F2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _changeQty(i, -1),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 26, height: 26),
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.remove_circle_outline, size: 18),
            ),
            SizedBox(
              width: 18,
              child: Text(
                '${item.qty}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            IconButton(
              onPressed: () => _changeQty(i, 1),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 26, height: 26),
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.add_circle_outline, size: 18),
            ),
            IconButton(
              onPressed: () => _removeItem(i),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 26, height: 26),
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.delete_outline, size: 18),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E7F3)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 390;
            final details = Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3248),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.seller} | ${_currency(item.price)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF686D86),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
            if (compact) {
              return Column(
                children: [
                  Row(
                    children: [thumbnail(), const SizedBox(width: 10), details],
                  ),
                  const SizedBox(height: 8),
                  Align(alignment: Alignment.centerRight, child: qtyControls()),
                ],
              );
            }
            return Row(
              children: [
                thumbnail(),
                const SizedBox(width: 10),
                details,
                const SizedBox(width: 8),
                qtyControls(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _billRow(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
      color: bold ? const Color(0xFF2E3046) : const Color(0xFF676D86),
      fontSize: bold ? 18 : 14,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(label, style: style),
          const Spacer(),
          Text(value, style: style),
        ],
      ),
    );
  }
}

class _CartLineItem {
  final String title;
  final String seller;
  final double price;
  final IconData icon;
  final String? imageAsset;
  int qty;

  _CartLineItem({
    required this.title,
    required this.seller,
    required this.price,
    required this.qty,
    required this.icon,
    this.imageAsset,
  });
}

class _OrderHistoryEntry {
  final String id;
  final String date;
  final String status;
  final double total;
  final List<_CartLineItem> items;

  _OrderHistoryEntry({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });
}

class ResidentSettingsPage extends StatefulWidget {
  const ResidentSettingsPage({super.key});

  @override
  State<ResidentSettingsPage> createState() => _ResidentSettingsPageState();
}

class _ResidentSettingsPageState extends State<ResidentSettingsPage> {
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3644B7), Color(0xFF6B79E9)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x262E35D3),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.settings, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manage Your Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Control security, profile updates, and preferences.',
                          style: TextStyle(color: Color(0xFFDDE1FF)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE6E8F4)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    value: _pushNotifications,
                    onChanged: (v) => setState(() => _pushNotifications = v),
                    title: const Text(
                      'Push Notifications',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text('Receive account and service updates'),
                    activeThumbColor: const Color(0xFF2E35D3),
                    activeTrackColor: const Color(0xFFBAC0FF),
                  ),
                  const Divider(height: 1),
                  _settingsTile(
                    context,
                    title: 'Reset Password',
                    icon: Icons.lock_reset,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentChangePasswordPage(),
                      ),
                    ),
                  ),
                  _settingsTile(
                    context,
                    title: 'Change Email',
                    icon: Icons.alternate_email,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentChangeEmailPage(),
                      ),
                    ),
                  ),
                  _settingsTile(
                    context,
                    title: 'Change Address',
                    icon: Icons.home_work_outlined,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentChangeAddressPage(),
                      ),
                    ),
                  ),
                  _settingsTile(
                    context,
                    title: 'Share the App',
                    icon: Icons.share_outlined,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentSharePage(),
                      ),
                    ),
                  ),
                  _settingsTile(
                    context,
                    title: 'Delete Account',
                    icon: Icons.delete_outline,
                    danger: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentDeleteAccountPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    final color = danger ? const Color(0xFFD74637) : const Color(0xFF404662);
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w700, color: color),
      ),
      trailing: Icon(Icons.chevron_right, color: color),
      onTap: onTap,
    );
  }
}

class ResidentChangePasswordPage extends StatelessWidget {
  const ResidentChangePasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            const SizedBox(height: 8),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _showFeature(context, 'Password updated'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2E35D3),
                ),
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentChangeEmailPage extends StatelessWidget {
  const ResidentChangeEmailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Email')),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'New Email')),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'Confirm Email')),
          ],
        ),
      ),
    );
  }
}

class ResidentChangeAddressPage extends StatelessWidget {
  const ResidentChangeAddressPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Address')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          12,
          12,
          12,
          12 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ListView(
          children: [
            const _StepTabs(active: 'Address'),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please Complete Your Address Details:',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(labelText: '1. Select Province'),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: '2. Select City/Municipality',
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(labelText: '3. Select Barangay'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _showFeature(context, 'Address saved'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2E35D3),
                ),
                child: const Text('CONTINUE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentDeleteAccountPage extends StatefulWidget {
  const ResidentDeleteAccountPage({super.key});

  @override
  State<ResidentDeleteAccountPage> createState() =>
      _ResidentDeleteAccountPageState();
}

class _ResidentDeleteAccountPageState extends State<ResidentDeleteAccountPage> {
  final _confirmController = TextEditingController();
  bool _accepted = false;

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleDelete() async {
    final typed = _confirmController.text.trim().toUpperCase();
    if (typed != 'DELETE') {
      _showFeature(context, 'Type DELETE to continue.');
      return;
    }
    if (!_accepted) {
      _showFeature(context, 'Please confirm account deletion notice.');
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Final Confirmation'),
        content: const Text(
          'This action permanently deletes your resident account and profile records. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFD74637),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const RoleGatewayScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FF), Color(0xFFF9F1EF)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF1D4D4)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFD74637),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Before You Continue',
                        style: TextStyle(
                          color: Color(0xFFAC3226),
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Deleting your account is permanent. Your profile, requests, and saved records will no longer be accessible.',
                    style: TextStyle(
                      color: Color(0xFF5A607B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE6E8F4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Type DELETE to confirm',
                    style: TextStyle(
                      color: Color(0xFF32374E),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _confirmController,
                    decoration: const InputDecoration(
                      hintText: 'DELETE',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: _accepted,
                    onChanged: (v) => setState(() => _accepted = v ?? false),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'I understand this action cannot be undone.',
                      style: TextStyle(
                        color: Color(0xFF4E546F),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _handleDelete,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFD74637),
                ),
                icon: const Icon(Icons.delete_forever_rounded),
                label: const Text('Delete Account Permanently'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentMemberListPage extends StatelessWidget {
  const ResidentMemberListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Added Member Profiles')),
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('No Added Profiles'))),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResidentAddMemberPage(),
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2E35D3),
                ),
                child: const Text('Add New Member'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResidentAddMemberPage extends StatefulWidget {
  const ResidentAddMemberPage({super.key});

  @override
  State<ResidentAddMemberPage> createState() => _ResidentAddMemberPageState();
}

class _ResidentAddMemberPageState extends State<ResidentAddMemberPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _dobController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _genderController = TextEditingController();
  final _religionController = TextEditingController();
  final _civilStatusController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _suffixController.dispose();
    _dobController.dispose();
    _birthPlaceController.dispose();
    _bloodTypeController.dispose();
    _genderController.dispose();
    _religionController.dispose();
    _civilStatusController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _showFeature(
      context,
      'New resident profile saved for ${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Resident'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FF), Color(0xFFF8F0EE)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3746B9), Color(0xFF6B78E8)],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x262E35D3),
                      blurRadius: 13,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0x33FFFFFF),
                      child: Icon(Icons.person_add, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resident Profile Intake',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Capture identity and household details for records.',
                            style: TextStyle(color: Color(0xFFDDE1FF)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _memberInput(
                controller: _firstNameController,
                label: 'First Name *',
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'First name is required.'
                    : null,
              ),
              const SizedBox(height: 8),
              _memberInput(
                controller: _middleNameController,
                label: 'Middle Name (Optional)',
              ),
              const SizedBox(height: 8),
              _memberInput(
                controller: _lastNameController,
                label: 'Last Name *',
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Last name is required.'
                    : null,
              ),
              const SizedBox(height: 8),
              _memberInput(
                controller: _suffixController,
                label: 'Suffix (Optional)',
              ),
              const SizedBox(height: 8),
              _memberInput(
                controller: _dobController,
                label: 'Date of Birth *',
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Date of birth is required.'
                    : null,
              ),
              const SizedBox(height: 8),
              _memberInput(
                controller: _birthPlaceController,
                label: 'Place of Birth',
              ),
              const SizedBox(height: 8),
              _memberInput(
                controller: _bloodTypeController,
                label: 'Blood Type',
              ),
              const SizedBox(height: 8),
              _memberInput(controller: _genderController, label: 'Gender'),
              const SizedBox(height: 8),
              _memberInput(controller: _religionController, label: 'Religion'),
              const SizedBox(height: 8),
              _memberInput(
                controller: _civilStatusController,
                label: 'Civil Status',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: FilledButton(
          onPressed: _save,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF2E35D3),
          ),
          child: const Text('Save and Finish'),
        ),
      ),
    );
  }

  Widget _memberInput({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE4E7F4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF4B56BA), width: 1.4),
        ),
      ),
    );
  }
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String _query = '';

  static const _faqItems = [
    (
      'How do I request a barangay clearance?',
      'Open Services > Clearance, complete your profile details, submit purpose, and track status in Requests.',
      'Clearance',
    ),
    (
      'How long does assistance approval take?',
      'Assistance requests are reviewed within 1-3 working days depending on document completeness.',
      'Assistance',
    ),
    (
      'How do I verify my RBI profile?',
      'Go to Profile > Verify Account, complete required details, and upload valid supporting documents.',
      'RBI',
    ),
    (
      'Can I update my address after registration?',
      'Yes. Open Settings > Change Address and submit your updated barangay details.',
      'Account',
    ),
    (
      'How do I report an emergency incident?',
      'Go to Services > BPAT or Responder and select report/patrol request for immediate action.',
      'Safety',
    ),
    (
      'How do I contact support?',
      'Use Support page quick actions (call, email, FAQ search, or submit a ticket).',
      'Support',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final items = _faqItems.where((item) {
      final bag = '${item.$1} ${item.$2} ${item.$3}'.toLowerCase();
      return q.isEmpty || bag.contains(q);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4453C8), Color(0xFF7382F0)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x233441B2),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.help_center, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search using keywords...',
              ),
            ),
            const SizedBox(height: 8),
            if (items.isEmpty)
              const Card(
                child: ListTile(
                  leading: Icon(Icons.search_off),
                  title: Text('No FAQ results found'),
                ),
              )
            else
              ...items.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFFE6E8F4)),
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    title: Text(
                      item.$1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2F3248),
                      ),
                    ),
                    subtitle: Text(
                      item.$3,
                      style: const TextStyle(
                        color: Color(0xFF6D7390),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.$2,
                            style: const TextStyle(
                              color: Color(0xFF5C627D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TermsPolicyScreen extends StatelessWidget {
  const TermsPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy and Terms'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4453C8), Color(0xFF6D7CE8)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x223541B3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.policy, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Data Privacy and Platform Terms',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _policyCard(
              title: 'Privacy Policy',
              subtitle: 'Last Updated: Feb 20, 2026',
              points: const [
                'Personal information is used only for barangay service delivery.',
                'Sensitive profile data is protected and access-controlled.',
                'Residents may request profile corrections through Settings.',
              ],
            ),
            const SizedBox(height: 9),
            _policyCard(
              title: 'Terms and Conditions',
              subtitle: 'Last Updated: Feb 20, 2026',
              points: const [
                'Use accurate information for requests and registrations.',
                'Abusive, fraudulent, or false submissions may be blocked.',
                'Service timelines may vary based on document verification.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _policyCard({
    required String title,
    required String subtitle,
    required List<String> points,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E8F4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2E3248),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF6B728D),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ...points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Color(0xFF3FA96D),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      p,
                      style: const TextStyle(
                        color: Color(0xFF5B617D),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class ResidentFaqPage extends StatelessWidget {
  const ResidentFaqPage({super.key});
  @override
  Widget build(BuildContext context) => const FaqScreen();
}

class ResidentSharePage extends StatelessWidget {
  const ResidentSharePage({super.key});

  static const _residentPrimary = Color(0xFF3E4CC7);
  static const _residentSoft = Color(0xFFE7ECFF);

  static const _shareMessage =
      'Download BarangayMo Residents to access barangay services, '
      'request documents, and community updates in one app.';
  static const _androidLink =
      'https://play.google.com/store/apps/details?id=ph.barangaymo.residents';
  static const _iosLink = 'https://apps.apple.com/ph/app/barangaymo-residents';

  Widget _shareOptionTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String actionText,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _showFeature(context, actionText),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: _residentPrimary),
            const SizedBox(width: 9),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF2C3147),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storeButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String link,
  }) {
    return OutlinedButton.icon(
      onPressed: () => _showFeature(context, 'Open store link: $link'),
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: _residentPrimary,
        side: const BorderSide(color: Color(0xFFC7D2FF)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        backgroundColor: _residentPrimary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F7FF), Color(0xFFF1F4FF)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              children: [
                const Text(
                  'BarangayMo Residents',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2A3048),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Help your friends and family discover barangay services and community updates through Smart Barangay.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF616881),
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE2E6F2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('public/barangaymo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFDDE4FA)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Share Options',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          color: _residentPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _shareOptionTile(
                        context: context,
                        icon: Icons.email_outlined,
                        label: 'SHARE VIA EMAIL',
                        actionText: 'Preparing email with app link...',
                      ),
                      _shareOptionTile(
                        context: context,
                        icon: Icons.facebook,
                        label: 'SHARE VIA FACEBOOK',
                        actionText: 'Preparing Facebook share post...',
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _residentSoft,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFCDD8FF)),
                        ),
                        child: Text(
                          _shareMessage,
                          style: const TextStyle(
                            color: Color(0xFF4C5577),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFDDE4FA)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'App Store Links',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: _residentPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _storeButton(
                              context: context,
                              icon: Icons.apple,
                              label: 'App Store',
                              link: _iosLink,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _storeButton(
                              context: context,
                              icon: Icons.play_arrow_rounded,
                              label: 'Google Play',
                              link: _androidLink,
                            ),
                          ),
                        ],
                      ),
                    ],
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

class ResidentCommunityChatPage extends StatefulWidget {
  const ResidentCommunityChatPage({super.key});

  @override
  State<ResidentCommunityChatPage> createState() =>
      _ResidentCommunityChatPageState();
}

class _ResidentCommunityChatPageState extends State<ResidentCommunityChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  String _channel = 'General';

  final List<_ResidentChatMessage> _messages = [
    _ResidentChatMessage(
      sender: 'Barangay Admin',
      text:
          'Good morning residents. Water interruption is scheduled tomorrow 9:00 AM to 12:00 PM.',
      channel: 'Announcements',
      sentAt: DateTime.now().subtract(const Duration(minutes: 34)),
      isMine: false,
      isOfficial: true,
    ),
    _ResidentChatMessage(
      sender: 'Lester C. Nadong',
      text:
          'Please avoid parking near the barangay hall gate for today\'s relief truck unloading.',
      channel: 'General',
      sentAt: DateTime.now().subtract(const Duration(minutes: 28)),
      isMine: false,
      isOfficial: true,
    ),
    _ResidentChatMessage(
      sender: 'Shamira Balandra',
      text: 'Noted po, salamat sa update.',
      channel: 'General',
      sentAt: DateTime.now().subtract(const Duration(minutes: 25)),
      isMine: true,
      isOfficial: false,
    ),
    _ResidentChatMessage(
      sender: 'Health Desk',
      text: 'Free blood pressure screening starts at 2:00 PM today.',
      channel: 'Health',
      sentAt: DateTime.now().subtract(const Duration(minutes: 14)),
      isMine: false,
      isOfficial: true,
    ),
    _ResidentChatMessage(
      sender: 'Shamira Balandra',
      text: 'Can seniors join without prior registration?',
      channel: 'Health',
      sentAt: DateTime.now().subtract(const Duration(minutes: 11)),
      isMine: true,
      isOfficial: false,
    ),
    _ResidentChatMessage(
      sender: 'Health Desk',
      text: 'Yes. Walk-ins are accepted from 1:30 PM onward.',
      channel: 'Health',
      sentAt: DateTime.now().subtract(const Duration(minutes: 9)),
      isMine: false,
      isOfficial: true,
    ),
  ];

  static const _channels = ['General', 'Announcements', 'Health', 'Events'];

  List<_ResidentChatMessage> get _filteredMessages =>
      _messages.where((m) => m.channel == _channel).toList()
        ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(
        _ResidentChatMessage(
          sender: 'Shamira Balandra',
          text: text,
          channel: _channel,
          sentAt: DateTime.now(),
          isMine: true,
          isOfficial: false,
        ),
      );
      _messageController.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = _filteredMessages;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Chat'),
        backgroundColor: const Color(0xFFF7F8FC),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FC), Color(0xFFF2F4FF)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE1E5F4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5EBFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.forum_rounded,
                            color: Color(0xFF3B4FC3),
                          ),
                        ),
                        const SizedBox(width: 9),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'West Tapinac Resident Chat',
                                style: TextStyle(
                                  color: Color(0xFF2D334A),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                '134 online now',
                                style: TextStyle(
                                  color: Color(0xFF5F6682),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F7EC),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Color(0xFF2B8456),
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _channels.map((entry) {
                          final active = entry == _channel;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Text(entry),
                              selected: active,
                              onSelected: (_) =>
                                  setState(() => _channel = entry),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        'No messages yet for this channel.',
                        style: TextStyle(
                          color: Color(0xFF6A7089),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(12, 2, 12, 10),
                      itemCount: messages.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 7),
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final mine = message.isMine;
                        return Align(
                          alignment: mine
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            padding: const EdgeInsets.fromLTRB(11, 8, 11, 8),
                            decoration: BoxDecoration(
                              color: mine
                                  ? const Color(0xFFDCE6FF)
                                  : const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: mine
                                    ? const Color(0xFFC3D3FF)
                                    : const Color(0xFFE2E6F4),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      message.sender,
                                      style: TextStyle(
                                        color: mine
                                            ? const Color(0xFF3346A8)
                                            : const Color(0xFF2E334A),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                      ),
                                    ),
                                    if (message.isOfficial) ...[
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.verified,
                                        color: Color(0xFF2E8B57),
                                        size: 14,
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  message.text,
                                  style: const TextStyle(
                                    color: Color(0xFF3A4057),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatTime(message.sentAt),
                                  style: const TextStyle(
                                    color: Color(0xFF78809A),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SafeArea(
              top: false,
              minimum: const EdgeInsets.only(bottom: 6),
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F8FC),
                  border: Border(top: BorderSide(color: Color(0xFFE0E4F3))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Message $_channel...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFDCE1F1),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _sendMessage,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF4052CA),
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResidentChatMessage {
  final String sender;
  final String text;
  final String channel;
  final DateTime sentAt;
  final bool isMine;
  final bool isOfficial;

  const _ResidentChatMessage({
    required this.sender,
    required this.text,
    required this.channel,
    required this.sentAt,
    required this.isMine,
    required this.isOfficial,
  });
}

class ResidentSupportPage extends StatelessWidget {
  const ResidentSupportPage({super.key});

  static const _officePoint = LatLng(14.8386, 120.2865);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: const Color(0xFFF7F8FC),
      ),
      body: Container(
        color: const Color(0xFFF7F8FC),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
          children: [
            const Text(
              'Welcome, Shamira',
              style: TextStyle(
                color: Color(0xFF2B3047),
                fontSize: 31,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'How can we help you?',
              style: TextStyle(
                color: Color(0xFF5E667F),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _supportAction(
                    context,
                    title: 'Call us',
                    subtitle: '(047) 251-2041',
                    icon: Icons.call,
                    onTap: () =>
                        _showFeature(context, 'Calling support line...'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _supportAction(
                    context,
                    title: 'Email Us',
                    subtitle: 'support@barangaymo.ph',
                    icon: Icons.email_outlined,
                    onTap: () =>
                        _showFeature(context, 'Opening email support...'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _supportAction(
                    context,
                    title: 'Search FAQs',
                    subtitle: 'Help Center',
                    icon: Icons.search_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentFaqPage(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE6E8F4)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0E000000),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Office Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3248),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '1953 Purok 7, Old Cabalan, Olongapo City, PH',
                    style: TextStyle(
                      color: Color(0xFF5D627C),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Mon-Fri 8:00 AM - 5:00 PM',
                    style: TextStyle(
                      color: Color(0xFF6B718D),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE3E7F4)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 9,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: _officePoint,
                  initialZoom: 15.1,
                  interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.barangaymo_app',
                  ),
                  const MarkerLayer(
                    markers: [
                      Marker(
                        point: _officePoint,
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.location_on,
                          color: Color(0xFFD44B43),
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResidentBugReportPage(),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF3B4360),
                  side: const BorderSide(color: Color(0xFFD6DBEB)),
                ),
                icon: const Icon(Icons.campaign),
                label: const Text('Submit a Support Ticket'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _supportAction(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE6E8F4)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF5D647F)),
            const SizedBox(height: 7),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF2F3248),
              ),
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF666D88),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentBugReportPage extends StatefulWidget {
  const ResidentBugReportPage({super.key});

  @override
  State<ResidentBugReportPage> createState() => _ResidentBugReportPageState();
}

class _ResidentBugReportPageState extends State<ResidentBugReportPage> {
  final _bugNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _screenshotName;

  @override
  void dispose() {
    _bugNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bug Report'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3443B7), Color(0xFF6976E7)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x262E35D3),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.bug_report, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Report a Problem',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Help us resolve issues quickly by sharing clear details and a screenshot.',
                          style: TextStyle(color: Color(0xFFDDE1FF)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE6E8F4)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _bugNameController,
                    decoration: const InputDecoration(labelText: 'Bug Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText:
                          'Describe what happened and steps to reproduce.',
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFDDE2F6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Color(0xFF4A55B8),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Upload Screenshot',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF363B57),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_screenshotName != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE0E3F4),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.insert_photo,
                                  color: Color(0xFF4A55B8),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _screenshotName!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      setState(() => _screenshotName = null),
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                          )
                        else
                          const Text(
                            'No screenshot attached yet.',
                            style: TextStyle(color: Color(0xFF6A6F89)),
                          ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _mockAttach('gallery'),
                                icon: const Icon(Icons.photo_library_outlined),
                                label: const Text('Gallery'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _mockAttach('camera'),
                                icon: const Icon(Icons.camera_alt_outlined),
                                label: const Text('Camera'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: FilledButton(
          onPressed: () {
            _showFeature(context, 'Bug report submitted. Thank you!');
            Navigator.pop(context);
          },
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF2E35D3),
          ),
          child: const Text('Submit Ticket'),
        ),
      ),
    );
  }

  void _mockAttach(String source) {
    final stamp = DateTime.now().millisecondsSinceEpoch % 100000;
    setState(() => _screenshotName = '${source}_screenshot_$stamp.png');
  }
}

class ResidentVerifyProfilePage extends StatefulWidget {
  const ResidentVerifyProfilePage({super.key});

  @override
  State<ResidentVerifyProfilePage> createState() =>
      _ResidentVerifyProfilePageState();
}

class _ResidentVerifyProfilePageState extends State<ResidentVerifyProfilePage> {
  final Map<String, bool> _utilities = {
    'Electricity': true,
    'Water Supply': true,
    'Sewage/Toilet Facilities': true,
    'Garbage/Waste Disposal': false,
    'Internet Access': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      appBar: AppBar(
        title: const Text(
          'Complete Profile Information',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF6F8FF),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F8FF), Color(0xFFF8F0EE)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3E4CC7), Color(0xFF6673E5)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x262E35D3),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _ResidentEditableProfileAvatar(
                    size: 64,
                    onEdit: () => _openResidentProfilePhotoEditor(context),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shamira Balandra',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'RBI-3-7-34-84414283',
                          style: TextStyle(color: Color(0xFFDDE1FF)),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Profile Completion: 78%',
                          style: TextStyle(
                            color: Color(0xFFF2F4FF),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _openResidentProfilePhotoEditor(context),
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _formSection(
              title: 'Education and Employment',
              icon: Icons.school_outlined,
              children: const [
                SizedBox(height: 8),
                _StyledInput(label: 'Highest Educational Attainment *'),
                SizedBox(height: 8),
                _StyledInput(label: 'Type of Employment *'),
                SizedBox(height: 8),
                _StyledInput(label: 'Sector'),
              ],
            ),
            const SizedBox(height: 10),
            _formSection(
              title: 'Household Information',
              icon: Icons.home_work_outlined,
              children: const [
                SizedBox(height: 8),
                _StyledInput(label: 'Number of People in the Household *'),
                SizedBox(height: 8),
                _StyledInput(label: 'Monthly Household Income'),
                SizedBox(height: 8),
                _StyledInput(label: 'House Ownership Status *'),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE4E7F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.power, color: Color(0xFF4653B7)),
                      SizedBox(width: 8),
                      Text(
                        'Utilities Available',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2E3146),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._utilities.entries.map(
                    (entry) => _utilityRow(
                      label: entry.key,
                      enabled: entry.value,
                      onChanged: (v) =>
                          setState(() => _utilities[entry.key] = v),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE7EAFF), Color(0xFFF4F2FF)],
                ),
                border: Border.all(color: const Color(0xFFD9DFFF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.verified_user, color: Color(0xFF2E35D3)),
                      SizedBox(width: 8),
                      Text(
                        'Verify Your Account',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'To access comprehensive barangay services, e-commerce, and job benefits, ensure your profile details are complete and accurate.',
                    style: TextStyle(
                      color: Color(0xFF4B4F69),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () =>
                              _showFeature(context, 'Verification submitted'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF2E35D3),
                          ),
                          child: const Text('Verify Now'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Maybe Later'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E7F3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4653B7)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2E3146),
                ),
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _utilityRow({
    required String label,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5F7),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFEDE7EB)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF5C5F74),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Switch.adaptive(
            value: enabled,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF2E35D3),
            activeTrackColor: const Color(0xFFB5B9FF),
          ),
        ],
      ),
    );
  }
}

class _StyledInput extends StatelessWidget {
  final String label;
  const _StyledInput({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF9FAFF),
        labelStyle: const TextStyle(
          color: Color(0xFF5D6281),
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE2E5F1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF4B56BA), width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}

class ResidentAboutPage extends StatelessWidget {
  const ResidentAboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
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
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3F4CC5), Color(0xFF6B79E8)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26303AB0),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.apartment, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BarangayMo Platform',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 23,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Digital frontline services for residents, officials, and local governance.',
                          style: TextStyle(
                            color: Color(0xFFDDE2FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(
                  child: _AboutKpi(
                    title: '22,365',
                    subtitle: 'Residents Served',
                    icon: Icons.people,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _AboutKpi(
                    title: '24/7',
                    subtitle: 'Service Access',
                    icon: Icons.public,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _aboutCard(
              title: 'Our Mission',
              body:
                  'Improve local governance through transparent and accessible digital services that connect residents, officials, and community programs.',
              icon: Icons.track_changes,
            ),
            const SizedBox(height: 9),
            _aboutCard(
              title: 'Our Team',
              body:
                  'A joint team of barangay officers, service staff, and technology partners committed to faster public service delivery.',
              icon: Icons.groups,
            ),
            const SizedBox(height: 9),
            _aboutCard(
              title: 'Core Values',
              body:
                  'Accuracy, accountability, inclusivity, and community-first support for every request and transaction.',
              icon: Icons.verified_user,
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutCard({
    required String title,
    required String body,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E8F4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFE8ECFF),
            ),
            child: Icon(icon, color: const Color(0xFF4B56BA), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2E3248),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    color: Color(0xFF5D637F),
                    fontWeight: FontWeight.w600,
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

class _AboutKpi extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _AboutKpi({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E8F4)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFE8ECFF),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF4B56BA)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2E3248),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6A708C),
                    fontWeight: FontWeight.w600,
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

class ResidentTermsPage extends StatelessWidget {
  const ResidentTermsPage({super.key});
  @override
  Widget build(BuildContext context) => const TermsPolicyScreen();
}

class ResidentNotificationsPage extends StatelessWidget {
  const ResidentNotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Notifications'),
              Tab(text: 'History'),
              Tab(text: 'Transactions'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ResidentJobNotificationsTab(),
            _ResidentHistory(),
            Center(child: Text('Empty Transactions')),
          ],
        ),
      ),
    );
  }
}

class _ResidentJobNotificationsTab extends StatelessWidget {
  const _ResidentJobNotificationsTab();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _ResidentJobsHub.refresh,
      builder: (_, __, ___) {
        final items = _ResidentJobsHub.notifications;
        if (items.isEmpty) {
          return const Center(child: Text('Empty Notifications'));
        }
        return ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _ResidentJobsHub.markAllRead,
                icon: const Icon(Icons.done_all_rounded, size: 18),
                label: const Text('Mark all as read'),
              ),
            ),
            ...items.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  color: item.unread ? const Color(0xFFF4F7FF) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: item.unread
                        ? const Color(0xFFD7E3FF)
                        : const Color(0xFFE7E9F2),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.accent.withValues(alpha: 0.16),
                    child: Icon(item.icon, color: item.accent),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3248),
                    ),
                  ),
                  subtitle: Text(
                    item.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF636983),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _ResidentJobsHub.timeAgo(item.createdAt),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7190),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (item.unread)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF4A64FF),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    item.unread = false;
                    _ResidentJobsHub.refresh.value++;
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _ResidentHistory extends StatelessWidget {
  const _ResidentHistory();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: List.generate(
        4,
        (i) => Card(
          child: ListTile(
            title: const Text('Profile Update'),
            subtitle: const Text('You updated your profile details.'),
            trailing: const Text('4 hours ago'),
          ),
        ),
      ),
    );
  }
}
