part of barangaymo_app;

class ResidentHomeShell extends StatefulWidget {
  const ResidentHomeShell({super.key});

  @override
  State<ResidentHomeShell> createState() => _ResidentHomeShellState();
}

class _ResidentHomeShellState extends State<ResidentHomeShell> {
  int tab = 0;
  final pages = const [
    ResidentDashboardPage(),
    ResidentJobsPage(),
    ResidentMarketPage(),
    ResidentServicesPage(),
    ResidentProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECEAFF),
        elevation: 0,
        titleSpacing: 14,
        title: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD9DDF8)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(
            'public/barangaymo.png',
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
      drawer: const ResidentDrawer(),
      body: pages[tab],
      floatingActionButton: tab == 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FloatingActionButton(
                heroTag: 'resident_community_chat',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResidentCommunityChatPage(),
                  ),
                ),
                backgroundColor: const Color(0xFF3E4CC7),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                child: const Icon(Icons.forum_outlined),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF9F3F3), Color(0xFFF0E8E8)],
            ),
            border: Border.all(color: const Color(0xFFE6DBDB)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              height: 78,
              backgroundColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
                states,
              ) {
                final isSelected = states.contains(WidgetState.selected);
                return TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected
                      ? const Color(0xFF523F3D)
                      : const Color(0xFF6A5A59),
                );
              }),
            ),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedIndex: tab,
              onDestinationSelected: (v) => setState(() => tab = v),
              destinations: [
                _navDestination(Icons.home, 'Home'),
                _navDestination(Icons.work, 'Jobs'),
                _navDestination(Icons.store, 'Market'),
                _navDestination(Icons.miscellaneous_services, 'Services'),
                _navDestination(Icons.person, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination _navDestination(IconData icon, String label) {
    return NavigationDestination(
      icon: Icon(icon, color: const Color(0xFF655757)),
      selectedIcon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFDCD5), Color(0xFFF6C8C0)],
          ),
          border: Border.all(color: const Color(0xFFFFEAE6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33B65A4F),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF7D3931)),
      ),
      label: label,
    );
  }
}

