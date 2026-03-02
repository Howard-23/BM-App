part of barangaymo_app;

class _ResidentTalentPostData {
  final String fullName;
  final String desiredJob;
  final String skills;
  final String preferredSetup;
  final String expectedSalary;
  final String barangayZone;
  final bool availableNow;

  const _ResidentTalentPostData({
    required this.fullName,
    required this.desiredJob,
    required this.skills,
    required this.preferredSetup,
    required this.expectedSalary,
    required this.barangayZone,
    this.availableNow = true,
  });
}

class _ResidentJobNotificationData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final DateTime createdAt;
  bool unread;

  _ResidentJobNotificationData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.createdAt,
    this.unread = true,
  });
}

class _ResidentJobsHub {
  static final ValueNotifier<int> refresh = ValueNotifier<int>(0);

  static final List<_ResidentJobData> jobs = [
    const _ResidentJobData(
      title: 'Barangay Administrative Aide',
      company: 'Barangay Hall - Personnel Office',
      location: 'Old Cabalan, Olongapo',
      salary: 'PHP 18,000 / month',
      schedule: 'Full-time',
      urgent: true,
      postedBy: 'Barangay HR Desk',
      requirements:
          'MS Office, records management, and resident-facing support.',
    ),
    const _ResidentJobData(
      title: 'Community Health Volunteer',
      company: 'Barangay Health Unit',
      location: 'Health Center Annex',
      salary: 'PHP 450 / day allowance',
      schedule: 'Part-time',
      postedBy: 'RHU Coordinator',
      requirements: 'Basic first aid, house-to-house support, and reporting.',
    ),
    const _ResidentJobData(
      title: 'Digital Records Encoder',
      company: 'Barangay Information Desk',
      location: 'Remote + On-site',
      salary: 'PHP 650 / day',
      schedule: 'Contract',
      postedBy: 'Info Desk Team',
      requirements:
          'Fast typing, document validation, and secure data handling.',
    ),
  ];

  static final List<_ResidentTalentPostData> talents = [
    const _ResidentTalentPostData(
      fullName: 'J. Santos',
      desiredJob: 'Office Staff / Data Encoder',
      skills: 'Excel, Google Docs, Canva, resident support',
      preferredSetup: 'On-site',
      expectedSalary: 'PHP 16,000 / month',
      barangayZone: 'Zone 2',
    ),
    const _ResidentTalentPostData(
      fullName: 'R. Villanueva',
      desiredJob: 'Barangay Utility / Maintenance',
      skills: 'Electrical repair, carpentry, preventive maintenance',
      preferredSetup: 'Field-based',
      expectedSalary: 'PHP 700 / day',
      barangayZone: 'Zone 5',
    ),
  ];

  static final List<_ResidentJobNotificationData> notifications = [
    _ResidentJobNotificationData(
      title: 'Jobs board is active',
      subtitle: 'You can now post hiring needs or job hunter profiles.',
      icon: Icons.campaign_rounded,
      accent: const Color(0xFF4A64FF),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      unread: false,
    ),
  ];

  static int get unreadCount =>
      notifications.where((item) => item.unread).length;

  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.month}/${date.day}/${date.year}';
  }

  static void _emit() {
    refresh.value++;
  }

  static void markAllRead() {
    for (final item in notifications) {
      item.unread = false;
    }
    _emit();
  }

  static void addHiringPost({
    required String title,
    required String company,
    required String location,
    required String salary,
    required String schedule,
    required String requirements,
    required String postedBy,
    required bool urgent,
  }) {
    jobs.insert(
      0,
      _ResidentJobData(
        title: title,
        company: company,
        location: location,
        salary: salary,
        schedule: schedule,
        urgent: urgent,
        postedBy: postedBy,
        requirements: requirements,
      ),
    );
    notifications.insert(
      0,
      _ResidentJobNotificationData(
        title: 'New job post: $title',
        subtitle: '$company posted a $schedule role in $location.',
        icon: Icons.work_outline_rounded,
        accent: const Color(0xFF3860D8),
        createdAt: DateTime.now(),
      ),
    );
    _emit();
  }

  static void addTalentPost({
    required String fullName,
    required String desiredJob,
    required String skills,
    required String preferredSetup,
    required String expectedSalary,
    required String zone,
    required bool availableNow,
  }) {
    talents.insert(
      0,
      _ResidentTalentPostData(
        fullName: fullName,
        desiredJob: desiredJob,
        skills: skills,
        preferredSetup: preferredSetup,
        expectedSalary: expectedSalary,
        barangayZone: zone,
        availableNow: availableNow,
      ),
    );
    notifications.insert(
      0,
      _ResidentJobNotificationData(
        title: 'New job hunter profile posted',
        subtitle: '$fullName is looking for "$desiredJob".',
        icon: Icons.person_search_rounded,
        accent: const Color(0xFF8B4FD8),
        createdAt: DateTime.now(),
      ),
    );
    _emit();
  }
}

class ResidentJobsPage extends StatefulWidget {
  const ResidentJobsPage({super.key});

  @override
  State<ResidentJobsPage> createState() => _ResidentJobsPageState();
}

class _ResidentJobsPageState extends State<ResidentJobsPage> {
  static const _filters = ['All', 'Full-time', 'Part-time', 'Contract'];

