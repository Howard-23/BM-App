part of barangaymo_app;

const _officialHeaderStart = Color(0xFF9F1A1A);
const _officialHeaderEnd = Color(0xFFC92A2A);
const _officialSurface = Color(0xFFF5F6FB);
const _officialCardBorder = Color(0xFFE4E7F1);
const _officialText = Color(0xFF252A3D);
const _officialSubtext = Color(0xFF636A82);

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int tab = 0;
  final pages = const [
    _OfficialHomePage(),
    _SimplePage(
      'Official',
      [
        'Council Agenda: Regular session on Monday at 9:00 AM',
        'Pending Approvals: 12 permit and endorsement requests',
        'Public Notices: 4 active postings this week',
        'Scheduled Hearings: 3 mediation cases this week',
      ],
      icon: Icons.account_balance,
      subtitle: 'Governance operations and council updates',
    ),
    _SimplePage(
      'Market',
      [
        'Marketplace Vendors: 118 registered stalls',
        'Today\'s Transactions: 64 logged as of 8:00 PM',
        'Top Category: Fresh produce and dry goods',
        'Delivery Requests: 23 pending rider pickups',
      ],
      icon: Icons.storefront_rounded,
      subtitle: 'Local commerce, inventory, and transaction pulse',
    ),
    SerbilisServicesPage(),
    _SimplePage(
      'Profile',
      [
        'Account Name: Barangay Official',
        'Office: Barangay Administration',
        'Role: Records and Services',
        'Status: Active',
      ],
      icon: Icons.person,
      subtitle: 'Personal and account management overview',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _officialSurface,
      appBar: AppBar(
        title: const _BarangayMoLogo(width: 145),
        backgroundColor: _officialHeaderStart,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_officialHeaderStart, _officialHeaderEnd],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showFeature(context, 'No new notifications.'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFFCFCFF),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_officialHeaderStart, _officialHeaderEnd],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BarangayMoLogo(width: 150),
                  SizedBox(height: 10),
                  Text(
                    'Barangay Officials',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Administrative tools and governance controls',
                    style: TextStyle(
                      color: Color(0xFFFDE5E5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _officialCardBorder),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFEA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.location_city,
                      color: _officialHeaderStart,
                    ),
                  ),
                  title: const Text(
                    'West Tapinac Barangay Profile',
                    style: TextStyle(
                      color: _officialText,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: const Text(
                    'City of Olongapo, Zambales',
                    style: TextStyle(
                      color: _officialSubtext,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OfficialBarangayProfilePage(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 2, 14, 6),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: _officialSubtext,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _m(context, 'Barangay Profile'),
            _m(context, 'Barangay Activation'),
            _m(context, 'Settings'),
            _m(context, 'RBI Records'),
            _m(context, 'FAQs'),
            _m(context, 'Notifications'),
            _m(context, 'Support'),
            _m(context, 'Bug Report'),
            _m(context, 'Terms & Policies'),
            _m(context, 'Log out'),
            _m(context, 'Delete Account', color: const Color(0xFFCD3D3D)),
          ],
        ),
      ),
      body: pages[tab],
      floatingActionButton: tab == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFFBD1F1F),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CommunityPage()),
              ),
              child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        height: 72,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        indicatorColor: const Color(0xFFFFE2DD),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shield), label: 'Official'),
          NavigationDestination(icon: Icon(Icons.store), label: 'Market'),
          NavigationDestination(
            icon: Icon(Icons.miscellaneous_services),
            label: 'Services',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  IconData _menuIcon(String title) {
    switch (title) {
      case 'Settings':
        return Icons.settings;
      case 'Barangay Profile':
        return Icons.location_city;
      case 'Barangay Activation':
        return Icons.verified_user_outlined;
      case 'RBI Records':
        return Icons.badge_outlined;
      case 'FAQs':
        return Icons.quiz_outlined;
      case 'Notifications':
        return Icons.notifications_none;
      case 'Support':
        return Icons.support_agent;
      case 'Bug Report':
        return Icons.bug_report_outlined;
      case 'Terms & Policies':
        return Icons.gavel_outlined;
      case 'Log out':
        return Icons.logout;
      case 'Delete Account':
        return Icons.delete_outline;
      default:
        return Icons.arrow_right;
    }
  }

  Widget _m(BuildContext c, String t, {Color? color}) {
    final isDanger = color != null;
    final tileColor = isDanger ? const Color(0xFFFFF0F0) : Colors.white;
    final textColor = color ?? _officialText;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Container(
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDanger ? const Color(0xFFFFD0D0) : _officialCardBorder,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          dense: true,
          leading: Icon(_menuIcon(t), color: textColor),
          title: Text(
            t,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
          ),
          trailing: Icon(Icons.chevron_right, color: textColor),
          onTap: () {
            Navigator.pop(c);
            switch (t) {
              case 'Barangay Profile':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialBarangayProfilePage(),
                  ),
                );
                return;
              case 'Barangay Activation':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ActivationFlow(goToHomeOnFinish: false),
                  ),
                );
                return;
              case 'Settings':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialSettingsPage(),
                  ),
                );
                return;
              case 'RBI Records':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialRbiRecordsPage(),
                  ),
                );
                return;
              case 'FAQs':
                Navigator.push(
                  c,
                  MaterialPageRoute(builder: (_) => const OfficialFaqsPage()),
                );
                return;
              case 'Notifications':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialNotificationsPage(),
                  ),
                );
                return;
              case 'Support':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialSupportPage(),
                  ),
                );
                return;
              case 'Bug Report':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialBugReportPage(),
                  ),
                );
                return;
              case 'Terms & Policies':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialTermsPoliciesPage(),
                  ),
                );
                return;
              case 'Log out':
                Navigator.push(
                  c,
                  MaterialPageRoute(builder: (_) => const OfficialLogoutPage()),
                );
                return;
              case 'Delete Account':
                Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const OfficialDeleteAccountPage(),
                  ),
                );
                return;
              default:
                Navigator.push(
                  c,
                  MaterialPageRoute(builder: (_) => DetailPage(title: t)),
                );
            }
          },
        ),
      ),
    );
  }
}

class _OfficialHomePage extends StatelessWidget {
  const _OfficialHomePage();