class ResidentDrawer extends StatelessWidget {
  const ResidentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(26)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF3F5FF), Color(0xFFF7F8FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3E4CC6), Color(0xFF6A79E7)],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x293544BE),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFFFFF), Color(0xFFE8EDFF)],
                        ),
                        border: Border.all(color: const Color(0x66FFFFFF)),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF3243B6),
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Shamira Balandra',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '9123456702',
                            style: TextStyle(
                              color: Color(0xFFDDE3FF),
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.34),
                              ),
                            ),
                            child: const Text(
                              'Verified Resident',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 14),
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(6, 2, 6, 6),
                      child: Text(
                        'Resident Menu',
                        style: TextStyle(
                          color: Color(0xFF596188),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _residentMenu(
                      context,
                      'Home',
                      const ResidentHomeShell(),
                      Icons.home,
                      isActive: true,
                    ),
                    _residentMenu(
                      context,
                      'My Cart',
                      const ResidentCartPage(),
                      Icons.shopping_cart,
                    ),
                    _residentMenu(
                      context,
                      'My Jobs',
                      const ResidentJobsPage(),
                      Icons.work,
                    ),
                    _residentMenu(
                      context,
                      'My Company',
                      const ResidentSellHubPage(),
                      Icons.business,
                    ),
                    _residentMenu(
                      context,
                      'RBI',
                      const ResidentRbiCardPage(),
                      Icons.badge,
                    ),
                    _residentMenu(
                      context,
                      'Add a Member',
                      const ResidentMemberListPage(),
                      Icons.person_add,
                    ),
                    _residentMenu(
                      context,
                      'FAQs',
                      const ResidentFaqPage(),
                      Icons.help,
                    ),
                    _residentMenu(
                      context,
                      'Settings',
                      const ResidentSettingsPage(),
                      Icons.settings,
                    ),
                    _residentMenu(
                      context,
                      'Support',
                      const ResidentSupportPage(),
                      Icons.support_agent,
                    ),
                    _residentMenu(
                      context,
                      'Bug Report',
                      const ResidentBugReportPage(),
                      Icons.bug_report,
                    ),
                    _residentMenu(
                      context,
                      'About Us',
                      const ResidentAboutPage(),
                      Icons.info,
                    ),
                    _residentMenu(
                      context,
                      'Terms and Policies',
                      const ResidentTermsPage(),
                      Icons.policy,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE7E6EA)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            leading: const Icon(
                              Icons.logout,
                              color: Color(0xFF6A6072),
                            ),
                            title: const Text(
                              'Log out',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3C3E4F),
                              ),
                            ),
                            onTap: () => _openLogoutSheet(context),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            dense: true,
                            leading: const Icon(
                              Icons.delete_outline,
                              color: Color(0xFFE24C3B),
                            ),
                            title: const Text(
                              'Delete Account',
                              style: TextStyle(
                                color: Color(0xFFE24C3B),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ResidentDeleteAccountPage(),
                                ),
                              );
                            },
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
      ),
    );
  }

  Widget _residentMenu(
    BuildContext context,
    String title,
    Widget page,
    IconData icon, {
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => page));
          },
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isActive
                  ? const Color(0xFFE7ECFF)
                  : const Color(0xFFFFFFFF).withValues(alpha: 0.72),
              border: Border.all(
                color: isActive
                    ? const Color(0xFFC9D4FF)
                    : const Color(0xFFE9E8ED),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isActive
                          ? const [Color(0xFFD5DEFF), Color(0xFFEAF0FF)]
                          : const [Color(0xFFF1F3FF), Color(0xFFF8F8FF)],
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: isActive
                        ? const Color(0xFF3E4FC0)
                        : const Color(0xFF5D617A),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: isActive
                          ? const Color(0xFF3643A5)
                          : const Color(0xFF3D4051),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isActive
                      ? const Color(0xFF3E4FC0)
                      : const Color(0xFF888CA2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLogoutSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RoleGatewayScreen(),
                      ),
                      (route) => false,
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2E35D3),
                    ),
                    child: const Text('Yes, Log out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResidentHighlightData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color start;
  final Color end;
  final String tag;
  final String actionLabel;
  final String? socialPlatform;
  const _ResidentHighlightData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.start,
    required this.end,
    required this.tag,
    this.actionLabel = 'Open',
    this.socialPlatform,
  });

  bool get isSocialConnect => socialPlatform != null;
}

class _ResidentJobData {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String schedule;
  final bool urgent;
  final String postedBy;
  final String requirements;
  const _ResidentJobData({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.schedule,
    this.urgent = false,
    this.postedBy = 'Barangay Job Desk',
    this.requirements = '',
  });
}

class _ResidentProductData {
  final String title;
  final String seller;
  final double price;
  final double? originalPrice;
  final IconData icon;
  final bool verified;
  final String imageAsset;
  final String description;
  final String category;
  final double rating;
  final int reviews;
  final int sold;
  final int stock;
  final String eta;
  const _ResidentProductData({
    required this.title,
    required this.seller,
    required this.price,
    this.originalPrice,
    required this.icon,
    required this.imageAsset,
    required this.description,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.sold,
    required this.stock,
    required this.eta,
    this.verified = false,
  });
}

class ResidentDashboardPage extends StatelessWidget {
  const ResidentDashboardPage({super.key});