  final _searchController = TextEditingController();
  String _selectedFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_ResidentJobData> _filteredJobs() {
    final q = _searchController.text.trim().toLowerCase();
    return _ResidentJobsHub.jobs.where((job) {
      final byFilter =
          _selectedFilter == 'All' ||
          job.schedule.toLowerCase() == _selectedFilter.toLowerCase();
      final haystack =
          '${job.title} ${job.company} ${job.location} ${job.schedule} ${job.requirements}'
              .toLowerCase();
      final byQuery = q.isEmpty || haystack.contains(q);
      return byFilter && byQuery;
    }).toList();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD7DEF0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD7DEF0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF4A64FF), width: 1.3),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: _inputDecoration(hint),
    );
  }

  void _openPostHiringSheet(BuildContext context) {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final salaryController = TextEditingController();
    final requirementsController = TextEditingController();
    final postedByController = TextEditingController(text: 'Barangay Employer');
    String schedule = 'Full-time';
    bool urgent = false;

    showModalBottomSheet<void>(
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xFFF9FAFF),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF3049C7), Color(0xFF4E6DF2)],
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.post_add_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 9),
                            Expanded(
                              child: Text(
                                'Post Hiring Job',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _field(titleController, 'Job title'),
                      const SizedBox(height: 8),
                      _field(companyController, 'Company / Office'),
                      const SizedBox(height: 8),
                      _field(locationController, 'Location'),
                      const SizedBox(height: 8),
                      _field(salaryController, 'Salary / Offer'),
                      const SizedBox(height: 8),
                      _field(
                        requirementsController,
                        'Skills and requirements',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8),
                      _field(postedByController, 'Posted by'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: schedule,
                        decoration: _inputDecoration('Schedule'),
                        items: const [
                          DropdownMenuItem(
                            value: 'Full-time',
                            child: Text('Full-time'),
                          ),
                          DropdownMenuItem(
                            value: 'Part-time',
                            child: Text('Part-time'),
                          ),
                          DropdownMenuItem(
                            value: 'Contract',
                            child: Text('Contract'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setModal(() => schedule = value);
                        },
                      ),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        value: urgent,
                        onChanged: (value) => setModal(() => urgent = value),
                        title: const Text(
                          'Mark this post as urgent hiring',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            final title = titleController.text.trim();
                            final company = companyController.text.trim();
                            final location = locationController.text.trim();
                            final salary = salaryController.text.trim();
                            final requirements = requirementsController.text
                                .trim();
                            final postedBy = postedByController.text.trim();

                            if (title.isEmpty ||
                                company.isEmpty ||
                                location.isEmpty ||
                                salary.isEmpty ||
                                requirements.isEmpty ||
                                postedBy.isEmpty) {
                              _showFeature(
                                context,
                                'Complete all fields before posting.',
                              );
                              return;
                            }

                            _ResidentJobsHub.addHiringPost(
                              title: title,
                              company: company,
                              location: location,
                              salary: salary,
                              schedule: schedule,
                              requirements: requirements,
                              postedBy: postedBy,
                              urgent: urgent,
                            );
                            Navigator.pop(context);
                            _showFeature(
                              this.context,
                              'Hiring post published. Residents are notified.',
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF3758DD),
                          ),
                          icon: const Icon(Icons.publish_rounded),
                          label: const Text('Publish Hiring Post'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      titleController.dispose();
      companyController.dispose();
      locationController.dispose();
      salaryController.dispose();
      requirementsController.dispose();
      postedByController.dispose();
    });
  }

  void _openJobHunterSheet(BuildContext context) {
    final nameController = TextEditingController();
    final desiredController = TextEditingController();
    final skillsController = TextEditingController();
    final salaryController = TextEditingController();
    final zoneController = TextEditingController(text: 'Zone 1');
    String setup = 'On-site';
    bool availableNow = true;

    showModalBottomSheet<void>(
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xFFFDF9FF),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF6A3ACB), Color(0xFF9C5BE5)],
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.badge_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 9),
                            Expanded(
                              child: Text(
                                'Post Job Hunter Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _field(nameController, 'Full name / display name'),
                      const SizedBox(height: 8),
                      _field(desiredController, 'Desired job role'),
                      const SizedBox(height: 8),
                      _field(skillsController, 'Skills (comma separated)'),
                      const SizedBox(height: 8),
                      _field(salaryController, 'Expected salary'),
                      const SizedBox(height: 8),
                      _field(zoneController, 'Barangay zone'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: setup,
                        decoration: _inputDecoration('Preferred setup'),
                        items: const [
                          DropdownMenuItem(
                            value: 'On-site',
                            child: Text('On-site'),
                          ),
                          DropdownMenuItem(
                            value: 'Remote',
                            child: Text('Remote'),
                          ),
                          DropdownMenuItem(
                            value: 'Field-based',
                            child: Text('Field-based'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setModal(() => setup = value);
                        },
                      ),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        value: availableNow,
                        onChanged: (value) =>
                            setModal(() => availableNow = value),
                        title: const Text(
                          'Available to start immediately',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            final fullName = nameController.text.trim();
                            final desiredJob = desiredController.text.trim();
                            final skills = skillsController.text.trim();
                            final expectedSalary = salaryController.text.trim();
                            final zone = zoneController.text.trim();
                            if (fullName.isEmpty ||
                                desiredJob.isEmpty ||
                                skills.isEmpty ||
                                expectedSalary.isEmpty ||
                                zone.isEmpty) {
                              _showFeature(
                                context,
                                'Complete all fields before posting.',
                              );
                              return;
                            }
                            _ResidentJobsHub.addTalentPost(
                              fullName: fullName,
                              desiredJob: desiredJob,
                              skills: skills,
                              preferredSetup: setup,
                              expectedSalary: expectedSalary,
                              zone: zone,
                              availableNow: availableNow,
                            );
                            Navigator.pop(context);
                            _showFeature(
                              this.context,
                              'Job hunter profile published.',
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF7E46D7),
                          ),
                          icon: const Icon(Icons.rocket_launch_rounded),
                          label: const Text('Publish Profile'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      nameController.dispose();
      desiredController.dispose();
      skillsController.dispose();
      salaryController.dispose();
      zoneController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final clampedMedia = media.copyWith(
      textScaler: const TextScaler.linear(1.0),
    );

    final content = MediaQuery(
      data: clampedMedia,
      child: Material(
        color: Colors.transparent,
        child: ValueListenableBuilder<int>(
          valueListenable: _ResidentJobsHub.refresh,
          builder: (_, __, ___) {
            final jobs = _filteredJobs();
            final talents = _ResidentJobsHub.talents;
            final unread = _ResidentJobsHub.unreadCount;
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF6F8FF), Color(0xFFF9F0F0)],
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Jobs & Skills Board',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2C2F45),
                          ),
                        ),
                      ),
                      _badgeIconButton(
                        icon: Icons.notifications_none_rounded,
                        count: unread,
                        onTap: () {
                          _ResidentJobsHub.markAllRead();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResidentNotificationsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2F46C9), Color(0xFF5878F5)],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x262E35D3),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -20,
                          right: -8,
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.18),
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
                                    'Hiring + Job Hunter Posting',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Employers can post openings. Job hunters can post skills and desired roles.',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color(0xFFDDE1FF),
                                      height: 1.25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Color(0x33FFFFFF),
                              child: Icon(
                                Icons.groups_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _actionTile(
                          title: 'Post Hiring',
                          subtitle: 'For employers',
                          icon: Icons.business_center_rounded,
                          start: const Color(0xFFD8E4FF),
                          end: const Color(0xFFEFF4FF),
                          onTap: () => _openPostHiringSheet(context),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _actionTile(
                          title: 'Post Skills',
                          subtitle: 'For job hunters',
                          icon: Icons.person_search_rounded,
                          start: const Color(0xFFEBD9FF),
                          end: const Color(0xFFF7EEFF),
                          onTap: () => _openJobHunterSheet(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFE5E6F2)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: const Icon(Icons.search),
                        hintText:
                            'Search by title, company, location, or skill',
                        suffixIcon: _searchController.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _filters.map((f) {
                      final selected = _selectedFilter == f;
                      return ChoiceChip(
                        label: Text(f),
                        selected: selected,
                        onSelected: (_) => setState(() => _selectedFilter = f),
                        selectedColor: const Color(0xFFE2E6FF),
                        side: BorderSide(
                          color: selected
                              ? const Color(0xFF4A57BF)
                              : const Color(0xFFD1D3E4),
                        ),
                        labelStyle: TextStyle(
                          color: selected
                              ? const Color(0xFF2E35D3)
                              : const Color(0xFF5A5E74),
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Hiring Posts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2E3044),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (jobs.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E7F3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.search_off_rounded,
                            size: 36,
                            color: Color(0xFF7A7F9A),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'No jobs match your search.',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF3B3F57),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Try another keyword or change the filter.',
                            style: TextStyle(color: Color(0xFF666B86)),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _selectedFilter = 'All');
                            },
                            child: const Text('Reset'),
                          ),
                        ],
                      ),
                    )
                  else
                    ...jobs.map((job) => _jobCard(context, job)),
                  const SizedBox(height: 8),
                  const Text(
                    'Job Hunter Profiles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2E3044),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...talents.map((talent) => _talentCard(context, talent)),
                ],
              ),
            );
          },
        ),
      ),
    );

    if (Scaffold.maybeOf(context) == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Jobs')),
        body: content,
      );
    }

    return content;
  }

  Widget _badgeIconButton({
    required IconData icon,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE6E8F4)),
            ),
            child: Icon(icon, color: const Color(0xFF4251B2)),
          ),
          if (count > 0)
            Positioned(
              top: -5,
              right: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFE44937),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color start,
    required Color end,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [start, end],
          ),
          border: Border.all(color: const Color(0xFFE5E8F5)),
        ),
        child: Row(
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.86),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: const Color(0xFF3F4DB5)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2E3248),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF626883),
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

  Widget _jobCard(BuildContext context, _ResidentJobData job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6E7F1)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2E3044),
                    ),
                  ),
                ),
                if (job.urgent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFFFE6E0),
                    ),
                    child: const Text(
                      'URGENT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFB5442E),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '${job.company} - Posted by ${job.postedBy}',
              style: const TextStyle(
                color: Color(0xFF6A6E87),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Color(0xFF6B6E84),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.location,
                    style: const TextStyle(color: Color(0xFF61657D)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.schedule, size: 16, color: Color(0xFF6B6E84)),
                const SizedBox(width: 4),
                Text(
                  job.schedule,
                  style: const TextStyle(
                    color: Color(0xFF555973),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  job.salary,
                  style: const TextStyle(
                    color: Color(0xFF3340B6),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            if (job.requirements.isNotEmpty) ...[
              const SizedBox(height: 7),
              Text(
                'Requirements: ${job.requirements}',
                style: const TextStyle(
                  color: Color(0xFF565D77),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showFeature(
                      context,
                      'Saved "${job.title}" for later.',
                    ),
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: () => _showFeature(
                      context,
                      'Application sent for "${job.title}".',
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF3946BD),
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _talentCard(BuildContext context, _ResidentTalentPostData talent) {
    final chips = talent.skills
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .take(4)
        .toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF7EEFF), Color(0xFFFDF8FF)],
        ),
        border: Border.all(color: const Color(0xFFEBDDFF)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE8D8FF),
                  ),
                  child: const Icon(Icons.person, color: Color(0xFF6D42C9)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        talent.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2E3044),
                        ),
                      ),
                      Text(
                        talent.desiredJob,
                        style: const TextStyle(
                          color: Color(0xFF675D7C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: talent.availableNow
                        ? const Color(0xFFE2F6E7)
                        : const Color(0xFFEDEEF5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    talent.availableNow ? 'AVAILABLE' : 'NOT AVAILABLE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: talent.availableNow
                          ? const Color(0xFF1E7F39)
                          : const Color(0xFF616681),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: chips
                  .map(
                    (chip) => Chip(
                      label: Text(chip),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: const Color(0xFFEFE6FF),
                      side: const BorderSide(color: Color(0xFFDCC8FF)),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.map_rounded,
                  size: 16,
                  color: Color(0xFF6D6A82),
                ),
                const SizedBox(width: 4),
                Text(
                  talent.barangayZone,
                  style: const TextStyle(
                    color: Color(0xFF5F5B74),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.work_outline,
                  size: 16,
                  color: Color(0xFF6D6A82),
                ),
                const SizedBox(width: 4),
                Text(
                  talent.preferredSetup,
                  style: const TextStyle(
                    color: Color(0xFF5F5B74),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  talent.expectedSalary,
                  style: const TextStyle(
                    color: Color(0xFF6D42C9),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showFeature(
                      context,
                      'Message sent to ${talent.fullName}.',
                    ),
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 16,
                    ),
                    label: const Text('Message'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _showFeature(
                      context,
                      'Invitation sent to ${talent.fullName}.',
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF7E46D7),
                    ),
                    icon: const Icon(Icons.person_add_alt_1_rounded, size: 16),
                    label: const Text('Invite'),
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

class ResidentMarketPage extends StatefulWidget {
  const ResidentMarketPage({super.key});

  @override
  State<ResidentMarketPage> createState() => _ResidentMarketPageState();
}

class _ResidentMarketPageState extends State<ResidentMarketPage> {
  static const _products = [
    _ResidentProductData(
      title: 'Lenovo IdeaPad 15.6"',
      seller: 'L. Nadong Electronics',
      price: 14999,
      originalPrice: 16999,
      icon: Icons.laptop_mac,
      imageAsset: 'public/item-laptop.jpg',
      description:
          'Reliable laptop for school, online work, and barangay office tasks. Includes charger and 6-month local warranty.',
      category: 'Electronics',
      rating: 4.8,
      reviews: 214,
      sold: 430,
      stock: 7,
      eta: 'Same-day in Old Cabalan',
      verified: true,
    ),
    _ResidentProductData(
      title: 'Epson EcoTank L3210',
      seller: 'Cabalan Office Depot',
      price: 8290,
      originalPrice: 8990,
      icon: Icons.print,
      imageAsset: 'public/item-printer.jpg',
      description:
          'High-yield printer ideal for document printing and certificate forms. Compatible with refill ink bottles.',
      category: 'Electronics',
      rating: 4.7,
      reviews: 168,
      sold: 292,
      stock: 12,
      eta: 'Ships within 24 hours',
      verified: true,
    ),
    _ResidentProductData(
      title: 'Foldable Study Table',
      seller: 'R. Dela Cruz Furnitures',
      price: 2499,
      originalPrice: 2999,
      icon: Icons.table_restaurant,
      imageAsset: 'public/item-table.jpg',
      description:
          'Space-saving foldable table for home study and small work areas with powder-coated steel frame.',
      category: 'Furniture',
      rating: 4.6,
      reviews: 96,
      sold: 205,
      stock: 18,
      eta: 'Pickup or 1-2 days delivery',
    ),
    _ResidentProductData(
      title: 'Emergency Go Bag',
      seller: 'Barangay Safety Co-op',
      price: 1250,
      originalPrice: 1450,
      icon: Icons.backpack,
      imageAsset: 'public/item-gobag.jpg',
      description:
          'Preparedness bag with first aid basics, flashlight, whistle, and waterproof storage pouches.',
      category: 'Emergency',
      rating: 4.9,
      reviews: 302,
      sold: 920,
      stock: 30,
      eta: 'Ready to deliver today',
    ),
  ];

  static const _sortOptions = [
    'Popular',
    'Top Rated',
    'Price: Low to High',
    'Price: High to Low',
  ];

  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedSort = _sortOptions.first;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() => setState(() {});

  List<String> get _categories {
    final values = <String>{'All'};
    for (final item in _products) {
      values.add(item.category);
    }
    return values.toList();
  }

  List<_ResidentProductData> get _visibleProducts {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _products.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      final haystack =
          '${item.title} ${item.seller} ${item.description} ${item.category}'
              .toLowerCase();
      final matchesQuery = query.isEmpty || haystack.contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    filtered.sort((a, b) {
      if (_selectedSort == 'Top Rated') {
        return b.rating.compareTo(a.rating);
      }
      if (_selectedSort == 'Price: Low to High') {
        return a.price.compareTo(b.price);
      }
      if (_selectedSort == 'Price: High to Low') {
        return b.price.compareTo(a.price);
      }
      return b.sold.compareTo(a.sold);
    });
    return filtered;
  }

  String _currency(double amount) => 'PHP ${amount.toStringAsFixed(2)}';

  String _compactCount(int value) {
    if (value >= 1000) {
      final formatted = value >= 10000
          ? (value / 1000).toStringAsFixed(0)
          : (value / 1000).toStringAsFixed(1);
      return '${formatted}k';
    }
    return '$value';
  }

  int _discountPercent(_ResidentProductData item) {
    final original = item.originalPrice;
    if (original == null || original <= item.price) {
      return 0;
    }
    final discount = ((original - item.price) / original * 100).round();
    return discount < 1 ? 1 : discount;
  }

  @override
  Widget build(BuildContext context) {
    final products = _visibleProducts;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF3F7FF), Color(0xFFF8F2EE)],
              ),
            ),
          ),
          Positioned(
            top: -64,
            right: -38,
            child: Container(
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFE6EEFF), Color(0x00E6EEFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: -58,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFFE8DE), Color(0x00FFE8DE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marketplace',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2A2E44),
                          ),
                        ),
                        Text(
                          'Trusted local products and services',
                          style: TextStyle(
                            color: Color(0xFF646A86),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _topIconButton(
                    icon: Icons.notifications_none_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentNotificationsPage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ValueListenableBuilder<int>(
                    valueListenable: _ResidentCartHub.refresh,
                    builder: (_, __, ___) {
                      return _topIconButton(
                        icon: Icons.shopping_cart_rounded,
                        badgeCount: _ResidentCartHub.items.length,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResidentCartPage(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE6E9F5)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () => _searchController.clear(),
                            icon: const Icon(Icons.close_rounded),
                          ),
                    hintText: 'Search products, sellers, or categories',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2F42BA), Color(0xFF6077EF)],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x2B2E35D3),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -20,
                      right: -16,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seller Boost Week',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Launch your products and get featured placement today.',
                                style: TextStyle(
                                  color: Color(0xFFDDE3FF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        FilledButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResidentSellHubPage(),
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF2F43BB),
                          ),
                          child: const Text('Start Selling'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (_) =>
                        setState(() => _selectedCategory = category),
                    side: BorderSide(
                      color: _selectedCategory == category
                          ? const Color(0xFF4257D3)
                          : const Color(0xFFD8DEEF),
                    ),
                    selectedColor: const Color(0xFFE8EEFF),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: _selectedCategory == category
                          ? const Color(0xFF2E3A8B)
                          : const Color(0xFF585E79),
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${products.length} item(s) found',
                    style: const TextStyle(
                      color: Color(0xFF5F6582),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    initialValue: _selectedSort,
                    onSelected: (value) =>
                        setState(() => _selectedSort = value),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    itemBuilder: (_) => _sortOptions
                        .map(
                          (option) => PopupMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ),
                        )
                        .toList(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDDE2F0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sort_rounded,
                            size: 17,
                            color: Color(0xFF4F5675),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _selectedSort,
                            style: const TextStyle(
                              color: Color(0xFF4F5675),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (products.isEmpty)
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E6F2)),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 42,
                        color: Color(0xFF7A809B),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'No products matched your filters.',
                        style: TextStyle(
                          color: Color(0xFF505670),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, i) => _marketTile(context, products[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _topIconButton({
    required IconData icon,
    required VoidCallback onTap,
    int badgeCount = 0,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE4E7F2)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF48507A)),
          ),
        ),
        if (badgeCount > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFE3483A),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              child: Text(
                badgeCount > 99 ? '99+' : '$badgeCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _statPill({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _marketTile(BuildContext context, _ResidentProductData item) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _ResidentProductPreviewPage(item: item),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE6E7F1)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 9,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 112,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE8EAFF), Color(0xFFF3F4FF)],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.asset(
                      item.imageAsset,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          item.icon,
                          size: 48,
                          color: const Color(0xFF4650B4),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  bottom: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.44),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      item.eta,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (_discountPercent(item) > 0)
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3483A),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '-${_discountPercent(item)}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3146),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.seller,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF676B84),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (item.verified)
                        const Icon(
                          Icons.verified_rounded,
                          size: 14,
                          color: Color(0xFF3C78E3),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _currency(item.price),
                    style: const TextStyle(
                      color: Color(0xFF3340B6),
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  if (item.originalPrice != null)
                    Text(
                      _currency(item.originalPrice!),
                      style: const TextStyle(
                        color: Color(0xFF8B90A8),
                        decoration: TextDecoration.lineThrough,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _statPill(
                        icon: Icons.star_rounded,
                        text: item.rating.toStringAsFixed(1),
                        color: const Color(0xFFF2A93B),
                      ),
                      const SizedBox(width: 6),
                      _statPill(
                        icon: Icons.local_fire_department_rounded,
                        text: '${_compactCount(item.sold)} sold',
                        color: const Color(0xFF3A63CC),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Stock ${item.stock}',
                          style: const TextStyle(
                            color: Color(0xFF666E8A),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          _ResidentCartHub.addProduct(item, qty: 1);
                          _showFeature(context, '${item.title} added to cart.');
                          setState(() {});
                        },
                        child: Ink(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EEFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 17,
                            color: Color(0xFF3C54C5),
                          ),
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
}

class _ResidentProductPreviewPage extends StatefulWidget {
  final _ResidentProductData item;
  const _ResidentProductPreviewPage({required this.item});

  @override
  State<_ResidentProductPreviewPage> createState() =>
      _ResidentProductPreviewPageState();
}

class _ResidentProductPreviewPageState
    extends State<_ResidentProductPreviewPage> {
  int _quantity = 1;

  String _currency(double amount) => 'PHP ${amount.toStringAsFixed(2)}';

  void _addToCart({bool openCart = false}) {
    _ResidentCartHub.addProduct(widget.item, qty: _quantity);
    _showFeature(context, '$_quantity x ${widget.item.title} added to cart.');
    if (openCart) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ResidentCartPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final subtotal = item.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Preview'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResidentCartPage()),
            ),
            icon: const Icon(Icons.shopping_cart_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 230,
                  child: Image.asset(
                    item.imageAsset,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      child: Icon(
                        item.icon,
                        size: 72,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.eta,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE4E8F3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2D3046),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      _currency(item.price),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2E35D3),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (item.originalPrice != null)
                      Text(
                        _currency(item.originalPrice!),
                        style: const TextStyle(
                          color: Color(0xFF8187A1),
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _previewTag(
                      icon: Icons.star_rounded,
                      text: '${item.rating} (${item.reviews} reviews)',
                      color: const Color(0xFFF2A93B),
                    ),
                    _previewTag(
                      icon: Icons.inventory_2_rounded,
                      text: '${item.stock} in stock',
                      color: const Color(0xFF3E66C7),
                    ),
                    _previewTag(
                      icon: Icons.local_fire_department_rounded,
                      text: '${item.sold} sold',
                      color: const Color(0xFF4A54B8),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: const TextStyle(
                    color: Color(0xFF5A607D),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFDDE3F3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.storefront_rounded,
                        color: Color(0xFF4C57BB),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sold by ${item.seller}',
                          style: const TextStyle(
                            color: Color(0xFF2F344E),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      if (item.verified)
                        const Icon(
                          Icons.verified_rounded,
                          size: 18,
                          color: Color(0xFF3A7BE5),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFDDE2F2)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline_rounded),
                        visualDensity: VisualDensity.compact,
                      ),
                      Expanded(
                        child: Text(
                          '$_quantity',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _quantity < item.stock
                            ? () => setState(() => _quantity++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentChatSellerPage(),
                    ),
                  ),
                  child: const Text('Chat'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _previewBillRow('Item price', _currency(item.price)),
          _previewBillRow('Quantity', 'x$_quantity'),
          _previewBillRow('Subtotal', _currency(subtotal), bold: true),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _addToCart(),
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  label: const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: () => _addToCart(openCart: true),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2E35D3),
                  ),
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _previewTag({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewBillRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: bold ? const Color(0xFF2E3046) : const Color(0xFF666D88),
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: bold ? const Color(0xFF2E35D3) : const Color(0xFF4C5370),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class ResidentChatSellerPage extends StatelessWidget {
  const ResidentChatSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Seller')),
      body: Column(
        children: const [
          Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(hintText: 'Type a message...'),
            ),
          ),
        ],
      ),
    );
  }
}

class ResidentAddToCartDonePage extends StatelessWidget {
  const ResidentAddToCartDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.check_circle, color: Color(0xFF2E35D3), size: 86),
            const SizedBox(height: 10),
            const Text(
              'Success!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const Text('Your order has been added to cart.'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ResidentCartPage()),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2E35D3),
                ),
                child: const Text('Go to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentSellHubPage extends StatefulWidget {
  final int initialTab;
  const ResidentSellHubPage({super.key, this.initialTab = 0});

  @override
  State<ResidentSellHubPage> createState() => _ResidentSellHubPageState();
}

class _ResidentSellHubPageState extends State<ResidentSellHubPage> {
  int selected = 0;

  @override
  void initState() {
    super.initState();
    selected = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = const ['Commercial', 'Government'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Your Products'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F8FF), Color(0xFFF8F1F1)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: selected == 1
                      ? const [Color(0xFF3444B9), Color(0xFF6272E4)]
                      : const [Color(0xFF3650D3), Color(0xFF5E7CF7)],
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
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white.withValues(alpha: 0.24),
                    ),
                    child: Icon(
                      selected == 1
                          ? Icons.account_balance_rounded
                          : Icons.storefront_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selected == 1
                              ? 'Government Selling Portal'
                              : 'Commercial Seller Workspace',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          selected == 1
                              ? 'Register and manage GovProcure submissions.'
                              : 'Manage inventory, products, and local buyers.',
                          style: const TextStyle(
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCDD6F6)),
              ),
              child: SegmentedButton<int>(
                showSelectedIcon: true,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Color(0xFFE7ECFF);
                    }
                    return Colors.white;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Color(0xFF3243B5);
                    }
                    return const Color(0xFF5C637F);
                  }),
                  side: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const BorderSide(color: Color(0xFFBDC9F8));
                    }
                    return const BorderSide(color: Color(0xFFD8DDF1));
                  }),
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
                segments: List.generate(
                  tabs.length,
                  (i) => ButtonSegment<int>(value: i, label: Text(tabs[i])),
                ),
                selected: {selected},
                onSelectionChanged: (v) => setState(() => selected = v.first),
              ),
            ),
            const SizedBox(height: 12),
            if (selected == 0) const ResidentCommercialPage(),
            if (selected == 1) const ResidentGovSellPage(),
          ],
        ),
      ),
    );
  }
}

class ResidentCommercialPage extends StatelessWidget {
  const ResidentCommercialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Card(
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Shamira Balandra'),
            subtitle: Text('Commercial Seller'),
          ),
        ),
        Card(
          color: const Color(0xFFF2F1FF),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                const Icon(
                  Icons.verified_user,
                  color: Color(0xFF2E35D3),
                  size: 64,
                ),
                const SizedBox(height: 8),
                const Text(
                  'RBI Verification Required',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'To sell commercially, complete and wait for your RBI verification to be approved by an admin.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResidentVerifyProfilePage(),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2E35D3),
                    ),
                    child: const Text('GET VERIFIED NOW'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('My Products'),
          trailing: TextButton(
            onPressed: () => _showFeature(context, 'No products yet'),
            child: const Text('View All'),
          ),
        ),
        const Card(
          child: SizedBox(
            height: 120,
            child: Center(child: Text('No Products Yet')),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ResidentCommercialAddProductPage(),
              ),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF2E35D3),
            ),
            child: const Text('Add New Product'),
          ),
        ),
      ],
    );
  }
}