  Widget _sectionHeader(
    BuildContext context,
    String title, {
    required VoidCallback onViewAll,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _officialText,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child: const Text(
            'View All',
            style: TextStyle(
              color: Color(0xFFB42828),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _metricCard({
    required IconData icon,
    required String label,
    required String value,
    required String note,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _officialCardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: const Color(0xFF9A4B4B)),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF5E647C),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFB01D1D),
              fontWeight: FontWeight.w900,
              fontSize: 34,
            ),
          ),
          Text(
            note,
            style: const TextStyle(
              color: _officialSubtext,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceShortcut(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        width: 88,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _officialCardBorder),
        ),
        child: Column(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEFEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: _officialHeaderStart),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _officialText,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F8FC), Color(0xFFF3ECEC)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _officialCardBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE0E4F2),
                      width: 2,
                    ),
                    color: const Color(0xFFF6F8FF),
                  ),
                  padding: const EdgeInsets.all(9),
                  child: Image.asset(
                    'public/barangaymo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.location_city,
                      color: _officialHeaderStart,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Old Cabalan',
                        style: TextStyle(
                          color: _officialText,
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'CITY OF OLONGAPO, ZAMBALES',
                        style: TextStyle(
                          color: _officialSubtext,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'PB REINARD NADONG',
                        style: TextStyle(
                          color: Color(0xFF4B526D),
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        'SK ANGEL VICTORIA BIBANCO',
                        style: TextStyle(
                          color: Color(0xFF4B526D),
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEFEA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.flag,
                    color: _officialHeaderStart,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.35,
            children: [
              _metricCard(
                icon: Icons.groups_2_outlined,
                label: 'Population',
                value: '22365',
                note: 'from PSA 2025',
              ),
              _metricCard(
                icon: Icons.verified_user_outlined,
                label: 'RBI',
                value: '2',
                note: 'RBI as of 2024',
              ),
              _metricCard(
                icon: Icons.hub_outlined,
                label: 'Divisions',
                value: '10',
                note: 'Zones',
              ),
              _metricCard(
                icon: Icons.history_edu_outlined,
                label: 'Year Founded',
                value: '1961',
                note: '64 Years',
              ),
            ],
          ),
          const SizedBox(height: 12),
          _sectionHeader(
            context,
            'Serbilis Services',
            onViewAll: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SerbilisServicesPage()),
            ),
          ),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _serviceShortcut(
                  context,
                  icon: Icons.local_shipping_outlined,
                  title: 'Responder',
                  page: const ResponderPage(),
                ),
                const SizedBox(width: 8),
                _serviceShortcut(
                  context,
                  icon: Icons.qr_code_scanner,
                  title: 'QR ID',
                  page: const ScanQrPage(),
                ),
                const SizedBox(width: 8),
                _serviceShortcut(
                  context,
                  icon: Icons.badge_outlined,
                  title: 'RBI',
                  page: const ResidentRbiCardPage(),
                ),
                const SizedBox(width: 8),
                _serviceShortcut(
                  context,
                  icon: Icons.local_police_outlined,
                  title: 'Police',
                  page: const SimpleSerbilisPage(
                    title: 'Police',
                    isOfficial: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _sectionHeader(
            context,
            'Community',
            onViewAll: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CommunityPage()),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _officialCardBorder),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: Image.asset(
                    'public/item-table.jpg',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 140,
                      color: const Color(0xFFE9EEFF),
                      child: const Center(
                        child: Icon(
                          Icons.image_rounded,
                          size: 44,
                          color: Color(0xFF6C74A4),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Text(
                    'Lester Nadong',
                    style: TextStyle(
                      color: _officialText,
                      fontWeight: FontWeight.w700,
                    ),
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

class _SimplePage extends StatefulWidget {
  final String title;
  final List<String> rows;
  final IconData icon;
  final String? subtitle;

  const _SimplePage(
    this.title,
    this.rows, {
    this.icon = Icons.dashboard_customize,
    this.subtitle,
  });

  @override
  State<_SimplePage> createState() => _SimplePageState();
}

class _SimplePageState extends State<_SimplePage> {
  late DateTime _lastSynced;
  int _refreshTick = 0;

  @override
  void initState() {
    super.initState();
    _lastSynced = DateTime.now();
  }

  Future<void> _refreshData() async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
    if (!mounted) return;
    setState(() {
      _refreshTick++;
      _lastSynced = DateTime.now();
    });
  }

  IconData _rowIcon(String text, int index) {
    final t = text.toLowerCase();
    if (t.contains('agenda')) return Icons.event_note_outlined;
    if (t.contains('hearing')) return Icons.balance_outlined;
    if (t.contains('vendors')) return Icons.storefront_outlined;
    if (t.contains('delivery')) return Icons.local_shipping_outlined;
    if (t.contains('population')) return Icons.people_alt_outlined;
    if (t.contains('rbi')) return Icons.badge_outlined;
    if (t.contains('founded')) return Icons.history_edu_outlined;
    if (t.contains('divisions')) return Icons.hub_outlined;
    if (t.contains('transactions')) return Icons.receipt_long_outlined;
    if (t.contains('address') || t.contains('city')) {
      return Icons.location_on_outlined;
    }
    if (t.contains('pending')) return Icons.pending_actions_outlined;
    if (t.contains('status')) return Icons.verified_user_outlined;
    if (t.contains('account')) return Icons.badge_outlined;
    if (t.contains('role')) return Icons.assignment_ind_outlined;
    return [
      Icons.insights_outlined,
      Icons.checklist_rtl_outlined,
      Icons.dataset_outlined,
      Icons.analytics_outlined,
      Icons.assignment_outlined,
    ][index % 5];
  }

  String _clockStamp(DateTime value) {
    final hour12 = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final minute = value.minute.toString().padLeft(2, '0');
    final suffix = value.hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $suffix';
  }

  String _dateStamp(DateTime value) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[value.month - 1]} ${value.day}, ${value.year}';
  }

  String _pulseValue(String raw, int index) {
    final match = RegExp(r'\d+').firstMatch(raw);
    if (match == null) return raw;
    final number = int.tryParse(match.group(0)!);
    if (number == null) return raw;
    final delta = ((_refreshTick + index) % 4) - 1;
    final nextValue = (number + delta).clamp(0, 99999);
    return raw.replaceFirst(match.group(0)!, '$nextValue');
  }

  _RowBadge _badgeForRow(String key, String value) {
    final combined = '$key $value'.toLowerCase();
    if (combined.contains('pending') ||
        combined.contains('delivery') ||
        combined.contains('hearing')) {
      return const _RowBadge(
        label: 'Needs Attention',
        icon: Icons.warning_amber_rounded,
        bg: Color(0xFFFFF3E8),
        fg: Color(0xFFB45309),
      );
    }
    if (combined.contains('status') ||
        combined.contains('active') ||
        combined.contains('account')) {
      return const _RowBadge(
        label: 'Stable',
        icon: Icons.verified_rounded,
        bg: Color(0xFFEAF7EE),
        fg: Color(0xFF1F6B3D),
      );
    }
    if (combined.contains('transactions') ||
        combined.contains('vendors') ||
        combined.contains('category')) {
      return const _RowBadge(
        label: 'Trending',
        icon: Icons.trending_up_rounded,
        bg: Color(0xFFEAF0FF),
        fg: Color(0xFF2A4DA3),
      );
    }
    if (combined.contains('agenda')) {
      return const _RowBadge(
        label: 'Upcoming',
        icon: Icons.calendar_month_rounded,
        bg: Color(0xFFFFEFE8),
        fg: Color(0xFFA13A1D),
      );
    }
    return const _RowBadge(
      label: 'Monitored',
      icon: Icons.visibility_rounded,
      bg: Color(0xFFEEF1F7),
      fg: Color(0xFF445270),
    );
  }

  String _hintForRow(String key, String value) {
    final combined = '$key $value'.toLowerCase();
    if (combined.contains('pending')) return 'Queue requires same-day review';
    if (combined.contains('transaction')) return 'Compared with latest sync';
    if (combined.contains('status')) return 'Identity and access validated';
    if (combined.contains('account')) return 'Verified account profile';
    if (combined.contains('delivery')) return 'Dispatch route updated';
    if (combined.contains('agenda')) return 'Published to council feed';
    return 'Monitored by operations desk';
  }

  Widget _statChip(
    IconData icon,
    String label, {
    required Color bg,
    required Color fg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: fg),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniBars(String seed, Color color) {
    final safeSeed = seed.isEmpty ? 'data' : seed;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(7, (i) {
        final code = safeSeed.codeUnitAt(i % safeSeed.length);
        final baseHeight = 6 + ((code + _refreshTick + (i * 7)) % 15);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          width: 4,
          height: baseHeight.toDouble(),
          margin: const EdgeInsets.only(right: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: i == 6 ? 1 : 0.7),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }

  List<_SimpleTimelineItem> _timelineItems() {
    final t = widget.title.toLowerCase();
    if (t == 'official') {
      return [
        _SimpleTimelineItem(
          title: 'Permit endorsement reviewed',
          note: 'Treasury desk completed pre-check.',
          time: _lastSynced.subtract(const Duration(minutes: 8)),
          icon: Icons.assignment_turned_in_rounded,
        ),
        _SimpleTimelineItem(
          title: 'Council memo published',
          note: 'Session reminders pushed to committee members.',
          time: _lastSynced.subtract(const Duration(minutes: 22)),
          icon: Icons.campaign_rounded,
        ),
        _SimpleTimelineItem(
          title: 'Hearing reminder sent',
          note: 'Mediation participants confirmed attendance.',
          time: _lastSynced.subtract(const Duration(minutes: 41)),
          icon: Icons.notifications_active_rounded,
        ),
      ];
    }
    if (t == 'market') {
      return [
        _SimpleTimelineItem(
          title: 'Vendor check-in completed',
          note: 'Morning inventory validated for 32 stalls.',
          time: _lastSynced.subtract(const Duration(minutes: 6)),
          icon: Icons.store_mall_directory_rounded,
        ),
        _SimpleTimelineItem(
          title: 'Payment batch posted',
          note: 'Receipts reconciled with marketplace ledger.',
          time: _lastSynced.subtract(const Duration(minutes: 18)),
          icon: Icons.receipt_long_rounded,
        ),
        _SimpleTimelineItem(
          title: 'Delivery route assigned',
          note: 'Rider dispatch aligned with zone priorities.',
          time: _lastSynced.subtract(const Duration(minutes: 37)),
          icon: Icons.local_shipping_rounded,
        ),
      ];
    }
    return [
      _SimpleTimelineItem(
        title: 'Security audit passed',
        note: 'No suspicious sign-in attempts detected.',
        time: _lastSynced.subtract(const Duration(minutes: 5)),
        icon: Icons.shield_rounded,
      ),
      _SimpleTimelineItem(
        title: 'Office profile updated',
        note: 'Directory contact details synchronized.',
        time: _lastSynced.subtract(const Duration(minutes: 29)),
        icon: Icons.contact_phone_rounded,
      ),
      _SimpleTimelineItem(
        title: 'Role permissions verified',
        note: 'Records and services module remains active.',
        time: _lastSynced.subtract(const Duration(minutes: 53)),
        icon: Icons.verified_user_rounded,
      ),
    ];
  }

  String _timeAgo(DateTime value) {
    final difference = _lastSynced.difference(value);
    final minutes = difference.inMinutes;
    if (minutes <= 0) return 'Just now';
    if (minutes < 60) return '$minutes min ago';
    final hours = difference.inHours;
    return '$hours hr ago';
  }

  @override
  Widget build(BuildContext context) {
    final palette = _SimplePalette.forTitle(widget.title);
    final subtitleText =
        widget.subtitle ?? 'Operational overview and quick summary';
    final timeline = _timelineItems();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [palette.bgStart, palette.bgEnd],
        ),
      ),
      child: RefreshIndicator(
        onRefresh: _refreshData,
        color: palette.accent,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 22),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [palette.heroStart, palette.heroEnd],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0x30FFFFFF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(widget.icon, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              subtitleText,
                              style: const TextStyle(
                                color: Color(0xFFFFEFEF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: _refreshData,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0x2AFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                            size: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _statChip(
                        Icons.sync_rounded,
                        'Synced ${_clockStamp(_lastSynced)}',
                        bg: const Color(0x30FFFFFF),
                        fg: Colors.white,
                      ),
                      _statChip(
                        Icons.today_rounded,
                        _dateStamp(_lastSynced),
                        bg: const Color(0x24FFFFFF),
                        fg: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...widget.rows.asMap().entries.map((entry) {
              final text = entry.value;
              final parts = text.split(':');
              final hasPair = parts.length > 1;
              final key = hasPair ? parts.first.trim() : text;
              final rawValue = hasPair ? parts.sublist(1).join(':').trim() : '';
              final value = hasPair
                  ? _pulseValue(rawValue, entry.key)
                  : rawValue;
              final isPureNumber = RegExp(r'^\d+$').hasMatch(value);
              final badge = _badgeForRow(key, value);

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: Duration(milliseconds: 220 + (entry.key * 80)),
                curve: Curves.easeOutCubic,
                builder: (context, anim, child) {
                  return Opacity(
                    opacity: anim,
                    child: Transform.translate(
                      offset: Offset(0, (1 - anim) * 14),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: _officialCardBorder),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: palette.softAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _rowIcon(text, entry.key),
                          color: palette.accent,
                          size: 21,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              key,
                              style: const TextStyle(
                                color: _officialSubtext,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              value,
                              maxLines: isPureNumber ? 1 : 2,
                              overflow: isPureNumber
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                              style: TextStyle(
                                color: _officialText,
                                fontWeight: FontWeight.w900,
                                fontSize: hasPair
                                    ? (isPureNumber ? 34 : 17)
                                    : 18,
                                height: hasPair
                                    ? (isPureNumber ? 1.04 : 1.2)
                                    : 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badge.bg,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        badge.icon,
                                        size: 14,
                                        color: badge.fg,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        badge.label,
                                        style: TextStyle(
                                          color: badge.fg,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                _miniBars('$key$value', palette.accent),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _hintForRow(key, value),
                              style: const TextStyle(
                                color: _officialSubtext,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _officialCardBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      color: palette.accent,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...timeline.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: palette.softAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              item.icon,
                              size: 17,
                              color: palette.accent,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: _officialText,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  item.note,
                                  style: const TextStyle(
                                    color: _officialSubtext,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _timeAgo(item.time),
                            style: const TextStyle(
                              color: _officialSubtext,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RowBadge {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;

  const _RowBadge({
    required this.label,
    required this.icon,
    required this.bg,
    required this.fg,
  });
}

class _SimpleTimelineItem {
  final String title;
  final String note;
  final DateTime time;
  final IconData icon;

  const _SimpleTimelineItem({
    required this.title,
    required this.note,
    required this.time,
    required this.icon,
  });
}

class _SimplePalette {
  final Color heroStart;
  final Color heroEnd;
  final Color bgStart;
  final Color bgEnd;
  final Color accent;
  final Color softAccent;

  const _SimplePalette({
    required this.heroStart,
    required this.heroEnd,
    required this.bgStart,
    required this.bgEnd,
    required this.accent,
    required this.softAccent,
  });

  static _SimplePalette forTitle(String title) {
    final t = title.toLowerCase();
    if (t == 'market') {
      return const _SimplePalette(
        heroStart: Color(0xFF9A3412),
        heroEnd: Color(0xFFEA580C),
        bgStart: Color(0xFFFFFAF5),
        bgEnd: Color(0xFFFFF1E8),
        accent: Color(0xFFC2410C),
        softAccent: Color(0xFFFFF1E5),
      );
    }
    if (t == 'profile') {
      return const _SimplePalette(
        heroStart: Color(0xFF1F3A5F),
        heroEnd: Color(0xFF2E5A8B),
        bgStart: Color(0xFFF5F8FC),
        bgEnd: Color(0xFFEAF1F8),
        accent: Color(0xFF254B76),
        softAccent: Color(0xFFE7EEF8),
      );
    }
    return const _SimplePalette(
      heroStart: _officialHeaderStart,
      heroEnd: _officialHeaderEnd,
      bgStart: Color(0xFFF7F8FC),
      bgEnd: Color(0xFFF3ECEC),
      accent: _officialHeaderStart,
      softAccent: Color(0xFFFFEFEA),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  const DetailPage({super.key, required this.title});

  IconData _detailIcon(String text, int index) {
    final t = text.toLowerCase();
    if (t.contains('privacy') || t.contains('terms')) {
      return Icons.policy_outlined;
    }
    if (t.contains('notify') || t.contains('history')) {
      return Icons.notifications_active_outlined;
    }
    if (t.contains('support') || t.contains('faq')) {
      return Icons.support_agent_outlined;
    }
    if (t.contains('search')) return Icons.search;
    if (t.contains('delete')) return Icons.delete_forever_outlined;
    if (t.contains('log out') || t.contains('back')) return Icons.logout;
    if (t.contains('upload')) return Icons.cloud_upload_outlined;
    if (t.contains('submit')) return Icons.task_alt_outlined;
    return [
      Icons.info_outline,
      Icons.tune_outlined,
      Icons.task_outlined,
      Icons.inventory_2_outlined,
    ][index % 4];
  }

  @override
  Widget build(BuildContext context) {
    final items = {
      'Barangay Profile': [
        'Barangay Name: West Tapinac',
        'Municipality/City: Olongapo City',
        'Province: Zambales',
        'Population: 22,365',
        'Households: 5,420',
        'Captain: Manuel Dalanan',
      ],
      'Settings': ['Notifications', 'Profile', 'Account Settings'],
      'RBI Records': [
        'Search name...',
        'Verified/Unverified tabs',
        'Records list',
      ],
      'FAQs': ['Common questions list', 'Search by keywords'],
      'Notifications': ['Notifications', 'History', 'Transactions'],
      'Support': ['support@barangaymo.online', '000 123 4567', 'FAQ button'],
      'Bug Report': [
        'Bug Name',
        'Description',
        'Upload Screenshot',
        'Submit Ticket',
      ],
      'Terms & Policies': ['Privacy Policy', 'Terms and Conditions'],
      'Log out': ['Are you sure you want to log out?', 'Go Back', 'Log Out'],
      'Delete Account': ['Type DELETE to confirm', 'Delete Account button'],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF7F8FF),
        foregroundColor: _officialText,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FC), Color(0xFFF4EEEE)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _officialCardBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_officialHeaderStart, _officialHeaderEnd],
                      ),
                    ),
                    child: const Icon(
                      Icons.dashboard_customize,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '$title Module',
                      style: const TextStyle(
                        color: _officialText,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...?items[title]?.asMap().entries.map((entry) {
              final value = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _officialCardBorder),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFEA),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      _detailIcon(value, entry.key),
                      color: _officialHeaderStart,
                    ),
                  ),
                  title: Text(
                    value,
                    style: const TextStyle(
                      color: _officialText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class OfficialSettingsPage extends StatefulWidget {
  const OfficialSettingsPage({super.key});

  @override
  State<OfficialSettingsPage> createState() => _OfficialSettingsPageState();
}

class _OfficialSettingsPageState extends State<OfficialSettingsPage> {
  bool _notificationsEnabled = false;

  Widget _settingsRow({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    bool highlight = false,
  }) {
    final borderColor = highlight
        ? const Color(0xFFFFC9C9)
        : const Color(0xFFF0F1F5);
    final tileColor = highlight ? const Color(0xFFFFF6F6) : Colors.white;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        leading: Icon(icon, color: const Color(0xFF2D3348), size: 21),
        title: Text(
          title,
          style: const TextStyle(
            color: _officialText,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        trailing:
            trailing ??
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFD32A2A),
              size: 24,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: _officialText,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            icon: const Icon(Icons.home_rounded, size: 20),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: _officialCardBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFECEFF8), Color(0xFFDDE3F1)],
                      ),
                      border: Border.all(
                        color: const Color(0xFFE0E4EF),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 62,
                      color: Color(0xFF7A829A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lester Nadong',
                    style: TextStyle(
                      color: _officialText,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Barangay Old Cabalan',
                    style: TextStyle(
                      color: _officialSubtext,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () =>
                        _showFeature(context, 'Change letter head'),
                    style: FilledButton.styleFrom(
                      backgroundColor: _officialHeaderStart,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'CHANGE LETTER HEAD',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFE9EBF2)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                    child: Column(
                      children: [
                        _settingsRow(
                          icon: Icons.notifications_none_rounded,
                          title: 'Notifications',
                          trailing: Switch.adaptive(
                            value: _notificationsEnabled,
                            onChanged: (v) {
                              setState(() => _notificationsEnabled = v);
                            },
                          ),
                        ),
                        _settingsRow(
                          icon: Icons.person_outline_rounded,
                          title: 'Profile',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const OfficialProfileSettingsPage(),
                            ),
                          ),
                        ),
                        _settingsRow(
                          icon: Icons.lock_outline_rounded,
                          title: 'Account Settings',
                          highlight: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const OfficialAccountSettingsPage(),
                            ),
                          ),
                        ),
                        _settingsRow(
                          icon: Icons.share_outlined,
                          title: 'Share the App',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OfficialSharePage(),
                            ),
                          ),
                        ),
                        _settingsRow(
                          icon: Icons.logout_rounded,
                          title: 'Log Out',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OfficialLogoutPage(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Opacity(
                          opacity: 0.55,
                          child: TextButton.icon(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const OfficialBugReportPage(),
                              ),
                            ),
                            icon: const Icon(
                              Icons.bug_report_outlined,
                              size: 18,
                            ),
                            label: const Text('Report a Bug'),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF636A80),
                            ),
                          ),
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
    );
  }
}

class _RbiPerson {
  final String name;
  final String idNo;
  final int age;
  final String gender;
  final bool verified;

  const _RbiPerson({
    required this.name,
    required this.idNo,
    required this.age,
    required this.gender,
    required this.verified,
  });
}

class OfficialRbiRecordsPage extends StatefulWidget {
  const OfficialRbiRecordsPage({super.key});

  @override
  State<OfficialRbiRecordsPage> createState() => _OfficialRbiRecordsPageState();
}

class _OfficialRbiRecordsPageState extends State<OfficialRbiRecordsPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedTab = 'All';

  static const List<_RbiPerson> _records = [
    _RbiPerson(
      name: 'AVSV, CSAC',
      idNo: 'RBI-3-6-10-7727524',
      age: 37,
      gender: 'Male',
      verified: false,
    ),
    _RbiPerson(
      name: 'HUSSEY, LOIDA',
      idNo: 'RBI-3-7-34-7891945',
      age: 42,
      gender: 'Female',
      verified: true,
    ),
    _RbiPerson(
      name: 'ELANE, ANGELO GREGG',
      idNo: 'RBI-3-7-34-8921104',
      age: 28,
      gender: 'Male',
      verified: false,
    ),
    _RbiPerson(
      name: 'NADONG, LESTER',
      idNo: 'RBI-3-7-34-11761459',
      age: 39,
      gender: 'Male',
      verified: true,
    ),
  ];

  List<_RbiPerson> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    return _records.where((person) {
      final matchedTab =
          _selectedTab == 'All' ||
          (_selectedTab == 'Verified' && person.verified) ||
          (_selectedTab == 'Unverified' && !person.verified);
      final matchedText =
          q.isEmpty ||
          person.name.toLowerCase().contains(q) ||
          person.idNo.toLowerCase().contains(q);
      return matchedTab && matchedText;
    }).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Widget _chip(String label) {
    final selected = _selectedTab == label;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xFF4D556F),
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      selected: selected,
      onSelected: (_) => setState(() => _selectedTab = label),
      selectedColor: const Color(0xFFCD1212),
      backgroundColor: const Color(0xFFF0F2F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      side: BorderSide(
        color: selected ? const Color(0xFFCD1212) : Colors.transparent,
      ),
      showCheckmark: false,
    );
  }

  Widget _avatar(_RbiPerson person) {
    final initials = person.name
        .split(',')
        .first
        .trim()
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0])
        .join();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: person.verified
              ? const Color(0xFFE8F8EF)
              : const Color(0xFFF7F0E8),
          child: Text(
            initials,
            style: TextStyle(
              color: person.verified
                  ? const Color(0xFF1A8F50)
                  : const Color(0xFFB9771D),
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: person.verified
                  ? const Color(0xFF19C261)
                  : const Color(0xFFE29423),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.check, size: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _recordCard(_RbiPerson person) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _OfficialRbiProfilePage(person: person),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE4E7F1)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _avatar(person),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _officialText,
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'ID No ${person.idNo}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _officialSubtext,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Age ${person.age}',
                    style: const TextStyle(
                      color: _officialSubtext,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Gender ${person.gender}',
                    style: const TextStyle(
                      color: _officialSubtext,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF767E97),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shown = _filtered;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('RBI Records'),
        backgroundColor: _officialHeaderStart,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search name...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          Row(
            children: [
              _chip('All'),
              const SizedBox(width: 8),
              _chip('Verified'),
              const SizedBox(width: 8),
              _chip('Unverified'),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Recent Searches',
            style: TextStyle(
              color: _officialSubtext,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          if (shown.isEmpty)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _officialCardBorder),
              ),
              child: const Text(
                'No records found for this search.',
                style: TextStyle(
                  color: _officialSubtext,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            ...shown.map(_recordCard),
        ],
      ),
    );
  }
}

class _OfficialRbiProfilePage extends StatelessWidget {
  final _RbiPerson person;
  const _OfficialRbiProfilePage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Resident RBI Profile'),
        backgroundColor: _officialHeaderStart,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _officialCardBorder),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: person.verified
                      ? const Color(0xFFE8F8EF)
                      : const Color(0xFFF7F0E8),
                  child: Text(
                    person.name.trim().isEmpty
                        ? '?'
                        : person.name.trim().substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: person.verified
                          ? const Color(0xFF1A8F50)
                          : const Color(0xFFB9771D),
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.name,
                        style: const TextStyle(
                          color: _officialText,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        person.idNo,
                        style: const TextStyle(
                          color: _officialSubtext,
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
          _officialDataCard([
            ('Age', '${person.age}'),
            ('Gender', person.gender),
            ('Status', person.verified ? 'Verified' : 'Unverified'),
            ('Last Updated', 'February 22, 2026'),
          ]),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _showFeature(
                    context,
                    person.verified
                        ? 'Marked as unverified'
                        : 'Marked as verified',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: _officialHeaderStart,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: Icon(
                    person.verified
                        ? Icons.rule_folder_outlined
                        : Icons.verified_user_outlined,
                  ),
                  label: Text(
                    person.verified ? 'Mark Unverified' : 'Verify Record',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      _showFeature(context, 'RBI profile export prepared'),
                  icon: const Icon(Icons.print_outlined),
                  label: const Text('Print Record'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OfficialProfileSettingsPage extends StatefulWidget {
  const OfficialProfileSettingsPage({super.key});

  @override
  State<OfficialProfileSettingsPage> createState() =>
      _OfficialProfileSettingsPageState();
}

class _OfficialProfileSettingsPageState
    extends State<OfficialProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController(text: 'Lester Nadong');
  final _mobile = TextEditingController(text: '0917-223-4545');
  final _email = TextEditingController(text: 'lester@barangaymo.online');

  @override
  void dispose() {
    _fullName.dispose();
    _mobile.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Profile Settings'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _officialCardBorder),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _fullName,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _mobile,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                    ),
                    validator: (v) =>
                        (v == null || v.trim().length < 10) ? 'Invalid' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) => (v == null || !v.contains('@'))
                        ? 'Invalid email'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showFeature(context, 'Profile settings saved');
                          Navigator.pop(context);
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: _officialHeaderStart,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save Changes'),
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

class OfficialAccountSettingsPage extends StatefulWidget {
  const OfficialAccountSettingsPage({super.key});

  @override
  State<OfficialAccountSettingsPage> createState() =>
      _OfficialAccountSettingsPageState();
}

class _OfficialAccountSettingsPageState
    extends State<OfficialAccountSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _officialCardBorder),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _current,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Current Password',
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _next,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                    validator: (v) =>
                        (v == null || v.length < 8) ? 'Min 8 characters' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confirm,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                    ),
                    validator: (v) =>
                        (v != _next.text) ? 'Passwords do not match' : null,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showFeature(context, 'Account settings updated');
                          Navigator.pop(context);
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: _officialHeaderStart,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Update Account'),
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

class OfficialFaqsPage extends StatefulWidget {
  const OfficialFaqsPage({super.key});

  @override
  State<OfficialFaqsPage> createState() => _OfficialFaqsPageState();
}

class _OfficialFaqsPageState extends State<OfficialFaqsPage> {
  final _search = TextEditingController();
  final Set<int> _open = <int>{0};
  final List<(String, String)> _items = const [
    (
      'How do I request barangay clearance?',
      'Open Services > Clearance, fill in your purpose, then submit and track from Documents.',
    ),
    (
      'How long is normal processing?',
      'Most documents are processed in 1 to 3 business days depending on verification.',
    ),
    (
      'How can I verify my RBI profile?',
      'Go to Profile > Verify then upload the required information and valid ID.',
    ),
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _search.text.toLowerCase().trim();
    final shown = _items
        .asMap()
        .entries
        .where(
          (e) =>
              q.isEmpty ||
              e.value.$1.toLowerCase().contains(q) ||
              e.value.$2.toLowerCase().contains(q),
        )
        .toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          TextField(
            controller: _search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search by keywords',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...shown.map((entry) {
            final idx = entry.key;
            final opened = _open.contains(idx);
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _officialCardBorder),
              ),
              child: ExpansionTile(
                title: Text(
                  entry.value.$1,
                  style: const TextStyle(
                    color: _officialText,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                initiallyExpanded: opened,
                onExpansionChanged: (v) {
                  setState(() {
                    if (v) {
                      _open.add(idx);
                    } else {
                      _open.remove(idx);
                    }
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    child: Text(
                      entry.value.$2,
                      style: const TextStyle(
                        color: _officialSubtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class OfficialNotificationsPage extends StatefulWidget {
  const OfficialNotificationsPage({super.key});

  @override
  State<OfficialNotificationsPage> createState() =>
      _OfficialNotificationsPageState();
}

class _OfficialNotificationsPageState extends State<OfficialNotificationsPage> {
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Barangay Clearance ready for pickup',
      'time': '5 min ago',
      'read': false,
    },
    {
      'title': 'Council meeting schedule updated',
      'time': '2 hours ago',
      'read': true,
    },
    {
      'title': 'New RBI verification request',
      'time': 'Yesterday',
      'read': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final item = _items[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: item['read'] as bool
                    ? _officialCardBorder
                    : const Color(0xFFFFD0D0),
              ),
            ),
            child: ListTile(
              leading: Icon(
                item['read'] as bool
                    ? Icons.notifications_none_outlined
                    : Icons.notifications_active_rounded,
                color: item['read'] as bool
                    ? const Color(0xFF6D738B)
                    : _officialHeaderStart,
              ),
              title: Text(
                item['title'] as String,
                style: const TextStyle(
                  color: _officialText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                item['time'] as String,
                style: const TextStyle(color: _officialSubtext),
              ),
              trailing: TextButton(
                onPressed: () =>
                    setState(() => item['read'] = !(item['read'] as bool)),
                child: Text((item['read'] as bool) ? 'Unread' : 'Read'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OfficialSupportPage extends StatelessWidget {
  const OfficialSupportPage({super.key});

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _officialCardBorder),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2EF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _officialHeaderStart),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: _officialText,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: _officialSubtext),
        ),
        trailing: TextButton(
          onPressed: () => _showFeature(context, actionText),
          child: const Text('Open'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          _tile(
            context,
            icon: Icons.email_outlined,
            title: 'support@barangaymo.online',
            subtitle: 'Email Support',
            actionText: 'Opening email support',
          ),
          _tile(
            context,
            icon: Icons.call_outlined,
            title: '000 123 4567',
            subtitle: 'Hotline',
            actionText: 'Dialing support hotline',
          ),
          _tile(
            context,
            icon: Icons.quiz_outlined,
            title: 'FAQ Button',
            subtitle: 'Help center articles',
            actionText: 'Opening FAQ module',
          ),
        ],
      ),
    );
  }
}

class OfficialSharePage extends StatelessWidget {
  const OfficialSharePage({super.key});

  static const _shareMessage =
      'Download BarangayMo to access barangay services, requests, and '
      'community updates in one app.';
  static const _androidLink =
      'https://play.google.com/store/apps/details?id=ph.barangaymo.official';
  static const _iosLink = 'https://apps.apple.com/ph/app/barangaymo-official';

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
            Icon(icon, color: _officialHeaderStart),
            const SizedBox(width: 9),
            Text(
              label,
              style: const TextStyle(
                color: _officialText,
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
        foregroundColor: _officialHeaderStart,
        side: const BorderSide(color: Color(0xFFF2CACA)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        backgroundColor: _officialHeaderStart,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFBF5F5), Color(0xFFF8F2F2)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              children: [
                const Text(
                  'BarangayMo Officials',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: _officialText,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Help your staff and partner offices coordinate requests and service updates through BarangayMo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _officialSubtext,
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
                      border: Border.all(color: const Color(0xFFF1D7D7)),
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
                    border: Border.all(color: const Color(0xFFF1DCDC)),
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
                          color: _officialHeaderStart,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _shareOptionTile(
                        context: context,
                        icon: Icons.email_outlined,
                        label: 'SHARE VIA EMAIL',
                        actionText: 'Preparing official email share...',
                      ),
                      _shareOptionTile(
                        context: context,
                        icon: Icons.facebook,
                        label: 'SHARE VIA FACEBOOK',
                        actionText: 'Preparing official Facebook share...',
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3F3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFF2DADA)),
                        ),
                        child: const Text(
                          _shareMessage,
                          style: TextStyle(
                            color: Color(0xFF5C556E),
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
                    border: Border.all(color: const Color(0xFFF1DCDC)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'App Store Links',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: _officialHeaderStart,
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

class OfficialBugReportPage extends StatefulWidget {
  const OfficialBugReportPage({super.key});

  @override
  State<OfficialBugReportPage> createState() => _OfficialBugReportPageState();
}

class _OfficialBugReportPageState extends State<OfficialBugReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _bugName = TextEditingController();
  final _description = TextEditingController();
  String _severity = 'Medium';
  bool _attachmentAdded = false;

  @override
  void dispose() {
    _bugName.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Bug Report'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _officialCardBorder),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _bugName,
                    decoration: const InputDecoration(labelText: 'Bug Name'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _description,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (v) => (v == null || v.trim().length < 10)
                        ? 'At least 10 characters'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: _severity,
                    decoration: const InputDecoration(labelText: 'Severity'),
                    items: const [
                      DropdownMenuItem(value: 'Low', child: Text('Low')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'High', child: Text('High')),
                    ],
                    onChanged: (v) => setState(() => _severity = v ?? 'Medium'),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFFE6E8F2)),
                    ),
                    leading: Icon(
                      _attachmentAdded
                          ? Icons.check_circle_rounded
                          : Icons.upload_file_outlined,
                      color: _attachmentAdded
                          ? const Color(0xFF18A55D)
                          : _officialHeaderStart,
                    ),
                    title: Text(
                      _attachmentAdded
                          ? 'Screenshot attached'
                          : 'Upload Screenshot',
                    ),
                    trailing: TextButton(
                      onPressed: () =>
                          setState(() => _attachmentAdded = !_attachmentAdded),
                      child: Text(_attachmentAdded ? 'Remove' : 'Attach'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showFeature(
                            context,
                            'Ticket submitted (${DateTime.now().millisecondsSinceEpoch % 100000})',
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: _officialHeaderStart,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit Ticket'),
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

class OfficialTermsPoliciesPage extends StatelessWidget {
  const OfficialTermsPoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Terms & Policies'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          _policyTile(
            context,
            title: 'Privacy Policy',
            body:
                'BarangayMo collects only the personal data required for service delivery, verification, and records management. All sensitive data is protected and used in compliance with local policies.',
          ),
          _policyTile(
            context,
            title: 'Terms and Conditions',
            body:
                'By using BarangayMo, users agree to provide truthful information and comply with barangay process requirements. False declarations may result in request rejection and account restrictions.',
          ),
        ],
      ),
    );
  }

  Widget _policyTile(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _officialCardBorder),
      ),
      child: ListTile(
        leading: const Icon(Icons.policy_outlined, color: _officialHeaderStart),
        title: Text(
          title,
          style: const TextStyle(
            color: _officialText,
            fontWeight: FontWeight.w800,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                OfficialPolicyDocumentPage(title: title, body: body),
          ),
        ),
      ),
    );
  }
}

class OfficialPolicyDocumentPage extends StatelessWidget {
  final String title;
  final String body;
  const OfficialPolicyDocumentPage({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          body,
          style: const TextStyle(
            color: _officialText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.45,
          ),
        ),
      ),
    );
  }
}

class OfficialLogoutPage extends StatelessWidget {
  const OfficialLogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Log out'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _officialDataCard([
              ('Session', 'Barangay Official'),
              ('Status', 'Active'),
            ]),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFEDEFF6),
                  foregroundColor: _officialText,
                ),
                child: const Text('Go Back'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const RoleGatewayScreen()),
                  (_) => false,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: _officialHeaderStart,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfficialDeleteAccountPage extends StatefulWidget {
  const OfficialDeleteAccountPage({super.key});

  @override
  State<OfficialDeleteAccountPage> createState() =>
      _OfficialDeleteAccountPageState();
}

class _OfficialDeleteAccountPageState extends State<OfficialDeleteAccountPage> {
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canDelete = _confirm.text.trim().toUpperCase() == 'DELETE';
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Delete Account'),
        backgroundColor: const Color(0xFFF4F5F9),
        foregroundColor: _officialText,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFFFD6D6)),
            ),
            child: const Text(
              'Type DELETE to confirm account deletion. This action cannot be undone.',
              style: TextStyle(
                color: Color(0xFF7A4A4A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _confirm,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Confirmation',
              hintText: 'DELETE',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: canDelete
                  ? () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RoleGatewayScreen(),
                      ),
                      (_) => false,
                    )
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFB91818),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete Account'),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _officialDataCard(List<(String, String)> rows) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _officialCardBorder),
    ),
    child: Column(
      children: rows
          .map(
            (row) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFECEEF5))),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 118,
                    child: Text(
                      row.$1,
                      style: const TextStyle(
                        color: _officialSubtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.$2,
                      style: const TextStyle(
                        color: _officialText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    ),
  );
}

class _CouncilMember {
  String name;
  String role;
  _CouncilMember({required this.name, required this.role});
}

class OfficialBarangayProfilePage extends StatefulWidget {
  const OfficialBarangayProfilePage({super.key});

  @override
  State<OfficialBarangayProfilePage> createState() =>
      _OfficialBarangayProfilePageState();
}

class _OfficialBarangayProfilePageState
    extends State<OfficialBarangayProfilePage> {
  static const _mapCenter = LatLng(14.8396, 120.2818);
  String _addressBarangay = 'WEST TAPINAC';
  String _addressCity = 'CITY OF OLONGAPO';
  String _addressProvince = 'ZAMBALES';
  String _addressRegion = 'REGION 3';

  final List<_CouncilMember> _councilMembers = [
    _CouncilMember(name: 'DONALD ELAD AQUINO', role: 'Punong Barangay'),
    _CouncilMember(
      name: 'LARRY DELA ROSA TOLEDO',
      role: 'Sangguniang Barangay Member',
    ),
    _CouncilMember(
      name: 'RIGOR BILONO AVILANES',
      role: 'Sangguniang Barangay Member',
    ),
    _CouncilMember(
      name: 'ROBERTO TOGONON ANTONIO',
      role: 'Sangguniang Barangay Member',
    ),
    _CouncilMember(
      name: 'WILFREDO FABABI MIRANDA',
      role: 'Sangguniang Barangay Member',
    ),
  ];

  Future<void> _editAddressDetails() async {
    final barangay = TextEditingController(text: _addressBarangay);
    final city = TextEditingController(text: _addressCity);
    final province = TextEditingController(text: _addressProvince);
    final region = TextEditingController(text: _addressRegion);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Address Details',
                style: TextStyle(
                  color: _officialText,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: barangay,
                decoration: const InputDecoration(labelText: 'Barangay'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: city,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: province,
                decoration: const InputDecoration(labelText: 'Province'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: region,
                decoration: const InputDecoration(labelText: 'Region'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (barangay.text.trim().isEmpty ||
                        city.text.trim().isEmpty ||
                        province.text.trim().isEmpty ||
                        region.text.trim().isEmpty) {
                      _showFeature(ctx, 'Please complete all address fields');
                      return;
                    }
                    setState(() {
                      _addressBarangay = barangay.text.trim().toUpperCase();
                      _addressCity = city.text.trim().toUpperCase();
                      _addressProvince = province.text.trim().toUpperCase();
                      _addressRegion = region.text.trim().toUpperCase();
                    });
                    Navigator.pop(ctx);
                    _showFeature(context, 'Address details updated');
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: _officialHeaderStart,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Address'),
                ),
              ),
            ],
          ),
        );
      },
    );
    barangay.dispose();
    city.dispose();
    province.dispose();
    region.dispose();
  }

  Future<void> _editCouncilMember({int? index}) async {
    final isEdit = index != null;
    final name = TextEditingController(
      text: isEdit ? _councilMembers[index].name : '',
    );
    final role = TextEditingController(
      text: isEdit ? _councilMembers[index].role : '',
    );

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Council Member' : 'Add Council Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: role,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (name.text.trim().isEmpty || role.text.trim().isEmpty) {
                  _showFeature(ctx, 'Please complete name and role');
                  return;
                }
                setState(() {
                  if (isEdit) {
                    _councilMembers[index].name = name.text
                        .trim()
                        .toUpperCase();
                    _councilMembers[index].role = role.text.trim();
                  } else {
                    _councilMembers.add(
                      _CouncilMember(
                        name: name.text.trim().toUpperCase(),
                        role: role.text.trim(),
                      ),
                    );
                  }
                });
                Navigator.pop(ctx);
                _showFeature(
                  context,
                  isEdit ? 'Council member updated' : 'Council member added',
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: _officialHeaderStart,
                foregroundColor: Colors.white,
              ),
              child: Text(isEdit ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
    name.dispose();
    role.dispose();
  }

  Widget _contentCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _officialCardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: _officialText,
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _metricCard({
    required IconData icon,
    required String title,
    required String value,
    required String note,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8EBF5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: const Color(0xFF7A8199)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF5F667E),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: _officialText,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          Text(
            note,
            style: const TextStyle(
              color: _officialSubtext,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE9ECF5))),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2EF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _officialHeaderStart, size: 20),
        ),
        title: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: _officialText,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          label,
          style: const TextStyle(
            color: _officialSubtext,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _profileDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool last = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFE9ECF5))),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F7FC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF6C728B), size: 20),
        ),
        title: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: _officialText,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          label,
          style: const TextStyle(
            color: _officialSubtext,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _detailsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
      children: [
        _sectionTitle('Barangay Details'),
        const SizedBox(height: 10),
        _contentCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile Details',
                style: TextStyle(
                  color: _officialText,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              _profileDetailRow(
                icon: Icons.email_outlined,
                value: 'westtapinac@olongapo.gov.ph',
                label: 'Email',
              ),
              _profileDetailRow(
                icon: Icons.language_rounded,
                value: 'www.westtapinac-olongapo.gov.ph',
                label: 'Website',
              ),
              _profileDetailRow(
                icon: Icons.facebook_rounded,
                value: 'facebook.com/westtapinacofficial',
                label: 'Facebook',
              ),
              _profileDetailRow(
                icon: Icons.gps_fixed_rounded,
                value: '14.8396, 120.2818',
                label: 'Coordinates',
              ),
              _profileDetailRow(
                icon: Icons.square_foot_rounded,
                value: '2.40 km²',
                label: 'Land Area',
              ),
              _profileDetailRow(
                icon: Icons.groups_2_outlined,
                value: '22,365 residents',
                label: 'Population',
                last: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _contentCard(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _metricCard(
                      icon: Icons.groups_outlined,
                      title: 'Population',
                      value: '22,365',
                      note: 'PSA 2025',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _metricCard(
                      icon: Icons.badge_outlined,
                      title: 'RBI',
                      value: '5,420',
                      note: 'Active records',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _metricCard(
                      icon: Icons.hub_outlined,
                      title: 'Divisions',
                      value: '10',
                      note: 'Zones',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _metricCard(
                      icon: Icons.history_edu_outlined,
                      title: 'Founded',
                      value: '1961',
                      note: '64 years',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _infoTile(
                icon: Icons.phone_android,
                value: '0917-223-4545',
                label: 'Mobile Number',
              ),
              _infoTile(
                icon: Icons.call_outlined,
                value: '047-223-3434',
                label: 'Landline',
              ),
              _infoTile(
                icon: Icons.calendar_today_outlined,
                value: 'August 8',
                label: 'Foundation Day',
              ),
              _infoTile(
                icon: Icons.account_balance_wallet_outlined,
                value: 'PHP 12.4M Annual Budget',
                label: 'CY 2026 Allocation',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _contentCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Emergency Contacts',
                style: TextStyle(
                  color: _officialText,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              _infoTile(
                icon: Icons.local_fire_department_outlined,
                value: '166',
                label: 'Fire Department',
              ),
              _infoTile(
                icon: Icons.shield_outlined,
                value: '0917-111-2287',
                label: 'BPAT',
              ),
              _infoTile(
                icon: Icons.local_police_outlined,
                value: '117',
                label: 'Police',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addressRow({
    required IconData icon,
    required String value,
    required String label,
    bool last = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFE9ECF5))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6B728A), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _officialText,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: _officialSubtext,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
      children: [
        _sectionTitle('Barangay Address'),
        const SizedBox(height: 10),
        _contentCard(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
          child: Column(
            children: [
              SizedBox(
                height: 215,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: _mapCenter,
                      initialZoom: 14.9,
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
                            point: _mapCenter,
                            width: 42,
                            height: 42,
                            child: Icon(
                              Icons.location_on,
                              color: _officialHeaderStart,
                              size: 34,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _officialCardBorder),
                  color: const Color(0xFFFCFCFF),
                ),
                child: Column(
                  children: [
                    _addressRow(
                      icon: Icons.location_city_outlined,
                      value: _addressBarangay,
                      label: 'Barangay',
                    ),
                    _addressRow(
                      icon: Icons.place_outlined,
                      value: _addressCity,
                      label: 'Municipality / City',
                    ),
                    _addressRow(
                      icon: Icons.map_outlined,
                      value: _addressProvince,
                      label: 'Province',
                    ),
                    _addressRow(
                      icon: Icons.fullscreen_outlined,
                      value: _addressRegion,
                      label: 'Region',
                      last: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _editAddressDetails,
                  style: FilledButton.styleFrom(
                    backgroundColor: _officialHeaderStart,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Update Address Details',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _councilMemberCard(
    BuildContext context, {
    required int index,
    required String name,
    required String role,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _officialCardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
        leading: const CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFF2F4F9),
          child: Icon(Icons.person, color: Color(0xFF9AA0B3), size: 24),
        ),
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: _officialText,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          role,
          style: const TextStyle(
            color: _officialSubtext,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        trailing: IconButton(
          onPressed: () => _editCouncilMember(index: index),
          icon: const Icon(Icons.edit_outlined, size: 18),
          color: const Color(0xFF696F85),
        ),
      ),
    );
  }

  Widget _councilTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
      children: [
        _sectionTitle('Barangay Council'),
        const SizedBox(height: 10),
        _contentCard(
          child: Column(
            children: [
              ..._councilMembers.asMap().entries.map(
                (entry) => _councilMemberCard(
                  context,
                  index: entry.key,
                  name: entry.value.name,
                  role: entry.value.role,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _editCouncilMember(),
                  style: FilledButton.styleFrom(
                    backgroundColor: _officialHeaderStart,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.group_add_outlined, size: 18),
                  label: const Text(
                    'Manage Council',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Barangay Profile'),
          backgroundColor: _officialHeaderStart,
          foregroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_officialHeaderStart, _officialHeaderEnd],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF7F8FC), Color(0xFFF3ECEC)],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 14),
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7F3), width: 2),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'public/barangaymo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'West Tapinac',
                style: TextStyle(
                  color: _officialText,
                  fontSize: 31,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'CITY OF OLONGAPO ZAMBALES',
                style: TextStyle(
                  color: _officialSubtext,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 10),
              const TabBar(
                labelColor: _officialText,
                unselectedLabelColor: Color(0xFF7B8098),
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
                tabs: [
                  Tab(text: 'Details'),
                  Tab(text: 'Address'),
                  Tab(text: 'Council'),
                ],
              ),
              const SizedBox(height: 6),
              Expanded(
                child: TabBarView(
                  children: [
                    _detailsTab(context),
                    _addressTab(context),
                    _councilTab(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SerbilisServicesPage extends StatelessWidget {
  const SerbilisServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Serbilis Services'),
          backgroundColor: _officialHeaderStart,
          foregroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_officialHeaderStart, _officialHeaderEnd],
              ),
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFFFFD8D8),
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.w800),
            tabs: [
              Tab(text: 'Brgy Services'),
              Tab(text: 'SK Services'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF7F8FC), Color(0xFFF3ECEC)],
            ),
          ),
          child: TabBarView(
            children: [
              _serviceGrid(context, _brgyServices),
              _serviceGrid(context, _skServices),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceGrid(BuildContext context, List<_ServiceAction> data) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_officialHeaderStart, _officialHeaderEnd],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 12,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0x33FFFFFF),
                child: Icon(
                  Icons.miscellaneous_services_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Official Service Console',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Run barangay workflows and track resident-facing service modules.',
                      style: TextStyle(
                        color: Color(0xFFFFE5E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth < 360 ? 2 : 3;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.92,
              ),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item.page),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _officialCardBorder),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x12000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEFEA),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Icon(
                            item.icon,
                            size: 24,
                            color: _officialHeaderStart,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: _officialText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _ServiceAction {
  final String name;
  final IconData icon;
  final Widget page;
  const _ServiceAction(this.name, this.icon, this.page);
}

const _brgyServices = [
  _ServiceAction('Assistance', Icons.volunteer_activism, AssistancePage()),
  _ServiceAction('BPAT', Icons.shield, BpatPage()),
  _ServiceAction('Clearance', Icons.description, ClearancePage()),
  _ServiceAction('Council', Icons.groups, CouncilPage()),
  _ServiceAction('Disclosure', Icons.table_chart, DisclosureBoardPage()),
  _ServiceAction(
    'Education',
    Icons.menu_book,
    SimpleSerbilisPage(title: 'Education', isOfficial: true),
  ),
  _ServiceAction('Provincial Gov', Icons.account_balance, GovAgenciesPage()),
  _ServiceAction('Health', Icons.health_and_safety, HealthPage()),
  _ServiceAction(
    'Other Barangay',
    Icons.travel_explore,
    SimpleSerbilisPage(title: 'Other Barangay', isOfficial: true),
  ),
  _ServiceAction(
    'Police',
    Icons.local_police,
    SimpleSerbilisPage(title: 'Police', isOfficial: true),
  ),
  _ServiceAction('QR ID', Icons.qr_code_scanner, ScanQrPage()),
  _ServiceAction('RBI', Icons.badge, ResidentRbiCardPage()),
  _ServiceAction('Responder', Icons.local_shipping, ResponderPage()),
  _ServiceAction(
    'Special Docs',
    Icons.stars,
    SimpleSerbilisPage(title: 'Special Docs', isOfficial: true),
  ),
  _ServiceAction('Community', Icons.forum, CommunityPage()),
];

const _skServices = [
  _ServiceAction('Community', Icons.hub, CommunityPage()),
  _ServiceAction(
    'Education',
    Icons.school,
    SimpleSerbilisPage(title: 'SK Education', isOfficial: true),
  ),
  _ServiceAction('Officials', Icons.groups_2, CouncilPage()),
  _ServiceAction(
    'Programs',
    Icons.assignment,
    SimpleSerbilisPage(title: 'Programs', isOfficial: true),
  ),
  _ServiceAction('Scholarship', Icons.card_giftcard, AssistancePage()),
  _ServiceAction(
    'Sports',
    Icons.sports_basketball,
    SimpleSerbilisPage(title: 'Sports', isOfficial: true),
  ),
];

class SimpleSerbilisPage extends StatelessWidget {
  final String title;
  final bool isOfficial;
  const SimpleSerbilisPage({
    super.key,
    required this.title,
    this.isOfficial = false,
  });

  void _openModule(
    BuildContext context,
    _SerbilisPortalItem item,
    Color heroStart,
    Color heroEnd,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _SerbilisModuleScreen(
          portalTitle: title,
          item: item,
          heroStart: heroStart,
          heroEnd: heroEnd,
          isOfficial: isOfficial,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cfg = _SerbilisPortalData.fromTitle(title);
    const residentAppBarBg = Color(0xFFF5F7FF);
    const residentFg = Color(0xFF2B3353);
    const residentBgStart = Color(0xFFF5F7FF);
    const residentBgEnd = Color(0xFFF0F3FF);
    const residentHeroStart = Color(0xFF3E4CC7);
    const residentHeroEnd = Color(0xFF6775E6);
    final appBarBg = isOfficial ? const Color(0xFFF7F8FC) : residentAppBarBg;
    final fg = isOfficial ? const Color(0xFF2F3248) : residentFg;
    final bgStart = isOfficial ? const Color(0xFFF7F8FC) : residentBgStart;
    final bgEnd = isOfficial ? const Color(0xFFF3ECEC) : residentBgEnd;
    final heroStart = isOfficial ? _officialHeaderStart : residentHeroStart;
    final heroEnd = isOfficial ? _officialHeaderEnd : residentHeroEnd;
    final heroSubtext = isOfficial
        ? const Color(0xFFFFD8D8)
        : const Color(0xFFDDE3FF);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: appBarBg,
        foregroundColor: fg,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgStart, bgEnd],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [heroStart, heroEnd],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x30FFFFFF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            isOfficial
                                ? 'Official Workflow'
                                : 'Resident Self-Service',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          cfg.headline,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          cfg.description,
                          style: TextStyle(
                            color: heroSubtext,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: const Color(0x34FFFFFF),
                    child: Icon(cfg.icon, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...cfg.modules.map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E8F2)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item.bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: heroStart),
                  ),
                  title: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3248),
                    ),
                  ),
                  subtitle: Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF676D86),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF636A85),
                  ),
                  onTap: () =>
                      _openModule(context, item, heroStart, heroEnd),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SerbilisPortalData {
  final String headline;
  final String description;
  final Color heroStart;
  final Color heroEnd;
  final IconData icon;
  final List<_SerbilisPortalItem> modules;

  const _SerbilisPortalData({
    required this.headline,
    required this.description,
    required this.heroStart,
    required this.heroEnd,
    required this.icon,
    required this.modules,
  });

  static _SerbilisPortalData fromTitle(String title) {
    switch (title) {
      case 'Education':
      case 'SK Education':
        return const _SerbilisPortalData(
          headline: 'Barangay Education Hub',
          description:
              'Scholarships, training, and learning support for residents and youth.',
          heroStart: Color(0xFF4759C8),
          heroEnd: Color(0xFF6D7CE7),
          icon: Icons.menu_book,
          modules: [
            _SerbilisPortalItem(
              title: 'Scholarship Registry',
              subtitle: 'Apply and track scholarship assistance',
              icon: Icons.school,
              bg: Color(0xFFE3E9FF),
            ),
            _SerbilisPortalItem(
              title: 'TESDA Referral',
              subtitle: 'Skills training and employment readiness',
              icon: Icons.engineering,
              bg: Color(0xFFE8F2FF),
            ),
            _SerbilisPortalItem(
              title: 'ALS Enrollment',
              subtitle: 'Alternative learning support schedules',
              icon: Icons.groups,
              bg: Color(0xFFEAF5E8),
            ),
            _SerbilisPortalItem(
              title: 'Youth Programs',
              subtitle: 'Workshops, mentoring, and campus outreach',
              icon: Icons.workspace_premium,
              bg: Color(0xFFFFEFE1),
            ),
          ],
        );
      case 'Police':
        return const _SerbilisPortalData(
          headline: 'Police Coordination',
          description:
              'Incident reporting, blotter tracking, and safety coordination with PNP.',
          heroStart: Color(0xFF274F93),
          heroEnd: Color(0xFF4D72B3),
          icon: Icons.local_police,
          modules: [
            _SerbilisPortalItem(
              title: 'Report Incident',
              subtitle: 'Submit details for police and barangay response',
              icon: Icons.report_problem,
              bg: Color(0xFFE4ECFF),
            ),
            _SerbilisPortalItem(
              title: 'Blotter Verification',
              subtitle: 'Check report status and case reference',
              icon: Icons.receipt_long,
              bg: Color(0xFFE9F0FF),
            ),
            _SerbilisPortalItem(
              title: 'Patrol Request',
              subtitle: 'Request presence in high-risk areas',
              icon: Icons.directions_walk,
              bg: Color(0xFFEAF6EF),
            ),
            _SerbilisPortalItem(
              title: 'Emergency Contacts',
              subtitle: 'Quick access to hotline and precinct channels',
              icon: Icons.call,
              bg: Color(0xFFFFEFE4),
            ),
          ],
        );
      case 'Other Barangay':
        return const _SerbilisPortalData(
          headline: 'Inter-Barangay Services',
          description:
              'Coordinate requests and verification across neighboring barangays.',
          heroStart: Color(0xFF8E4E44),
          heroEnd: Color(0xFFB46B5A),
          icon: Icons.travel_explore,
          modules: [
            _SerbilisPortalItem(
              title: 'Transfer Request',
              subtitle: 'Start resident transfer and endorsement documents',
              icon: Icons.swap_horiz,
              bg: Color(0xFFFFE9E4),
            ),
            _SerbilisPortalItem(
              title: 'Cross-Barangay Clearance',
              subtitle: 'Coordinate clearance with destination barangay',
              icon: Icons.assignment_turned_in,
              bg: Color(0xFFFFEFE6),
            ),
            _SerbilisPortalItem(
              title: 'Referral Letter',
              subtitle: 'Generate referral for health and social support',
              icon: Icons.mail_outline,
              bg: Color(0xFFEAF0FF),
            ),
            _SerbilisPortalItem(
              title: 'Barangay Directory',
              subtitle: 'Contacts and office hours of nearby barangays',
              icon: Icons.location_city,
              bg: Color(0xFFEAF6EF),
            ),
          ],
        );
      default:
        return _SerbilisPortalData(
          headline: '$title Services',
          description: 'Access community services and support requests.',
          heroStart: const Color(0xFF3E4CC7),
          heroEnd: const Color(0xFF6978E1),
          icon: Icons.miscellaneous_services,
          modules: [
            const _SerbilisPortalItem(
              title: 'Open Services',
              subtitle: 'Access service request forms',
              icon: Icons.open_in_new,
              bg: Color(0xFFE4E9FF),
            ),
            const _SerbilisPortalItem(
              title: 'Status Tracking',
              subtitle: 'Monitor progress and updates',
              icon: Icons.timeline,
              bg: Color(0xFFE9F5EE),
            ),
          ],
        );
    }
  }
}

class _SerbilisPortalItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color bg;

  const _SerbilisPortalItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bg,
  });
}

class _SerbilisModuleScreen extends StatefulWidget {
  final String portalTitle;
  final _SerbilisPortalItem item;
  final Color heroStart;
  final Color heroEnd;
  final bool isOfficial;

  const _SerbilisModuleScreen({
    required this.portalTitle,
    required this.item,
    required this.heroStart,
    required this.heroEnd,
    required this.isOfficial,
  });

  @override
  State<_SerbilisModuleScreen> createState() => _SerbilisModuleScreenState();
}

class _SerbilisModuleScreenState extends State<_SerbilisModuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _requesterController = TextEditingController();
  final _mobileController = TextEditingController();
  final _detailsController = TextEditingController();
  String _priority = 'Normal';
  bool _submitting = false;
  String? _reference;
  DateTime? _submittedAt;

  @override
  void dispose() {
    _requesterController.dispose();
    _mobileController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  String _formatStamp(DateTime value) {
    final hh = value.hour.toString().padLeft(2, '0');
    final mm = value.minute.toString().padLeft(2, '0');
    return '${value.month}/${value.day}/${value.year} $hh:$mm';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final now = DateTime.now();
    setState(() {
      _submitting = false;
      _submittedAt = now;
      _reference = 'SRV-${now.millisecondsSinceEpoch % 1000000}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasSubmission = _reference != null && _submittedAt != null;
    final appBarBg = widget.isOfficial
        ? const Color(0xFFF7F8FC)
        : const Color(0xFFF5F7FF);
    final fg = widget.isOfficial
        ? const Color(0xFF2F3248)
        : const Color(0xFF2B3353);
    final bgStart = widget.isOfficial
        ? const Color(0xFFF7F8FC)
        : const Color(0xFFF5F7FF);
    final bgEnd = widget.isOfficial
        ? const Color(0xFFF3ECEC)
        : const Color(0xFFF0F3FF);
    final heroSubtext = widget.isOfficial
        ? const Color(0xFFFFD8D8)
        : const Color(0xFFDDE3FF);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        backgroundColor: appBarBg,
        foregroundColor: fg,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgStart, bgEnd],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [widget.heroStart, widget.heroEnd],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0x2EFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.item.icon, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x2EFFFFFF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            widget.isOfficial
                                ? 'Official Processing'
                                : 'Resident Request',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.item.subtitle,
                          style: TextStyle(
                            color: heroSubtext,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE4E8F2)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request Intake',
                      style: TextStyle(
                        color: Color(0xFF2F3248),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _requesterController,
                      decoration: const InputDecoration(
                        labelText: 'Requester Name',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name is required.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mobile number is required.';
                        }
                        if (value.replaceAll(RegExp(r'\D'), '').length < 10) {
                          return 'Enter a valid mobile number.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _priority,
                      decoration: const InputDecoration(labelText: 'Priority'),
                      items: const [
                        DropdownMenuItem(value: 'Low', child: Text('Low')),
                        DropdownMenuItem(
                          value: 'Normal',
                          child: Text('Normal'),
                        ),
                        DropdownMenuItem(
                          value: 'Urgent',
                          child: Text('Urgent'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _priority = value ?? 'Normal');
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _detailsController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Request Details',
                        hintText:
                            'Describe your ${widget.item.title.toLowerCase()} request.',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 10) {
                          return 'Please enter at least 10 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _submitting ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: widget.heroStart,
                        ),
                        icon: const Icon(Icons.send_rounded),
                        label: Text(
                          _submitting ? 'Submitting...' : 'Submit Request',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (hasSubmission) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2FAF6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFCAE9D8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request Submitted',
                      style: TextStyle(
                        color: Color(0xFF2E4D3F),
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Reference: $_reference',
                      style: const TextStyle(
                        color: Color(0xFF2F5E47),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Time: ${_formatStamp(_submittedAt!)}',
                      style: const TextStyle(
                        color: Color(0xFF4D6E5E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const _SerbilisProgressRow(
                      icon: Icons.check_circle,
                      title: 'Received by Barangay Desk',
                      subtitle: 'Digital ticket has been queued.',
                    ),
                    const SizedBox(height: 6),
                    _SerbilisProgressRow(
                      icon: Icons.tune,
                      title: 'Screening and Routing',
                      subtitle: 'Assigned based on priority: $_priority',
                    ),
                    const SizedBox(height: 6),
                    _SerbilisProgressRow(
                      icon: Icons.schedule,
                      title: 'Expected update window',
                      subtitle: _priority == 'Urgent'
                          ? 'Within 2-4 hours'
                          : 'Within 24 hours',
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SerbilisProgressRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SerbilisProgressRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFE6F3EC),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: const Color(0xFF2E5A46), size: 18),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF2F3248),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF5E657D),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