  static const _communityHighlights = [
    _ResidentHighlightData(
      title: 'Connect Instagram',
      subtitle: 'Show your IG handle for event tags and campaign invites',
      icon: Icons.camera_alt_rounded,
      start: Color(0xFFF7C3E6),
      end: Color(0xFFFDEBFA),
      tag: 'Social',
      actionLabel: 'Connect',
      socialPlatform: 'Instagram',
    ),
    _ResidentHighlightData(
      title: 'Connect Facebook',
      subtitle: 'Link your profile to receive barangay announcements',
      icon: Icons.facebook,
      start: Color(0xFFC9DEFF),
      end: Color(0xFFE9F2FF),
      tag: 'Social',
      actionLabel: 'Connect',
      socialPlatform: 'Facebook',
    ),
    _ResidentHighlightData(
      title: 'Barangay Clean-Up',
      subtitle: 'Saturday, 7:00 AM at Covered Court',
      icon: Icons.cleaning_services,
      start: Color(0xFFBFD9FF),
      end: Color(0xFFDEEAFD),
      tag: 'Community',
    ),
    _ResidentHighlightData(
      title: 'Night Patrol Update',
      subtitle: 'BPAT coverage expanded for Zone 3',
      icon: Icons.shield_moon,
      start: Color(0xFFD6CCFF),
      end: Color(0xFFECE8FF),
      tag: 'Safety',
    ),
    _ResidentHighlightData(
      title: 'Health Caravan',
      subtitle: 'Free checkups this Friday, 9:00 AM',
      icon: Icons.medical_services,
      start: Color(0xFFFFD8D0),
      end: Color(0xFFFFECE7),
      tag: 'Health',
    ),
  ];