class ResidentCommercialAddProductPage extends StatefulWidget {
  const ResidentCommercialAddProductPage({super.key});

  @override
  State<ResidentCommercialAddProductPage> createState() =>
      _ResidentCommercialAddProductPageState();
}

class _ResidentCommercialAddProductPageState
    extends State<ResidentCommercialAddProductPage> {
  int step = 0;
  final steps = const [
    'Basic Details',
    'Price and Quantity',
    'Shipping',
    'Optional',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          LinearProgressIndicator(
            value: (step + 1) / steps.length,
            color: Colors.green,
          ),
          const SizedBox(height: 10),
          Text(
            steps[step],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ..._fieldsForStep(step),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: FilledButton(
          onPressed: () {
            if (step < steps.length - 1) {
              setState(() => step++);
              return;
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ResidentCommercialSavedPage(),
              ),
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF2E35D3),
          ),
          child: Text(step == steps.length - 1 ? 'Finish' : 'Save and Next'),
        ),
      ),
    );
  }

  List<Widget> _fieldsForStep(int step) {
    if (step == 0) {
      return const [
        TextField(decoration: InputDecoration(labelText: 'Product image')),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Product name')),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Product category')),
        SizedBox(height: 8),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(labelText: 'Product description'),
        ),
      ];
    }
    if (step == 1) {
      return const [
        TextField(decoration: InputDecoration(labelText: 'Selling price')),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Original price')),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Product stock')),
      ];
    }
    if (step == 2) {
      return const [
        TextField(decoration: InputDecoration(labelText: 'Coverage')),
        SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Delivery option')),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(labelText: 'Delivery details and fees'),
        ),
      ];
    }
    return const [
      TextField(decoration: InputDecoration(labelText: 'Product sizes')),
      SizedBox(height: 8),
      TextField(decoration: InputDecoration(labelText: 'Weight')),
      SizedBox(height: 8),
      TextField(decoration: InputDecoration(labelText: 'Dimensions')),
    ];
  }
}

class ResidentCommercialSavedPage extends StatelessWidget {
  const ResidentCommercialSavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.check_circle, color: Color(0xFF2E35D3), size: 86),
            const SizedBox(height: 10),
            const Text(
              'Success',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const Text('Your product has been saved to your inventory.'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2E35D3),
                ),
                child: const Text('View My Inventory'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentGovSellPage extends StatelessWidget {
  const ResidentGovSellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _ResidentGovProcureHub.refresh,
      builder: (_, __, ___) {
        final count = _ResidentGovProcureHub.submissions.length;
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE1E5F5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _govMetric(
                      icon: Icons.folder_copy_rounded,
                      label: 'Required Docs',
                      value: '5',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _govMetric(
                      icon: Icons.pending_actions_rounded,
                      label: 'Submitted',
                      value: '$count',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _govMetric(
                      icon: Icons.schedule_rounded,
                      label: 'Review Time',
                      value: '2-5 days',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _govActionCard(
              context,
              icon: Icons.notifications_active_rounded,
              title: 'Eligibility Requirements',
              subtitle:
                  'Review document checklist and compliance before registration.',
              stepLabel: 'Step 1',
              accent: const Color(0xFF3B4EC1),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ResidentGovRegistrationNoticePage(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _govActionCard(
              context,
              icon: Icons.assignment_rounded,
              title: 'Business Registration',
              subtitle: count == 0
                  ? 'My Submissions and GovProcure form'
                  : '$count submission(s) tracked in My Submissions',
              stepLabel: 'Step 2',
              accent: const Color(0xFF3B4EC1),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ResidentGovRegistrationPage(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _govMetric({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF8FAFF),
        border: Border.all(color: const Color(0xFFE2E6F4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF4051C8), size: 20),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF2D3350),
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF66708A),
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _govActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String stepLabel,
    required Color accent,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E5F3)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 8,
                offset: Offset(0, 3),
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
                  color: accent.withValues(alpha: 0.12),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Color(0xFF2E334A),
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF0FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            stepLabel,
                            style: TextStyle(
                              color: accent,
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF65708A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF6D7694)),
            ],
          ),
        ),
      ),
    );
  }
}