  static const _marketHighlights = [
    _ResidentHighlightData(
      title: 'Fresh Harvest Deals',
      subtitle: 'Up to 20% off from local growers',
      icon: Icons.local_offer,
      start: Color(0xFFFFE1CC),
      end: Color(0xFFFFF0E6),
      tag: 'Food',
    ),
    _ResidentHighlightData(
      title: 'Tech Essentials',
      subtitle: 'Laptop and printer bundles available',
      icon: Icons.devices,
      start: Color(0xFFCFE7FF),
      end: Color(0xFFEAF4FF),
      tag: 'Electronics',
    ),
    _ResidentHighlightData(
      title: 'Gov Procurement',
      subtitle: 'Sell products directly to LGU buyers',
      icon: Icons.account_balance,
      start: Color(0xFFD7F5E5),
      end: Color(0xFFECFBF3),
      tag: 'Business',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5F7FF), Color(0xFFF8F1F1)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 20),
        children: [
          _hero(context),
          const SizedBox(height: 14),
          _sectionHeader(
            context,
            'Quick Tools',
            'Customize',
            onAction: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const _QuickToolsCustomizePage(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _quickTool(
                context,
                Icons.emergency,
                'Emergency',
                const ResponderPage(),
              ),
              _quickTool(
                context,
                Icons.sell,
                'Sell',
                const ResidentSellHubPage(),
              ),
              _quickTool(context, Icons.work, 'Jobs', const ResidentJobsPage()),
              _quickTool(
                context,
                Icons.assignment,
                'Requests',
                const ResidentRequestsPage(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _metricCard(
                  label: 'Pending Requests',
                  value: '02',
                  icon: Icons.pending_actions,
                  start: const Color(0xFFE2DEFF),
                  end: const Color(0xFFF4F2FF),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metricCard(
                  label: 'Profile Score',
                  value: '78%',
                  icon: Icons.verified_user,
                  start: const Color(0xFFFFE0D7),
                  end: const Color(0xFFFFF1EC),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _sectionHeader(
            context,
            'Community Highlights',
            'View All',
            onAction: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => _ResidentHighlightsPage(
                  title: 'Community Highlights',
                  items: _communityHighlights,
                  openToMarket: false,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 198,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _communityHighlights.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final item = _communityHighlights[i];
                return _highlightCard(
                  context,
                  item,
                  onTap: () {
                    if (item.isSocialConnect) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => _ResidentSocialConnectPage(
                            platform: item.socialPlatform!,
                            icon: item.icon,
                            start: item.start,
                            end: item.end,
                          ),
                        ),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _ResidentHighlightDetailPage(
                          data: item,
                          openToMarket: false,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          _sectionHeader(
            context,
            'Marketplace Picks',
            'Open Market',
            onAction: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResidentMarketPage()),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 198,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _marketHighlights.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (_, i) => _highlightCard(
                context,
                _marketHighlights[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _ResidentHighlightDetailPage(
                      data: _marketHighlights[i],
                      openToMarket: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 430;
        final buttonStyle = ButtonStyle(
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
        Widget heroActions() {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResidentVerifyProfilePage(),
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF3039A3),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ).merge(buttonStyle),
                child: const Text('Verify Profile'),
              ),
              OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResidentRbiCardPage(),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0x66FFFFFF)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ).merge(buttonStyle),
                child: const Text('RBI Card'),
              ),
            ],
          );
        }

        final heroBadge = Container(
          width: compact ? 62 : 74,
          height: compact ? 62 : 74,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFFFF), Color(0xFFE4E8FF)],
            ),
            border: Border.all(color: const Color(0x66FFFFFF)),
          ),
          child: Image.asset(
            'public/barangaymo.png',
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        );
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3D4BC1), Color(0xFF6671E3)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x332E35D3),
                blurRadius: 16,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (compact)
                Align(alignment: Alignment.centerRight, child: heroBadge),
              if (compact) const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good day, Shamira',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Everything you need from your barangay in one place.',
                          style: TextStyle(color: Color(0xFFDDE0FF)),
                        ),
                        const SizedBox(height: 14),
                        heroActions(),
                      ],
                    ),
                  ),
                  if (!compact) ...[const SizedBox(width: 10), heroBadge],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _quickTool(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFFCFF), Color(0xFFD9D3FF)],
                ),
                border: Border.all(color: const Color(0xFFFFFFFF), width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x332E35D3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Color(0x66FFFFFF),
                    blurRadius: 6,
                    offset: Offset(-2, -2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 10,
                    left: 12,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Color(0x66FFFFFF),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    left: 19,
                    child: Icon(icon, color: const Color(0x402E35D3), size: 24),
                  ),
                  Icon(icon, color: const Color(0xFF2E35D3), size: 24),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricCard({
    required String label,
    required String value,
    required IconData icon,
    required Color start,
    required Color end,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [start, end],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: const Color(0xFF3B3D56), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2E2E3A),
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF5E6070),
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

  Widget _highlightCard(
    BuildContext context,
    _ResidentHighlightData data, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 236,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [data.start, data.end],
          ),
          border: Border.all(color: const Color(0xFFE4E8F2)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x15000000),
              blurRadius: 9,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _highlightHero(data),
            const SizedBox(height: 10),
            Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2F3146),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              data.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF53566D),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  data.actionLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3A3E56),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: Color(0xFF3A3E56),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _highlightHero(_ResidentHighlightData data) {
    if (!data.isSocialConnect) {
      return Container(
        height: 64,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.7),
              Colors.white.withValues(alpha: 0.45),
            ],
          ),
          border: Border.all(color: const Color(0x78FFFFFF)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(data.icon, color: const Color(0xFF40435F)),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.76),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                data.tag,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4A4D64),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final isInstagram = data.socialPlatform == 'Instagram';
    final iconColor = isInstagram
        ? const Color(0xFFD92979)
        : const Color(0xFF1462D4);
    final socialColors = isInstagram
        ? const [Color(0xFFFFD2EB), Color(0xFFF8E5FF), Color(0xFFEED8FF)]
        : const [Color(0xFFD6E8FF), Color(0xFFE9F3FF), Color(0xFFDDEAFF)];

    return Container(
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: socialColors,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.72)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -18,
            right: -8,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
          ),
          Positioned(
            bottom: -12,
            left: 36,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFFFFF), Color(0xFFF2F4FF)],
                  ),
                  border: Border.all(color: const Color(0x88FFFFFF)),
                ),
                child: Icon(data.icon, color: iconColor),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Verified Connect',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3D4160),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.84),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  data.tag,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4A4D64),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    String title,
    String action, {
    VoidCallback? onAction,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
        ),
        TextButton(
          onPressed:
              onAction ?? () => _showFeature(context, '$title - $action'),
          child: Text(
            action,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _QuickToolsCustomizePage extends StatelessWidget {
  const _QuickToolsCustomizePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Quick Tools'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FF), Color(0xFFF2F4F9)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE4E8F2)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Tool Shortcuts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3248),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap any shortcut to open the feature instantly.',
                    style: TextStyle(
                      color: Color(0xFF66708A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _quickToolShortcut(
              context,
              icon: Icons.emergency,
              title: 'Emergency',
              subtitle: 'Open responder and hotline assistance',
              page: const ResponderPage(),
            ),
            _quickToolShortcut(
              context,
              icon: Icons.sell,
              title: 'Sell',
              subtitle: 'Manage products and seller options',
              page: const ResidentSellHubPage(),
            ),
            _quickToolShortcut(
              context,
              icon: Icons.work,
              title: 'Jobs',
              subtitle: 'Browse and apply to job opportunities',
              page: const ResidentJobsPage(),
            ),
            _quickToolShortcut(
              context,
              icon: Icons.assignment,
              title: 'Requests',
              subtitle: 'Track resident requests and status',
              page: const ResidentRequestsPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickToolShortcut(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E8F4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EDFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF4855BF)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF2F3248),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF676D86),
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}

class _ResidentHighlightsPage extends StatelessWidget {
  final String title;
  final List<_ResidentHighlightData> items;
  final bool openToMarket;

  const _ResidentHighlightsPage({
    required this.title,
    required this.items,
    required this.openToMarket,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF7F8FF),
        foregroundColor: const Color(0xFF2F3248),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FF), Color(0xFFF2F4F9)],
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final item = items[i];
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                if (item.isSocialConnect) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _ResidentSocialConnectPage(
                        platform: item.socialPlatform!,
                        icon: item.icon,
                        start: item.start,
                        end: item.end,
                      ),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _ResidentHighlightDetailPage(
                      data: item,
                      openToMarket: openToMarket,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE4E8F2)),
                ),
                child: ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.84),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: const Color(0xFF1F2B63)),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      color: Color(0xFF2F3248),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    item.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF676D86),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    item.isSocialConnect
                        ? Icons.link_rounded
                        : Icons.chevron_right_rounded,
                    color: const Color(0xFF636A85),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ResidentSocialConnectPage extends StatefulWidget {
  final String platform;
  final IconData icon;
  final Color start;
  final Color end;

  const _ResidentSocialConnectPage({
    required this.platform,
    required this.icon,
    required this.start,
    required this.end,
  });

  @override
  State<_ResidentSocialConnectPage> createState() =>
      _ResidentSocialConnectPageState();
}