class ResidentGovRegistrationPage extends StatelessWidget {
  const ResidentGovRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Submissions'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _ResidentGovProcureHub.refresh,
        builder: (_, __, ___) {
          final items = _ResidentGovProcureHub.submissions;
          return Column(
            children: [
              Expanded(
                child: items.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.hourglass_empty_rounded,
                              size: 44,
                              color: Color(0xFF4252C7),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'No Applications yet',
                              style: TextStyle(
                                color: Color(0xFF2F344B),
                                fontWeight: FontWeight.w700,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        itemCount: items.length,
                        itemBuilder: (_, i) {
                          final item = items[i];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE4E7F3),
                              ),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xFFE8ECFF),
                                ),
                                child: const Icon(
                                  Icons.assignment_turned_in_rounded,
                                  color: Color(0xFF3F50C5),
                                ),
                              ),
                              title: Text(
                                item.companyName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2F344A),
                                ),
                              ),
                              subtitle: Text(
                                '${item.referenceNo} | ${item.submittedDate} | ${item.status}',
                                style: const TextStyle(
                                  color: Color(0xFF66708A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: const Icon(Icons.chevron_right_rounded),
                              onTap: () => _showFeature(
                                context,
                                'Opening ${item.referenceNo} details',
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResidentGovFormPage(),
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2E35D3),
                        ),
                        child: const Text('Submit application'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResidentHomeShell(),
                          ),
                          (route) => false,
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2E35D3),
                        ),
                        child: const Text('Return to Home'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: items.isEmpty
                            ? null
                            : () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ResidentSellHubPage(initialTab: 0),
                                ),
                              ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2E35D3),
                        ),
                        child: const Text('Go to Seller Dashboard'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ResidentGovFormPage extends StatefulWidget {
  const ResidentGovFormPage({super.key});

  @override
  State<ResidentGovFormPage> createState() => _ResidentGovFormPageState();
}

class _ResidentGovFormPageState extends State<ResidentGovFormPage> {
  final _companyController = TextEditingController(text: 'Apple Inc.');
  final _emailController = TextEditingController(text: 'apple@email.com');
  final _mobileController = TextEditingController(text: '91200011234');
  final _landlineController = TextEditingController(text: '02-1234-5678');
  final _addressController = TextEditingController();
  final _ownerController = TextEditingController(text: 'Shamira Balandra');
  final _tinController = TextEditingController(text: '123-456-789-000');
  bool _logoAttached = false;

  @override
  void dispose() {
    _companyController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _landlineController.dispose();
    _addressController.dispose();
    _ownerController.dispose();
    _tinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GovProcure - Registration'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'Company Details',
            style: TextStyle(
              color: Color(0xFF2E334A),
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _companyController,
            decoration: const InputDecoration(labelText: 'Company Name'),
          ),
          SizedBox(height: 8),
          const Text(
            'Logo',
            style: TextStyle(
              color: Color(0xFF2F344A),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _logoAttached = !_logoAttached),
            child: Container(
              height: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC7CFF5)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _logoAttached
                          ? Icons.check_circle_rounded
                          : Icons.add_photo_alternate_rounded,
                      color: _logoAttached
                          ? const Color(0xFF35A46E)
                          : const Color(0xFF7A83A7),
                      size: 34,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _logoAttached
                          ? 'Logo attached successfully'
                          : 'Upload an image (Max file size: 50 MB)',
                      style: const TextStyle(
                        color: Color(0xFF6A718B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email Address'),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _mobileController,
            decoration: const InputDecoration(
              labelText: 'Contact Number (Mobile)',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _landlineController,
            decoration: const InputDecoration(
              labelText: 'Contact Number (Landline)',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _addressController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Business Address'),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _ownerController,
            decoration: const InputDecoration(
              labelText: 'Authorized Representative',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _tinController,
            decoration: const InputDecoration(labelText: 'TIN Number'),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE3E6F3)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Requirements Checklist',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2F334A),
                  ),
                ),
                SizedBox(height: 6),
                _GovRegistrationChecklist(text: 'SEC / DTI Registration'),
                _GovRegistrationChecklist(text: 'Mayor\'s Permit'),
                _GovRegistrationChecklist(text: 'Tax Clearance (BIR)'),
                _GovRegistrationChecklist(text: 'PhilGEPS Registration'),
                _GovRegistrationChecklist(text: 'Omnibus Sworn Statement'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: FilledButton(
          onPressed: () {
            final company = _companyController.text.trim();
            final email = _emailController.text.trim();
            final mobile = _mobileController.text.trim();
            final address = _addressController.text.trim();
            if (company.isEmpty ||
                email.isEmpty ||
                mobile.length < 10 ||
                address.length < 8) {
              _showFeature(
                context,
                'Please complete company, contact, and address details.',
              );
              return;
            }
            _ResidentGovProcureHub.addSubmission(
              companyName: company,
              email: email,
              mobile: mobile,
              landline: _landlineController.text.trim(),
              address: address,
            );
            Navigator.pop(context);
            _showFeature(context, 'Gov registration submitted for review.');
          },
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF2E35D3),
          ),
          child: const Text('Submit Registration'),
        ),
      ),
    );
  }
}

class ResidentGovRegistrationNoticePage extends StatelessWidget {
  const ResidentGovRegistrationNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchants Profile'),
        backgroundColor: const Color(0xFF2D36A8),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F6FF), Color(0xFFF0ECFF)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE0E4F5)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 106,
                    height: 106,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFDCE2FF), Color(0xFFEEF1FF)],
                      ),
                    ),
                    child: const Icon(
                      Icons.assignment_turned_in_rounded,
                      color: Color(0xFF3C4DC1),
                      size: 62,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Eligibility Requirements',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2D3350),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'To sell to the government, submit required business documents for compliance checking. Approval is required before bidding.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF666F8B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResidentGovRegistrationPage(),
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF2E35D3),
                      ),
                      child: const Text('Go to Registration Page'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResidentSellGovInfoPage(),
                        ),
                      ),
                      child: const Text('View Sell to Government Info'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResidentGovProcureHub {
  static final ValueNotifier<int> refresh = ValueNotifier<int>(0);
  static final List<_GovRegistrationSubmission> submissions = [];

  static void addSubmission({
    required String companyName,
    required String email,
    required String mobile,
    required String landline,
    required String address,
  }) {
    final ref = 'GOV-${DateTime.now().millisecondsSinceEpoch % 1000000}';
    submissions.insert(
      0,
      _GovRegistrationSubmission(
        referenceNo: ref,
        companyName: companyName,
        email: email,
        mobile: mobile,
        landline: landline,
        address: address,
        status: 'Under Review',
        submittedDate:
            '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
      ),
    );
    refresh.value++;
  }
}

class _GovRegistrationSubmission {
  final String referenceNo;
  final String companyName;
  final String email;
  final String mobile;
  final String landline;
  final String address;
  final String status;
  final String submittedDate;

  const _GovRegistrationSubmission({
    required this.referenceNo,
    required this.companyName,
    required this.email,
    required this.mobile,
    required this.landline,
    required this.address,
    required this.status,
    required this.submittedDate,
  });
}

class _GovRegistrationChecklist extends StatelessWidget {
  final String text;
  const _GovRegistrationChecklist({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 17,
            color: Color(0xFF3C4EC1),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF4A516D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResidentSellGovInfoPage extends StatelessWidget {
  const ResidentSellGovInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell to Gov Information'),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3343B2), Color(0xFF6574E2)],
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
                          'Sell your products to the government',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'BarangayMo helps local entrepreneurs enter government procurement opportunities.',
                          style: TextStyle(color: Color(0xFFDCE1FF)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.account_balance, color: Colors.white),
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
                border: Border.all(color: const Color(0xFFE5E8F5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.folder_copy, color: Color(0xFF3E4CC4)),
                      SizedBox(width: 8),
                      Text(
                        'Required Documents',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2D3044),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _GovBullet(text: 'PhilGEPS Registration'),
                  _GovBullet(text: 'Valid Business Permit'),
                  _GovBullet(text: 'NFCC / Financial Capacity'),
                  _GovBullet(text: 'Latest Tax Clearance'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE5E8F5)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.alt_route, color: Color(0xFF3E4CC4)),
                      SizedBox(width: 8),
                      Text(
                        'Application Process',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2D3044),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _GovStep(
                    number: 1,
                    title: 'Registration',
                    subtitle: 'Create and verify your seller account.',
                  ),
                  _GovStep(
                    number: 2,
                    title: 'Submission',
                    subtitle: 'Submit required documents and product details.',
                  ),
                  _GovStep(
                    number: 3,
                    title: 'Verification',
                    subtitle: 'Compliance and eligibility checks by LGU.',
                  ),
                  _GovStep(
                    number: 4,
                    title: 'Approval',
                    subtitle: 'Receive notice and start bid participation.',
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

class _GovBullet extends StatelessWidget {
  final String text;
  const _GovBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF3FA96D), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF3A3D54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GovStep extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  const _GovStep({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: const Color(0xFFE4E8FF),
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF3946B3),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2E3146),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF646A86),
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