class _ResidentSocialConnectPageState
    extends State<_ResidentSocialConnectPage> {
  final TextEditingController _handleController = TextEditingController();
  bool _visibleToResidents = true;
  bool _receiveAlerts = true;
  bool _connected = false;

  bool get _isInstagram => widget.platform == 'Instagram';

  Color get _primary =>
      _isInstagram ? const Color(0xFFE1306C) : const Color(0xFF1877F2);

  List<Color> get _heroColors => _isInstagram
      ? const [Color(0xFFF58529), Color(0xFFDD2A7B), Color(0xFF8134AF)]
      : const [Color(0xFF1877F2), Color(0xFF2A67D7), Color(0xFF4D8BFF)];

  @override
  void dispose() {
    _handleController.dispose();
    super.dispose();
  }

  String _sanitizeHandle(String value) {
    return value.trim().replaceFirst('@', '');
  }

  void _connect() {
    final handle = _sanitizeHandle(_handleController.text);
    if (handle.isEmpty) {
      _showFeature(context, 'Enter your ${widget.platform} username first.');
      return;
    }
    setState(() => _connected = true);
    _showFeature(context, '${widget.platform} connected as @$handle');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect ${widget.platform}'),
        backgroundColor: const Color(0xFFF7F8FF),
        foregroundColor: const Color(0xFF2F3248),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FF), Color(0xFFF2F4F9)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _heroColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _primary.withValues(alpha: 0.34),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -22,
                    right: -18,
                    child: Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -10,
                    child: Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.16),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white.withValues(alpha: 0.94),
                        ),
                        child: Icon(widget.icon, color: _primary, size: 32),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.platform} Integration',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Connect once and receive official community updates instantly.',
                              style: TextStyle(
                                color: Color(0xFFF2EEFF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                border: Border.all(color: const Color(0xFFE4E8F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.platform} username',
                    style: const TextStyle(
                      color: Color(0xFF2F3248),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _handleController,
                    decoration: InputDecoration(
                      hintText: '@yourhandle',
                      prefixIcon: const Icon(Icons.alternate_email_rounded),
                      filled: true,
                      fillColor: const Color(0xFFF8F9FD),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFD8DFF1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFD8DFF1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: _primary, width: 1.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _visibleToResidents,
                    onChanged: (v) => setState(() => _visibleToResidents = v),
                    title: const Text(
                      'Show on resident profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF333850),
                      ),
                    ),
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _receiveAlerts,
                    onChanged: (v) => setState(() => _receiveAlerts = v),
                    title: const Text(
                      'Receive event and alert mentions',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF333850),
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
                onPressed: _connected
                    ? null
                    : () {
                        _connect();
                      },
                style: FilledButton.styleFrom(backgroundColor: _primary),
                icon: Icon(
                  _connected ? Icons.check_circle : Icons.link_rounded,
                ),
                label: Text(
                  _connected ? 'Connected' : 'Connect ${widget.platform}',
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (_connected)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() => _connected = false);
                    _showFeature(context, '${widget.platform} disconnected');
                  },
                  icon: const Icon(Icons.link_off_rounded),
                  label: const Text('Disconnect'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResidentHighlightDetailPage extends StatelessWidget {
  final _ResidentHighlightData data;
  final bool openToMarket;

  const _ResidentHighlightDetailPage({
    required this.data,
    required this.openToMarket,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        backgroundColor: const Color(0xFFF7F8FF),
        foregroundColor: const Color(0xFF2F3248),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FF), Color(0xFFF2F4F9)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [data.start, data.end],
                ),
                border: Border.all(color: const Color(0xFFE2E7F2)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(data.icon, color: const Color(0xFF26336A)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF202540),
                          ),
                        ),
                        Text(
                          data.subtitle,
                          style: const TextStyle(
                            color: Color(0xFF313A67),
                            fontWeight: FontWeight.w700,
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
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE4E8F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What you can do here',
                    style: TextStyle(
                      color: Color(0xFF2F3248),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ResidentActionRow(
                    icon: Icons.flash_on,
                    text: openToMarket
                        ? 'Open marketplace catalog and browse active offers.'
                        : 'View complete activity details and schedule.',
                  ),
                  const SizedBox(height: 8),
                  _ResidentActionRow(
                    icon: Icons.notifications_active,
                    text:
                        'Enable notifications to get live updates and reminders.',
                  ),
                  const SizedBox(height: 8),
                  _ResidentActionRow(
                    icon: Icons.verified,
                    text: 'Your action is recorded in-app for status tracking.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  if (openToMarket) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentMarketPage(),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentRequestsPage(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4A64FF),
                ),
                icon: Icon(openToMarket ? Icons.storefront : Icons.event),
                label: Text(
                  openToMarket ? 'Open Marketplace' : 'Open Requests',
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showFeature(
                  context,
                  'Notification enabled for ${data.title}',
                ),
                icon: const Icon(Icons.notifications),
                label: const Text('Notify Me'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResidentActionRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ResidentActionRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFE8ECF8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF38406A), size: 16),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF5D647D),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
