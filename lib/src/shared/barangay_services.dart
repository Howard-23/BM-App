part of barangaymo_app;

class ResponderPage extends StatelessWidget {
  const ResponderPage({super.key});

  @override
  Widget build(BuildContext context) {
    const contacts = [
      (
        'BPAT',
        '0917-800-1001',
        'Barangay patrol and neighborhood security response',
      ),
      ('Police', '117', 'PNP rapid response and incident dispatch'),
      ('Fire Department', '160', 'BFP fire suppression and rescue'),
      ('Ambulance', '911', 'Emergency medical support and patient transport'),
    ];
    const emergencyTips = [
      (
        'How to Use a Fire Extinguisher',
        'Learn to operate a fire extinguisher',
        Icons.fire_extinguisher,
      ),
      (
        'Basic First Aid',
        'Essential first aid steps',
        Icons.medical_services_outlined,
      ),
    ];
    const safetyTips = [
      ('Earthquake Safety', 'Drop, cover, and hold', Icons.crisis_alert),
      ('Flood Safety', 'Move to higher ground', Icons.flood),
      (
        'Fire Safety',
        'Exit early and avoid smoke',
        Icons.local_fire_department,
      ),
    ];
    const responderCenter = LatLng(14.8386, 120.2865);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Barangay Emergency'),
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
          padding: const EdgeInsets.all(12),
          children: [
            _sectionTitle('Emergency Contacts'),
            ...contacts.map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7F3)),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EBEC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF5D4C52),
                    ),
                  ),
                  title: Text(
                    e.$1,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    '${e.$2} | ${e.$3}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xFF6A6E84)),
                  ),
                  trailing: FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EmergencyContactActionPage(
                          contactName: e.$1,
                          phoneNumber: e.$2,
                          description: e.$3,
                        ),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF7C818C),
                    ),
                    child: const Text('Call'),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EmergencyContactActionPage(
                        contactName: e.$1,
                        phoneNumber: e.$2,
                        description: e.$3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _sectionTitle('Quick Actions'),
            _goTile(
              context,
              'Share Live Location',
              const EmergencyLocationSharePage(),
            ),
            _goTile(
              context,
              'Emergency Hotlines',
              const EmergencyHotlinesPage(),
            ),
            _goTile(context, 'Message Barangay', const EmergencyMessagePage()),

            _sectionTitle('Emergency Tips'),
            ...emergencyTips.map(
              (tip) => _EmergencyInfoTile(
                icon: tip.$3,
                title: tip.$1,
                subtitle: tip.$2,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EmergencySafetyDetailPage(
                      title: tip.$1,
                      summary: tip.$2,
                      guide: tip.$1 == 'How to Use a Fire Extinguisher'
                          ? const [
                              'Pull the pin and point the nozzle at the base of the fire.',
                              'Squeeze the handle and sweep side-to-side.',
                              'Keep a safe distance and call emergency responders.',
                            ]
                          : const [
                              'Check scene safety before giving aid.',
                              'Control bleeding with direct pressure and clean cloth.',
                              'Keep patient calm while waiting for medical response.',
                            ],
                    ),
                  ),
                ),
              ),
            ),

            _sectionTitle('Safety Tips'),
            ...safetyTips.map(
              (tip) => _EmergencyInfoTile(
                icon: tip.$3,
                title: tip.$1,
                subtitle: tip.$2,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EmergencySafetyDetailPage(
                      title: tip.$1,
                      summary: tip.$2,
                      guide: tip.$1 == 'Earthquake Safety'
                          ? const [
                              'Drop to your hands and knees immediately.',
                              'Cover your head and neck under sturdy furniture.',
                              'Hold on until shaking stops, then evacuate safely.',
                            ]
                          : tip.$1 == 'Flood Safety'
                          ? const [
                              'Move to higher ground immediately.',
                              'Avoid crossing flowing water by foot or vehicle.',
                              'Turn off electricity if floodwater reaches outlets.',
                            ]
                          : const [
                              'Stay low to avoid smoke inhalation.',
                              'Use nearest safe exit and avoid elevators.',
                              'Call emergency responders once outside.',
                            ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE4E7F3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More Information',
                    style: TextStyle(
                      color: Color(0xFF2F3248),
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sa oras ng sakuna, mahalaga ang manatiling kalmado at sundin ang '
                    'mga tagubilin ng lokal na awtoridad. Siguraduhin may first aid kit, '
                    'emergency contacts, at evacuation plan para sa buong pamilya.',
                    style: TextStyle(
                      color: Color(0xFF565D77),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE4E7F3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.route_outlined),
                          title: Text('Evacuation Routes'),
                        ),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EmergencyLeafletMapPage(
                              showShelters: false,
                            ),
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFB11E1E),
                        ),
                        child: const Text('View'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Expanded(
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.home_work_outlined),
                          title: Text('Emergency Shelters'),
                        ),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EmergencyLeafletMapPage(
                              showShelters: true,
                            ),
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFB11E1E),
                        ),
                        child: const Text('View'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            _sectionTitle('Map'),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const _FullscreenMapPage(
                      title: 'Responder Map',
                      initialCenter: responderCenter,
                      initialZoom: 16,
                      pins: [
                        _MapPin(
                          point: responderCenter,
                          icon: Icons.location_on,
                          color: Color(0xFFB11E1E),
                          label: 'Barangay Emergency Response Point',
                        ),
                      ],
                    ),
                  ),
                ),
                icon: const Icon(Icons.fullscreen),
                label: const Text('Full View'),
              ),
            ),
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: responderCenter,
                    initialZoom: 14.4,
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
                          point: responderCenter,
                          width: 44,
                          height: 44,
                          child: Icon(
                            Icons.location_on,
                            color: Color(0xFFB11E1E),
                            size: 38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            _sectionTitle('Medical Info'),
            const MedicalInfoAccordions(),
          ],
        ),
      ),
    );
  }
}

class _MapPin {
  final LatLng point;
  final IconData icon;
  final Color color;
  final String label;

  const _MapPin({
    required this.point,
    required this.icon,
    required this.color,
    required this.label,
  });
}

class _FullscreenMapPage extends StatelessWidget {
  final String title;
  final LatLng initialCenter;
  final double initialZoom;
  final List<_MapPin> pins;

  const _FullscreenMapPage({
    required this.title,
    required this.initialCenter,
    required this.initialZoom,
    required this.pins,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: initialZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.barangaymo_app',
              ),
              MarkerLayer(
                markers: pins
                    .map(
                      (pin) => Marker(
                        point: pin.point,
                        width: 46,
                        height: 46,
                        child: Icon(pin.icon, color: pin.color, size: 36),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          if (pins.isNotEmpty)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE4E7F3)),
                ),
                child: Text(
                  pins.map((pin) => pin.label).join(' | '),
                  style: const TextStyle(
                    color: Color(0xFF2F3248),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmergencyInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _EmergencyInfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7F3)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F2F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF6A6F86)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF2F3248),
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF6A6E84),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFFB11E1E)),
        onTap: onTap,
      ),
    );
  }
}

class EmergencySafetyDetailPage extends StatelessWidget {
  final String title;
  final String summary;
  final List<String> guide;
  const EmergencySafetyDetailPage({
    super.key,
    required this.title,
    required this.summary,
    required this.guide,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE4E7F3)),
            ),
            child: Text(
              summary,
              style: const TextStyle(
                color: Color(0xFF4F5672),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...guide.map(
            (step) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE4E7F3)),
              ),
              child: ListTile(
                dense: true,
                leading: const Icon(Icons.check_circle_outline),
                title: Text(
                  step,
                  style: const TextStyle(
                    color: Color(0xFF2F3248),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencyLeafletMapPage extends StatelessWidget {
  final bool showShelters;
  const EmergencyLeafletMapPage({super.key, required this.showShelters});

  @override
  Widget build(BuildContext context) {
    final title = showShelters ? 'Emergency Shelters' : 'Evacuation Routes';
    final markers = showShelters
        ? const [
            (
              LatLng(14.8391, 120.2860),
              Icons.home_work_rounded,
              'West Tapinac Gym Shelter',
            ),
            (
              LatLng(14.8379, 120.2877),
              Icons.school_rounded,
              'Old Cabalan School Shelter',
            ),
          ]
        : const [
            (
              LatLng(14.8382, 120.2856),
              Icons.alt_route_rounded,
              'Route A - Church Road',
            ),
            (
              LatLng(14.8390, 120.2872),
              Icons.alt_route_rounded,
              'Route B - Highway Exit',
            ),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(14.8386, 120.2865),
                initialZoom: 14.6,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.barangaymo_app',
                ),
                MarkerLayer(
                  markers: markers
                      .map(
                        (item) => Marker(
                          point: item.$1,
                          width: 48,
                          height: 48,
                          child: Icon(
                            item.$2,
                            color: const Color(0xFFB11E1E),
                            size: 36,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE5E7F3))),
            ),
            child: Column(
              children: markers
                  .map(
                    (item) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.place_outlined),
                      title: Text(item.$3),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicalInfoAccordions extends StatelessWidget {
  const MedicalInfoAccordions({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      (
        'How to perform CPR',
        'Check scene safety, call emergency services, begin chest compressions, and give rescue breaths if trained.',
      ),
      (
        'How to deal with choking',
        'For severe choking, perform back blows and abdominal thrusts. Call emergency services immediately.',
      ),
      (
        'How to treat burns',
        'Cool the burn under clean water for 10-20 minutes, avoid ice, and cover with sterile cloth.',
      ),
      (
        'How to handle fractures',
        'Immobilize the injured area, avoid moving the limb, and seek urgent medical care.',
      ),
      (
        'How to stop bleeding',
        'Apply direct pressure with clean cloth and elevate wound if possible.',
      ),
    ];
    return Column(
      children: items
          .map(
            (e) => Card(
              child: ExpansionTile(
                title: Text(e.$1),
                children: [
                  Padding(padding: const EdgeInsets.all(12), child: Text(e.$2)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class EmergencyHotlinesPage extends StatelessWidget {
  const EmergencyHotlinesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
      ('Actionline Against Human Trafficking', '1343'),
      ('PDEA', '(02) 8929-6672'),
      ('Bantay Bata 163', '163'),
      ('Lifeline Ambulance Rescue', '16-911'),
      ('DSWD', '(02) 8931-8101'),
      ('Philippine Coast Guard', '(02) 8527-8481'),
      ('MMDA', '(02) 8822-4151'),
      ('DOH', '(02) 8942-6843'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Hotlines'),
        backgroundColor: const Color(0xFFD70000),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: data
            .map(
              (e) => Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.local_phone)),
                  title: Text(e.$1),
                  subtitle: Text(e.$2),
                  trailing: const Icon(Icons.phone),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ScanQrPage extends StatelessWidget {
  const ScanQrPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR ID Scanner'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF3F7FF), Color(0xFFF8F1ED)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF082A46), Color(0xFF021728)],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33042A49),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 26,
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 210,
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.24),
                          ),
                        ),
                        child: Stack(
                          children: const [
                            _QrCorner(top: true, left: true),
                            _QrCorner(top: true, left: false),
                            _QrCorner(top: false, left: true),
                            _QrCorner(top: false, left: false),
                            Center(
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                size: 84,
                                color: Color(0xFFE3E9F8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE3E7F4)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.qr_code_2_rounded, color: Color(0xFFD74637)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scan Resident Barangay ID',
                          style: TextStyle(
                            color: Color(0xFF2F334A),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Position the ID within the frame for scanning',
                          style: TextStyle(
                            color: Color(0xFF646C88),
                            fontWeight: FontWeight.w600,
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

class _QrCorner extends StatelessWidget {
  final bool top;
  final bool left;
  const _QrCorner({required this.top, required this.left});

  @override
  Widget build(BuildContext context) {
    const cornerSize = 38.0;
    return Positioned(
      top: top ? 10 : null,
      bottom: top ? null : 10,
      left: left ? 10 : null,
      right: left ? null : 10,
      child: Container(
        width: cornerSize,
        height: cornerSize,
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? const BorderSide(color: Color(0xFFE0E8FF), width: 5)
                : BorderSide.none,
            bottom: top
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFE0E8FF), width: 5),
            left: left
                ? const BorderSide(color: Color(0xFFE0E8FF), width: 5)
                : BorderSide.none,
            right: left
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFE0E8FF), width: 5),
          ),
        ),
      ),
    );
  }
}

class AssistancePage extends StatelessWidget {
  const AssistancePage({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      (
        'Burial Assistance',
        'Funeral aid and urgent family support',
        Icons.volunteer_activism,
        Color(0xFFFFE2D8),
      ),
      (
        'Educational Assistance',
        'School supplies, tuition and scholarship referrals',
        Icons.school,
        Color(0xFFDDE6FF),
      ),
      (
        'Financial Assistance',
        'Emergency cash support for qualified residents',
        Icons.account_balance_wallet,
        Color(0xFFE0F3E8),
      ),
      (
        'Medical Assistance',
        'Hospital endorsement and treatment support',
        Icons.local_hospital,
        Color(0xFFFFE6E2),
      ),
      (
        'Medicine Assistance',
        'Prescription medicine access and subsidy',
        Icons.medication,
        Color(0xFFE7EEFF),
      ),
      (
        'Sponsorship Assistance',
        'Program and event sponsorship endorsements',
        Icons.card_giftcard,
        Color(0xFFFFE9D9),
      ),
      (
        'Venue Assistance',
        'Barangay venue usage and reservation support',
        Icons.location_city,
        Color(0xFFE7F1FF),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistance'),
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
                  colors: [Color(0xFFD94646), Color(0xFFEF6767)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29D74637),
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
                          'What type of assistance do you need?',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Select a program to start your request and review eligibility requirements.',
                          style: TextStyle(color: Color(0xFFFFDFDF)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.handshake_outlined, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: const Color(0xFFE6E8F4)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: e.$4,
                    ),
                    child: Icon(e.$3, color: const Color(0xFF4A4F6A)),
                  ),
                  title: Text(
                    e.$1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3248),
                    ),
                  ),
                  subtitle: Text(
                    e.$2,
                    style: const TextStyle(
                      color: Color(0xFF686C86),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AssistanceRequestPage(
                        assistanceType: e.$1,
                        assistanceDescription: e.$2,
                        assistanceIcon: e.$3,
                        accentColor: e.$4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BpatPage extends StatelessWidget {
  const BpatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BPAT Assistance'),
          backgroundColor: const Color(0xFFF7F8FF),
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              color: const Color(0xFFE6DBDB),
              borderRadius: BorderRadius.circular(999),
            ),
            dividerColor: const Color(0xFFDDCFCF),
            labelColor: const Color(0xFF8E4E45),
            unselectedLabelColor: const Color(0xFF5F647D),
            labelStyle: const TextStyle(fontWeight: FontWeight.w800),
            tabs: const [
              Tab(text: 'Call'),
              Tab(text: 'Blotter'),
              Tab(text: 'Records'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF6F8FF), Color(0xFFF9F1ED)],
            ),
          ),
          child: TabBarView(
            children: [
              ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF8E4E45), Color(0xFFB86B5E)],
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Barangay Peace & Security',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Fast contact for patrol requests, blotter lookup, and incident records.',
                                style: TextStyle(
                                  color: Color(0xFFFFE2DC),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Color(0x33FFFFFF),
                          child: Icon(
                            Icons.shield_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _bpatAction(
                    context: context,
                    title: 'Call BPAT Emergency Line',
                    subtitle: 'Direct access to available patrol team.',
                    icon: Icons.call_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SimpleSerbilisPage(title: 'Call BPAT'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _bpatAction(
                    context: context,
                    title: 'Report an Incident',
                    subtitle:
                        'Submit report details for validation and response.',
                    icon: Icons.report_gmailerrorred_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BpatReportPage()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _bpatAction(
                    context: context,
                    title: 'Request Patrol',
                    subtitle: 'Schedule area monitoring for your location.',
                    icon: Icons.directions_walk_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BpatPatrolPage()),
                    ),
                  ),
                ],
              ),
              const BpatBlotterPage(),
              const BpatRecordsPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bpatAction({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE3E7F4)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF4E8E5),
                ),
                child: Icon(icon, color: const Color(0xFF8E4E45)),
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
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF8E4E45)),
            ],
          ),
        ),
      ),
    );
  }
}

class BpatReportPage extends StatelessWidget {
  const BpatReportPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Incident Report')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          TextField(decoration: InputDecoration(labelText: 'Report Type')),
          SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Time of Incident')),
          SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Location')),
          SizedBox(height: 8),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Person Involved')),
          SizedBox(height: 8),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(labelText: 'Action Taken'),
          ),
          SizedBox(height: 8),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(labelText: 'Further Action Needed'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: FilledButton(
          onPressed: () => _showFeature(context, 'Incident report submitted.'),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFD70000),
          ),
          child: const Text('SUBMIT REPORT'),
        ),
      ),
    );
  }
}

class BpatPatrolPage extends StatelessWidget {
  const BpatPatrolPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Patrol')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          TextField(
            decoration: InputDecoration(labelText: 'Location for Patrol'),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'Reason for Patrol Request'),
          ),
          SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Preferred Time')),
          SizedBox(height: 8),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Additional Comments'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: FilledButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => const AlertDialog(
              title: Text('Submitted'),
              content: Text('Your patrol request has been received.'),
            ),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFD70000),
          ),
          child: const Text('SUBMIT PATROL REQUEST'),
        ),
      ),
    );
  }
}

class BpatBlotterPage extends StatefulWidget {
  const BpatBlotterPage({super.key});

  @override
  State<BpatBlotterPage> createState() => _BpatBlotterPageState();
}

class _BpatBlotterPageState extends State<BpatBlotterPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    const data = [
      'csac avsv',
      'LOIDA LAXA HUSSEY',
      'ANGELO GREGG ELANE',
      'Lester Castro Nadong',
    ];
    final rows = data
        .where((name) => name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E6F2)),
          ),
          child: TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search blotter name or reference...',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (rows.isEmpty)
          const ListTile(
            leading: Icon(Icons.search_off_rounded),
            title: Text('No blotter matches found'),
          ),
        ...rows.map(
          (e) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.86),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E6F2)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              title: Text(
                e,
                style: const TextStyle(
                  color: Color(0xFF332F35),
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: const Text(
                'RBI-3-6-10',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
        ),
      ],
    );
  }
}

class BpatRecordsPage extends StatefulWidget {
  const BpatRecordsPage({super.key});

  @override
  State<BpatRecordsPage> createState() => _BpatRecordsPageState();
}

class _BpatRecordsPageState extends State<BpatRecordsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final records = List.generate(
      4,
      (i) => (title: 'IR-$i', date: '2/10/2025 5:38 AM'),
    );
    final rows = records
        .where(
          (item) =>
              item.title.toLowerCase().contains(_query.toLowerCase()) ||
              item.date.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E6F2)),
          ),
          child: TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search person involved, report ID...',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (rows.isEmpty)
          const ListTile(
            leading: Icon(Icons.search_off_rounded),
            title: Text('No incident records matched'),
          ),
        ...rows.map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.86),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E6F2)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(14, 6, 10, 6),
              title: Text(
                item.title,
                style: const TextStyle(
                  color: Color(0xFF332F35),
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                item.date,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SimpleSerbilisPage(
                      title: 'Incident Report Details',
                    ),
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFD70000),
                ),
                child: const Text('DETAILS'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClearancePage extends StatelessWidget {
  const ClearancePage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Documents'),
          backgroundColor: const Color(0xFFF7F8FF),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              color: const Color(0xFFDDE2FF),
              borderRadius: BorderRadius.circular(999),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: const Color(0xFF2D3150),
            unselectedLabelColor: const Color(0xFF737992),
            labelStyle: const TextStyle(fontWeight: FontWeight.w800),
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _DocList(status: 'Pending'),
            _DocList(status: 'Approved'),
            _DocList(status: 'Rejected'),
            _DocList(status: 'Completed'),
          ],
        ),
      ),
    );
  }
}

class _DocList extends StatefulWidget {
  final String status;
  const _DocList({required this.status});

  @override
  State<_DocList> createState() => _DocListState();
}

class _DocListState extends State<_DocList> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final documents = _documentsByStatus(widget.status);
    final accent = _statusColor(widget.status);
    final q = _query.trim().toLowerCase();
    final rows = documents.where((d) {
      final bag = '${d.title} ${d.subtitle} ${d.reference} ${d.detail}'
          .toLowerCase();
      return q.isEmpty || bag.contains(q);
    }).toList();

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
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent.withValues(alpha: 0.95),
                  accent.withValues(alpha: 0.75),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0x36FFFFFF),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(Icons.folder_copy, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.status} Documents',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        '${documents.length} requests | Avg turnaround ${_processingEta(widget.status)}',
                        style: const TextStyle(
                          color: Color(0xFFECEFFF),
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
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search by name, ID, purpose...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE3E6F4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE3E6F4)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (rows.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.search_off),
                title: Text('No matching documents'),
              ),
            )
          else
            ...rows.map(
              (d) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E7F3)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x11000000),
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
                        CircleAvatar(
                          backgroundColor: accent.withValues(alpha: 0.13),
                          child: Icon(d.icon, color: accent),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            d.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2D314A),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            widget.status,
                            style: TextStyle(
                              color: accent,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      d.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF555C77),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      d.detail,
                      style: const TextStyle(
                        color: Color(0xFF666B84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.confirmation_number_outlined,
                          size: 16,
                          color: Color(0xFF7A809A),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          d.reference,
                          style: const TextStyle(
                            color: Color(0xFF7A809A),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => _DocumentStatusDetailPage(
                                entry: d,
                                status: widget.status,
                                accent: accent,
                              ),
                            ),
                          ),
                          icon: Icon(
                            widget.status == 'Approved'
                                ? Icons.visibility
                                : widget.status == 'Completed'
                                ? Icons.download
                                : Icons.chevron_right,
                            color: accent,
                            size: 18,
                          ),
                          label: Text(
                            _statusAction(widget.status),
                            style: TextStyle(color: accent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<_DocEntry> _documentsByStatus(String status) {
    switch (status) {
      case 'Approved':
        return const [
          _DocEntry(
            title: 'Barangay Clearance',
            subtitle: 'Approved on Feb 18, 2026',
            detail: 'Purpose: Employment requirement',
            reference: 'BC-26-0218',
            icon: Icons.task_alt,
          ),
          _DocEntry(
            title: 'Certificate of Residency',
            subtitle: 'Approved on Feb 14, 2026',
            detail: 'Purpose: Scholarship application',
            reference: 'CR-26-0214',
            icon: Icons.home,
          ),
          _DocEntry(
            title: 'Business Endorsement',
            subtitle: 'Approved on Feb 10, 2026',
            detail: 'Purpose: Market stall permit',
            reference: 'BE-26-0210',
            icon: Icons.store,
          ),
        ];
      case 'Rejected':
        return const [
          _DocEntry(
            title: 'Medical Assistance Form',
            subtitle: 'Rejected on Feb 16, 2026',
            detail: 'Reason: Missing hospital abstract',
            reference: 'MA-26-0216',
            icon: Icons.local_hospital,
          ),
          _DocEntry(
            title: 'Scholarship Assistance',
            subtitle: 'Rejected on Feb 11, 2026',
            detail: 'Reason: Incomplete school attachments',
            reference: 'SA-26-0211',
            icon: Icons.school,
          ),
        ];
      case 'Completed':
        return const [
          _DocEntry(
            title: 'Barangay Clearance',
            subtitle: 'Completed and downloaded',
            detail: 'Released to resident on Feb 04, 2026',
            reference: 'BC-26-0204',
            icon: Icons.download_done,
          ),
          _DocEntry(
            title: 'Community Certificate',
            subtitle: 'Completed and released',
            detail: 'Released to resident on Jan 29, 2026',
            reference: 'CC-26-0129',
            icon: Icons.verified,
          ),
        ];
      case 'Pending':
      default:
        return const [
          _DocEntry(
            title: 'Barangay Clearance',
            subtitle: 'Pending verification of residency',
            detail: 'Submitted Feb 20, 2026',
            reference: 'BC-26-0220',
            icon: Icons.description,
          ),
          _DocEntry(
            title: 'Certificate of Indigency',
            subtitle: 'Queued for captain signature',
            detail: 'Submitted Feb 19, 2026',
            reference: 'CI-26-0219',
            icon: Icons.assignment_turned_in,
          ),
          _DocEntry(
            title: 'Medical Assistance Form',
            subtitle: 'Under social worker review',
            detail: 'Submitted Feb 18, 2026',
            reference: 'MA-26-0218',
            icon: Icons.health_and_safety,
          ),
        ];
    }
  }

  String _processingEta(String status) {
    switch (status) {
      case 'Approved':
        return '2 days';
      case 'Rejected':
        return '1 day';
      case 'Completed':
        return '0 day';
      case 'Pending':
      default:
        return '3 days';
    }
  }

  String _statusAction(String status) {
    switch (status) {
      case 'Approved':
        return 'View';
      case 'Completed':
        return 'Download';
      case 'Rejected':
        return 'Review';
      case 'Pending':
      default:
        return 'Track';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF2D8E55);
      case 'Rejected':
        return const Color(0xFFD74637);
      case 'Completed':
        return const Color(0xFF3650C4);
      case 'Pending':
      default:
        return const Color(0xFF7A5A43);
    }
  }
}

class _DocEntry {
  final String title;
  final String subtitle;
  final String detail;
  final String reference;
  final IconData icon;
  const _DocEntry({
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.reference,
    required this.icon,
  });
}

class CouncilPage extends StatelessWidget {
  const CouncilPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = const [
      (
        'DONALD ELAD AQUINO',
        'Sangguniang Barangay Member',
        'Committee on Peace and Order',
      ),
      (
        'LARRY DELA ROSA TOLEDO',
        'Sangguniang Barangay Member',
        'Committee on Infrastructure',
      ),
      (
        'RIGOR BILONO AVILANES',
        'Sangguniang Barangay Member',
        'Committee on Finance and Budget',
      ),
      (
        'ROBERTO TOGONON ANTONIO',
        'Sangguniang Barangay Member',
        'Committee on Social Services',
      ),
      (
        'WILFREDO FABABI MIRANDA',
        'Sangguniang Barangay Member',
        'Committee on Education and Youth',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Council'),
        backgroundColor: const Color(0xFF9F1A1A),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9F1A1A), Color(0xFFC92A2A)],
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
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF9F1A1A), Color(0xFFC92A2A)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.groups_2, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Council Directory and Committee Assignments',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...data.map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E7F3)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFEA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.person, color: Color(0xFF9F1A1A)),
                  ),
                  title: Text(
                    e.$1,
                    style: const TextStyle(
                      color: Color(0xFF2F3248),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.$2,
                        style: const TextStyle(
                          color: Color(0xFF676C86),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        e.$3,
                        style: const TextStyle(
                          color: Color(0xFF8A5A4A),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.edit, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB42121),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (_) => const _CouncilFormSheet(),
        ),
      ),
    );
  }
}

class _CouncilFormSheet extends StatelessWidget {
  const _CouncilFormSheet();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text(
              'Add Member of Council',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: 'First Name')),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'Middle Name')),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'Last Name')),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'Position')),
          ],
        ),
      ),
    );
  }
}

class DisclosureBoardPage extends StatefulWidget {
  const DisclosureBoardPage({super.key});

  @override
  State<DisclosureBoardPage> createState() => _DisclosureBoardPageState();
}

class _DisclosureBoardPageState extends State<DisclosureBoardPage> {
  final TextEditingController _searchController = TextEditingController();
  String _purposeFilter = 'All';
  String _statusFilter = 'All';
  String _selectedDate = '08/08/2025';
  String _aipView = 'AIP TABLE';

  static const _purposeOptions = [
    'All',
    'General Services',
    'MOOE',
    'Capital Outlay',
    'Social Services',
  ];

  static const _statusOptions = ['All', 'Released', 'Processing', 'Posted'];

  static const _sectors = [
    _DisbursementSector(
      title: 'General Services',
      available: 1899622.76,
      utilized: 2302268.50,
    ),
    _DisbursementSector(
      title: 'Maintenance and Other Operating Expenses (MOOE)',
      available: 150000.00,
      utilized: 62500.00,
    ),
    _DisbursementSector(
      title: 'Capital Outlay',
      available: 150000.00,
      utilized: 0.00,
    ),
    _DisbursementSector(
      title: 'Social Services',
      available: 720000.00,
      utilized: 1480000.00,
    ),
  ];

  static const _disclosureRows = [
    _DisclosureEntry(
      date: '9/26/2024',
      number: 'DBR-2024-085',
      purpose: 'General Services',
      status: 'Released',
    ),
    _DisclosureEntry(
      date: '9/27/2024',
      number: 'DBR-2024-084',
      purpose: 'MOOE',
      status: 'Released',
    ),
    _DisclosureEntry(
      date: '9/28/2024',
      number: 'DBR-2024-083',
      purpose: 'Capital Outlay',
      status: 'Posted',
    ),
    _DisclosureEntry(
      date: '9/29/2024',
      number: 'DBR-2024-082',
      purpose: 'Social Services',
      status: 'Processing',
    ),
    _DisclosureEntry(
      date: '9/30/2024',
      number: 'DBR-2024-081',
      purpose: 'General Services',
      status: 'Released',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _peso(double value) {
    final whole = value.floor();
    final decimal = ((value - whole) * 100).round().toString().padLeft(2, '0');
    final parts = whole.toString().split('').reversed.toList();
    final chunks = <String>[];
    for (var i = 0; i < parts.length; i += 3) {
      final end = (i + 3 < parts.length) ? i + 3 : parts.length;
      chunks.add(parts.sublist(i, end).join(''));
    }
    return '₱${chunks.map((e) => e.split('').reversed.join('')).toList().reversed.join(',')}.$decimal';
  }

  List<_DisclosureEntry> get _filteredRows {
    final q = _searchController.text.trim().toLowerCase();
    return _disclosureRows.where((row) {
      final byPurpose =
          _purposeFilter == 'All' || row.purpose == _purposeFilter;
      final byStatus = _statusFilter == 'All' || row.status == _statusFilter;
      final haystack = '${row.date} ${row.number} ${row.purpose} ${row.status}'
          .toLowerCase();
      final byQuery = q.isEmpty || haystack.contains(q);
      return byPurpose && byStatus && byQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Disbursement'),
          backgroundColor: const Color(0xFF9F1A1A),
          foregroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF9F1A1A), Color(0xFFC92A2A)],
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
              Tab(text: 'Disbursement'),
              Tab(text: 'Disclosure'),
              Tab(text: 'AIP'),
            ],
          ),
        ),
        body: TabBarView(
          children: [_disbursementTab(), _disclosureTab(), _aipTab()],
        ),
      ),
    );
  }

  Widget _disbursementTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F8FC), Color(0xFFF3ECEC)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE3E6F1)),
            ),
            child: Column(
              children: [
                const Text(
                  'Available Balance: ₱15,064,054.00',
                  style: TextStyle(
                    color: _officialText,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  '(as of September 13, 2024)',
                  style: TextStyle(
                    color: _officialSubtext,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const _DisbursementSummaryRow(
                  label: 'Allocated:',
                  value: '₱20,064,054.00',
                ),
                const _DisbursementSummaryRow(
                  label: 'Beginning Balance:',
                  value: '₱2,064,054.00',
                ),
                const _DisbursementSummaryRow(
                  label: 'Utilized:',
                  value: '₱5,064,054.00',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ..._sectors.map(
            (sector) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE3E6F1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFB20D0D),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(14),
                      ),
                    ),
                    child: Text(
                      sector.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available: ${_peso(sector.available)}',
                          style: const TextStyle(
                            color: _officialText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Utilized: ${_peso(sector.utilized)}',
                          style: const TextStyle(
                            color: _officialText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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

  Widget _disclosureTab() {
    final rows = _filteredRows;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F8FC), Color(0xFFF3ECEC)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFE3E6F1)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.menu_rounded),
                suffixIcon: Icon(Icons.search_rounded),
                hintText: 'Search products or services...',
              ),
            ),
          ),
          const SizedBox(height: 10),
          _filterDropdown(
            label: 'Purpose',
            value: _purposeFilter,
            items: _purposeOptions,
            onChanged: (v) => setState(() => _purposeFilter = v ?? 'All'),
          ),
          const SizedBox(height: 8),
          _filterDropdown(
            label: 'Status',
            value: _statusFilter,
            items: _statusOptions,
            onChanged: (v) => setState(() => _statusFilter = v ?? 'All'),
          ),
          const SizedBox(height: 8),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: _selectedDate,
              suffixIcon: const Icon(Icons.calendar_month_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2025, 8, 8),
                firstDate: DateTime(2024, 1, 1),
                lastDate: DateTime(2026, 12, 31),
              );
              if (picked == null) return;
              setState(() {
                _selectedDate =
                    '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
              });
            },
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE3E6F1)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F3F7),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Disbursement No.',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
                if (rows.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'No disbursement entries matched your filters.',
                      style: TextStyle(color: _officialSubtext),
                    ),
                  )
                else
                  ...rows.map(
                    (row) => Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFEAECEF)),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              row.date,
                              style: const TextStyle(
                                color: _officialText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              row.number,
                              style: const TextStyle(
                                color: _officialText,
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
          ),
        ],
      ),
    );
  }

  Widget _aipTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F8FC), Color(0xFFF3ECEC)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          const Center(
            child: Text(
              'Annual Investment Plan (AIP)\nCY 2025',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _officialText,
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'By Program/Project/Activity by Sector\nas of August 2025',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _officialSubtext,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Text(
              'WEST TAPINAC, CITY OF OLONGAPO, ZAMBALES',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _officialText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE3E6F1)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB20D0D),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _aipView,
                      dropdownColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      iconEnabledColor: Colors.white,
                      items: const [
                        DropdownMenuItem(
                          value: 'AIP TABLE',
                          child: Text('AIP TABLE'),
                        ),
                        DropdownMenuItem(
                          value: 'SECTOR SUMMARY',
                          child: Text('SECTOR SUMMARY'),
                        ),
                      ],
                      onChanged: (value) =>
                          setState(() => _aipView = value ?? 'AIP TABLE'),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: const Text(
                    'GRAND TOTAL: ₱94,545,498.87',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: _officialText,
                      fontWeight: FontWeight.w900,
                      fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Prepared by:\n'
                  'Vicente T. Capalla\n'
                  'Barangay Secretary\n'
                  'Date: 8/8/2025\n\n'
                  'Cresencio A.\n'
                  'Fernandez, Jr.\n'
                  'Barangay Treasurer\n'
                  'Date: 8/8/2025',
                  style: TextStyle(
                    color: _officialText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Attested by:\n'
                  'Lester C. Nadong\n\n'
                  'Punong Barangay\n'
                  'Date: 8/8/2025',
                  style: TextStyle(
                    color: _officialText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () =>
                  _showFeature(context, 'AIP report sent to print queue.'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFB20D0D),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'PRINT REPORT',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _DisbursementSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _DisbursementSummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _officialText,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: _officialText,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DisbursementSector {
  final String title;
  final double available;
  final double utilized;
  const _DisbursementSector({
    required this.title,
    required this.available,
    required this.utilized,
  });
}

class _DisclosureEntry {
  final String date;
  final String number;
  final String purpose;
  final String status;
  const _DisclosureEntry({
    required this.date,
    required this.number,
    required this.purpose,
    required this.status,
  });
}

class GovAgenciesPage extends StatelessWidget {
  const GovAgenciesPage({super.key});
  @override
  Widget build(BuildContext context) {
    const agencies = [
      _AgencyInfo(
        code: 'PGO',
        name: 'Provincial Governor\'s Office - Zambales',
        subtitle: 'Executive directives, province-wide programs, and referrals',
        website: 'zambales.gov.ph/governor',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2001',
        color: Color(0xFFB52A2A),
        icon: Icons.account_balance,
      ),
      _AgencyInfo(
        code: 'SP',
        name: 'Sangguniang Panlalawigan',
        subtitle: 'Provincial ordinances, hearings, and committee schedules',
        website: 'zambales.gov.ph/sangguniang-panlalawigan',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2014',
        color: Color(0xFF7A2F3E),
        icon: Icons.gavel,
      ),
      _AgencyInfo(
        code: 'PHO',
        name: 'Provincial Health Office',
        subtitle:
            'Hospital referral desk, disease surveillance, and immunization',
        website: 'zambales.gov.ph/health',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2032',
        color: Color(0xFF2E7D67),
        icon: Icons.local_hospital,
      ),
      _AgencyInfo(
        code: 'PDRRMO',
        name: 'Provincial DRRM Office',
        subtitle: 'Disaster preparedness, response coordination, and hotline',
        website: 'zambales.gov.ph/pdrrmo',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2045',
        color: Color(0xFF2C5FA8),
        icon: Icons.warning_amber_rounded,
      ),
      _AgencyInfo(
        code: 'PSWDO',
        name: 'Provincial Social Welfare and Development Office',
        subtitle:
            'Medical aid endorsement, burial aid, and social case support',
        website: 'zambales.gov.ph/pswdo',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2058',
        color: Color(0xFFB64C66),
        icon: Icons.volunteer_activism,
      ),
      _AgencyInfo(
        code: 'PESO',
        name: 'Provincial PESO',
        subtitle:
            'Local job matching, livelihood orientation, and hiring events',
        website: 'zambales.gov.ph/peso',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2073',
        color: Color(0xFF5A4FAF),
        icon: Icons.work_history,
      ),
      _AgencyInfo(
        code: 'PAGRI',
        name: 'Provincial Agriculture Office',
        subtitle:
            'Farm inputs, fisherfolk support, and agri-extension services',
        website: 'zambales.gov.ph/agriculture',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2096',
        color: Color(0xFF4C8B46),
        icon: Icons.agriculture,
      ),
      _AgencyInfo(
        code: 'PVET',
        name: 'Provincial Veterinary Office',
        subtitle: 'Livestock health, anti-rabies drives, and vet certification',
        website: 'zambales.gov.ph/veterinary',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2104',
        color: Color(0xFF2D7F7E),
        icon: Icons.pets,
      ),
      _AgencyInfo(
        code: 'PENG',
        name: 'Provincial Engineering Office',
        subtitle:
            'Road maintenance, drainage requests, and infrastructure works',
        website: 'zambales.gov.ph/engineering',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2118',
        color: Color(0xFFBA6A32),
        icon: Icons.engineering,
      ),
      _AgencyInfo(
        code: 'PIO',
        name: 'Provincial Information Office',
        subtitle: 'Official advisories, announcements, and media bulletins',
        website: 'zambales.gov.ph/pio',
        logoDomain: 'zambales.gov.ph',
        contact: '(047) 811-2130',
        color: Color(0xFF385CA8),
        icon: Icons.campaign,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provincial Government'),
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
                  colors: [Color(0xFFCF4545), Color(0xFFEA6C67)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26C63E3E),
                    blurRadius: 12,
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
                          'Provincial Contact Directory',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Capitol offices, hotlines, and service pages for Zambales province.',
                          style: TextStyle(
                            color: Color(0xFFFFE3DF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x3CFFFFFF),
                    child: Icon(Icons.apartment, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: agencies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 320,
              ),
              itemBuilder: (_, i) => _agencyCard(context, agencies[i]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _agencyCard(BuildContext context, _AgencyInfo agency) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(agency.name),
          content: Text(
            '${agency.subtitle}\n\nContact: ${agency.contact}\nPage: ${agency.website}\nOpen in browser when online access is enabled.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showFeature(context, 'Opening ${agency.website}');
              },
              child: const Text('Open Portal'),
            ),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE5E7F4)),
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
            _AgencyLogoBadge(agency: agency),
            const SizedBox(height: 10),
            Text(
              agency.code,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: agency.color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              agency.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3149),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              agency.subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF676D89),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.phone, size: 14, color: Color(0xFF78809B)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    agency.contact,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF78809B),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.language, size: 14, color: Color(0xFF78809B)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    agency.website,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF78809B),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
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

class _AgencyInfo {
  final String code;
  final String name;
  final String subtitle;
  final String website;
  final String logoDomain;
  final String contact;
  final Color color;
  final IconData icon;

  const _AgencyInfo({
    required this.code,
    required this.name,
    required this.subtitle,
    required this.website,
    required this.logoDomain,
    required this.contact,
    required this.color,
    required this.icon,
  });
}

class _AgencyLogoBadge extends StatelessWidget {
  final _AgencyInfo agency;
  const _AgencyLogoBadge({required this.agency});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            agency.color.withValues(alpha: 0.18),
            agency.color.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(color: agency.color.withValues(alpha: 0.24)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          'https://logo.clearbit.com/${agency.logoDomain}',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: agency.color.withValues(alpha: 0.08),
            child: Center(
              child: Icon(agency.icon, color: agency.color, size: 24),
            ),
          ),
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return Container(
              color: agency.color.withValues(alpha: 0.08),
              child: Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.3,
                    color: agency.color,
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

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  final _searchController = TextEditingController();
  int _doctorIndex = 0;

  static const _items = [
    _HealthServiceItem(
      id: 'medcert',
      title: 'Request MedCert',
      subtitle: 'Get a barangay medical certificate after physician review.',
      icon: Icons.assignment_rounded,
      bg: Color(0xFFFFECEA),
      accent: Color(0xFFD14F4F),
      eta: 'Release in 1-2 working days',
      keywords: 'medical certificate fit to work fit to travel',
    ),
    _HealthServiceItem(
      id: 'diagnostics',
      title: 'Diagnostics',
      subtitle: 'Book laboratory services and diagnostic referrals.',
      icon: Icons.biotech_rounded,
      bg: Color(0xFFEAF1FF),
      accent: Color(0xFF4263C5),
      eta: 'Referral confirmation within 24 hours',
      keywords: 'laboratory diagnostics x-ray urinalysis cbc',
    ),
    _HealthServiceItem(
      id: 'pharmacy',
      title: 'Pharmacy',
      subtitle: 'Check medicine availability and subsidy support.',
      icon: Icons.medication_rounded,
      bg: Color(0xFFE8F6EE),
      accent: Color(0xFF2D845D),
      eta: 'Stock response in 30-60 minutes',
      keywords: 'pharmacy medicine prescription maintenance drugs',
    ),
    _HealthServiceItem(
      id: 'consultation',
      title: 'Consultation',
      subtitle: 'Book a consultation with barangay physician or nurse.',
      icon: Icons.local_hospital_rounded,
      bg: Color(0xFFFFF0E9),
      accent: Color(0xFFB86A44),
      eta: 'Same-day to next-day slots',
      keywords: 'consultation doctor checkup teleconsult nurse',
    ),
  ];

  static const _physicians = [
    _BarangayPhysician(
      name: 'Dr. Lea Santos, MD',
      specialty: 'Family Medicine',
      dutySchedule: 'Mon, Wed, Fri - 9:00 AM - 2:00 PM',
      licenseNo: 'PRC 0765412',
      clinicRoom: 'BHS Room 2',
      onDuty: true,
    ),
    _BarangayPhysician(
      name: 'Dr. Carlo Dizon, MD',
      specialty: 'General Practice',
      dutySchedule: 'Tue, Thu, Sat - 1:00 PM - 6:00 PM',
      licenseNo: 'PRC 0803194',
      clinicRoom: 'BHS Room 1',
      onDuty: true,
    ),
  ];

  static const _hotlines = [
    ('Barangay Health Station', '(047) 251-2041'),
    ('City Health Office', '(047) 222-1144'),
    ('DOH Hotline', '1555'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_HealthServiceItem> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return _items;
    }
    return _items
        .where(
          (item) =>
              item.title.toLowerCase().contains(query) ||
              item.subtitle.toLowerCase().contains(query) ||
              item.keywords.contains(query),
        )
        .toList();
  }

  _BarangayPhysician get _selectedDoctor => _physicians[_doctorIndex];

  bool _needsDoctor(_HealthServiceItem item) =>
      item.id == 'consultation' ||
      item.id == 'diagnostics' ||
      item.id == 'medcert';

  void _openCheckupScheduler(
    BuildContext context,
    _BarangayPhysician physician,
  ) {
    final residentController = TextEditingController();
    final mobileController = TextEditingController();
    final concernController = TextEditingController();
    String day = 'Monday';
    String slot = '9:00 AM - 10:00 AM';

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
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFF7F6), Color(0xFFF8F5FF)],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFD84B4B), Color(0xFFEF7272)],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Schedule Barangay Check-Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${physician.name} - ${physician.specialty}',
                              style: const TextStyle(
                                color: Color(0xFFFFE8E8),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: residentController,
                        decoration: const InputDecoration(
                          labelText: 'Resident Full Name',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: day,
                        decoration: const InputDecoration(
                          labelText: 'Preferred Day',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Monday',
                            child: Text('Monday'),
                          ),
                          DropdownMenuItem(
                            value: 'Tuesday',
                            child: Text('Tuesday'),
                          ),
                          DropdownMenuItem(
                            value: 'Wednesday',
                            child: Text('Wednesday'),
                          ),
                          DropdownMenuItem(
                            value: 'Thursday',
                            child: Text('Thursday'),
                          ),
                          DropdownMenuItem(
                            value: 'Friday',
                            child: Text('Friday'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setModal(() => day = value);
                        },
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: slot,
                        decoration: const InputDecoration(
                          labelText: 'Preferred Time Slot',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: '9:00 AM - 10:00 AM',
                            child: Text('9:00 AM - 10:00 AM'),
                          ),
                          DropdownMenuItem(
                            value: '10:30 AM - 11:30 AM',
                            child: Text('10:30 AM - 11:30 AM'),
                          ),
                          DropdownMenuItem(
                            value: '1:00 PM - 2:00 PM',
                            child: Text('1:00 PM - 2:00 PM'),
                          ),
                          DropdownMenuItem(
                            value: '2:30 PM - 3:30 PM',
                            child: Text('2:30 PM - 3:30 PM'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setModal(() => slot = value);
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: concernController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Symptoms / Reason for check-up',
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            final name = residentController.text.trim();
                            final mobile = mobileController.text.trim();
                            final concern = concernController.text.trim();
                            if (name.isEmpty ||
                                mobile.isEmpty ||
                                concern.length < 8) {
                              _showFeature(
                                context,
                                'Please complete resident info and concern details.',
                              );
                              return;
                            }
                            Navigator.pop(context);
                            final ref =
                                'CHK-${DateTime.now().millisecondsSinceEpoch % 1000000}';
                            _showFeature(
                              this.context,
                              'Check-up scheduled with ${physician.name} on $day ($slot). Ref: $ref',
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFC74C4C),
                          ),
                          icon: const Icon(Icons.event_available_rounded),
                          label: const Text('Confirm Check-Up Schedule'),
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
      residentController.dispose();
      mobileController.dispose();
      concernController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health'),
        backgroundColor: const Color(0xFFCC1010),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFFF7F7F9),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          children: [
            const Text(
              'Welcome to eBarangayMo Health',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFF272B39),
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'Makaisa para sa malusog at masiglang komunidad.',
              style: TextStyle(
                color: Color(0xFF6B7088),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for health services...',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2A9A9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFCC1010),
                    width: 1.4,
                  ),
                ),
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EAF1)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Talk to a doctor now!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFD22D2D),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Consult with our licensed barangay physician for urgent but non-emergency concerns.',
                    style: TextStyle(
                      color: Color(0xFF5E647C),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xFFE8F7EE),
                          border: Border.all(color: const Color(0xFFBFE6CD)),
                        ),
                        child: const Icon(
                          Icons.verified_user,
                          color: Color(0xFF32A66D),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedDoctor.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2E3248),
                              ),
                            ),
                            Text(
                              _selectedDoctor.specialty,
                              style: const TextStyle(
                                color: Color(0xFF6B7088),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _selectedDoctor.dutySchedule,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6F748C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 74,
                        height: 92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFF6F7FB), Color(0xFFEBEEF9)],
                          ),
                        ),
                        child: const Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 8,
                              right: 10,
                              child: Icon(
                                Icons.favorite_rounded,
                                color: Color(0xFFD73B3B),
                                size: 16,
                              ),
                            ),
                            Icon(
                              Icons.medical_services_rounded,
                              color: Color(0xFF4B6DC8),
                              size: 36,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List.generate(_physicians.length, (index) {
                      final active = _doctorIndex == index;
                      return ChoiceChip(
                        label: Text(active ? 'On Duty' : 'Doctor ${index + 1}'),
                        selected: active,
                        onSelected: (_) => setState(() => _doctorIndex = index),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () =>
                              _openCheckupScheduler(context, _selectedDoctor),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFCC1010),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: const Icon(Icons.call),
                          label: const Text('Consult Now'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: _selectedDoctor.onDuty
                              ? const Color(0xFFE1F7EA)
                              : const Color(0xFFF1F1F3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
                        child: Text(
                          _selectedDoctor.onDuty
                              ? 'Doctor Available'
                              : 'Fully Booked',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _selectedDoctor.onDuty
                                ? const Color(0xFF26794A)
                                : const Color(0xFF656A83),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${_selectedDoctor.licenseNo} - ${_selectedDoctor.clinicRoom}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6F748C),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (filtered.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E8F4)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search_off, color: Color(0xFF7A809B)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'No matching health service found.',
                        style: TextStyle(
                          color: Color(0xFF646B86),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filtered.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE7E8EF)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0E000000),
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
                        borderRadius: BorderRadius.circular(12),
                        color: item.bg,
                      ),
                      child: Icon(item.icon, color: item.accent),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2F3248),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            color: Color(0xFF686C86),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.eta,
                          style: TextStyle(
                            color: item.accent.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        if (_needsDoctor(item)) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFECE8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Physician-assisted service',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: item.accent,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _HealthServiceDetailPage(
                          item: item,
                          preferredDoctor: _needsDoctor(item)
                              ? _selectedDoctor.name
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7E7F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.local_phone, color: Color(0xFF7B4A3F)),
                      SizedBox(width: 7),
                      Text(
                        'Health Hotlines',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2F3248),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._hotlines.map(
                    (line) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Color(0xFF3FA96D),
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              '${line.$1}  ${line.$2}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF5D627C),
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Call',
                            onPressed: () =>
                                _showFeature(context, 'Calling ${line.$2}...'),
                            icon: const Icon(
                              Icons.phone,
                              color: Color(0xFF4960BE),
                            ),
                          ),
                        ],
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
}

class _HealthServiceItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color bg;
  final Color accent;
  final String eta;
  final String keywords;

  const _HealthServiceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bg,
    required this.accent,
    required this.eta,
    required this.keywords,
  });
}

class _BarangayPhysician {
  final String name;
  final String specialty;
  final String dutySchedule;
  final String licenseNo;
  final String clinicRoom;
  final bool onDuty;

  const _BarangayPhysician({
    required this.name,
    required this.specialty,
    required this.dutySchedule,
    required this.licenseNo,
    required this.clinicRoom,
    this.onDuty = false,
  });
}

class EmergencyContactActionPage extends StatelessWidget {
  final String contactName;
  final String phoneNumber;
  final String description;
  const EmergencyContactActionPage({
    super.key,
    required this.contactName,
    required this.phoneNumber,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final name = contactName.toLowerCase();
    final accent = name.contains('ambulance')
        ? const Color(0xFF3846CE)
        : name.contains('fire')
        ? const Color(0xFFD34E3E)
        : name.contains('police')
        ? const Color(0xFF2A7A56)
        : const Color(0xFF8D5A49);
    final icon = name.contains('ambulance')
        ? Icons.health_and_safety_rounded
        : name.contains('fire')
        ? Icons.local_fire_department_rounded
        : name.contains('police')
        ? Icons.local_police_rounded
        : Icons.shield_rounded;

    return Scaffold(
      appBar: AppBar(
        title: Text(contactName),
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
          padding: const EdgeInsets.all(12),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE4E7F3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(icon, color: accent),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contactName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Color(0xFF2F3248),
                              ),
                            ),
                            Text(
                              phoneNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF5E637E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF646A84),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: () =>
                  _showFeature(context, 'Dialing $contactName ($phoneNumber)'),
              style: FilledButton.styleFrom(backgroundColor: accent),
              icon: const Icon(Icons.call_rounded),
              label: const Text('Call Now'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _showFeature(
                context,
                'Sending location and incident details to $contactName',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF8E4E45),
                side: const BorderSide(color: Color(0xFFB49087)),
              ),
              icon: const Icon(Icons.share_location_outlined),
              label: const Text('Share Location First'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyLocationSharePage extends StatefulWidget {
  const EmergencyLocationSharePage({super.key});

  @override
  State<EmergencyLocationSharePage> createState() =>
      _EmergencyLocationSharePageState();
}

class _EmergencyLocationSharePageState
    extends State<EmergencyLocationSharePage> {
  bool _includeLandmark = true;
  bool _highAccuracy = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Live Location'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE4E7F3)),
            ),
            child: const Text(
              'Send your live location to barangay responders for faster dispatch.',
              style: TextStyle(
                color: Color(0xFF505674),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            value: _highAccuracy,
            onChanged: (v) => setState(() => _highAccuracy = v),
            title: const Text('Use high accuracy GPS'),
            subtitle: const Text('Improves location precision in dense areas'),
          ),
          SwitchListTile(
            value: _includeLandmark,
            onChanged: (v) => setState(() => _includeLandmark = v),
            title: const Text('Include nearby landmark'),
            subtitle: const Text('Adds a recognizable reference point'),
          ),
          const SizedBox(height: 6),
          FilledButton.icon(
            onPressed: () => _showFeature(
              context,
              'Location shared to responders. Ref: LOC-26-001',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF2E35D3),
            ),
            icon: const Icon(Icons.send),
            label: const Text('Share Location'),
          ),
        ],
      ),
    );
  }
}

class EmergencyMessagePage extends StatefulWidget {
  const EmergencyMessagePage({super.key});

  @override
  State<EmergencyMessagePage> createState() => _EmergencyMessagePageState();
}

class _EmergencyMessagePageState extends State<EmergencyMessagePage> {
  final _locationController = TextEditingController();
  final _detailsController = TextEditingController();
  String _priority = 'Urgent';

  @override
  void dispose() {
    _locationController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Barangay'),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Incident Location',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: _priority,
            decoration: const InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Urgent', child: Text('Urgent')),
              DropdownMenuItem(value: 'High', child: Text('High')),
              DropdownMenuItem(value: 'Normal', child: Text('Normal')),
            ],
            onChanged: (value) =>
                setState(() => _priority = value ?? _priority),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _detailsController,
            minLines: 4,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Incident Details',
              hintText: 'Describe what happened and who needs help.',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              if (_locationController.text.trim().isEmpty ||
                  _detailsController.text.trim().isEmpty) {
                _showFeature(context, 'Please provide location and details.');
                return;
              }
              _showFeature(
                context,
                'Emergency message sent. Ref: MSG-26-014 ($_priority)',
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF2E35D3),
            ),
            icon: const Icon(Icons.send),
            label: const Text('Send Emergency Message'),
          ),
        ],
      ),
    );
  }
}

class AssistanceRequestPage extends StatefulWidget {
  final String assistanceType;
  final String assistanceDescription;
  final IconData assistanceIcon;
  final Color accentColor;

  const AssistanceRequestPage({
    super.key,
    required this.assistanceType,
    required this.assistanceDescription,
    required this.assistanceIcon,
    required this.accentColor,
  });

  @override
  State<AssistanceRequestPage> createState() => _AssistanceRequestPageState();
}

class _AssistanceRequestPageState extends State<AssistanceRequestPage> {
  final _fullNameController = TextEditingController(text: 'Shamira Balandra');
  final _mobileController = TextEditingController(text: '09073170635');
  final _notesController = TextEditingController();
  String _urgency = 'Regular';

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.assistanceType),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE4E7F3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: widget.accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.assistanceIcon,
                    color: const Color(0xFF4A4F6A),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.assistanceDescription,
                    style: const TextStyle(
                      color: Color(0xFF5C6280),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: _urgency,
            decoration: const InputDecoration(
              labelText: 'Urgency',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Regular', child: Text('Regular')),
              DropdownMenuItem(value: 'Priority', child: Text('Priority')),
              DropdownMenuItem(value: 'Immediate', child: Text('Immediate')),
            ],
            onChanged: (value) => setState(() => _urgency = value ?? _urgency),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _notesController,
            minLines: 3,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Details / Supporting Notes',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              if (_fullNameController.text.trim().isEmpty ||
                  _mobileController.text.trim().isEmpty) {
                _showFeature(context, 'Please complete full name and mobile.');
                return;
              }
              _showFeature(
                context,
                '${widget.assistanceType} request submitted. Ref: AST-26-102',
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF2E35D3),
            ),
            icon: const Icon(Icons.send),
            label: const Text('Submit Request'),
          ),
        ],
      ),
    );
  }
}

class _DocumentStatusDetailPage extends StatelessWidget {
  final _DocEntry entry;
  final String status;
  final Color accent;
  const _DocumentStatusDetailPage({
    required this.entry,
    required this.status,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = status == 'Pending';
    final isApproved = status == 'Approved';
    final isRejected = status == 'Rejected';
    final isCompleted = status == 'Completed';
    final actionLabel = switch (status) {
      'Approved' => 'View Document',
      'Completed' => 'Download PDF',
      'Rejected' => 'Review Notes',
      _ => 'Track Status',
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
        backgroundColor: const Color(0xFFF7F8FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F8FF), Color(0xFFF9F2EE)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE4E7F3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: accent.withValues(alpha: 0.14),
                        child: Icon(entry.icon, color: accent),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2F3248),
                              ),
                            ),
                            Text(
                              'Reference: ${entry.reference}',
                              style: const TextStyle(
                                color: Color(0xFF69708A),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: accent,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    entry.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF3E445E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    entry.detail,
                    style: const TextStyle(
                      color: Color(0xFF666B84),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE4E7F3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Processing Timeline',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F3248),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.check_circle, color: Color(0xFF3BAE72)),
                    title: Text('Application received'),
                    subtitle: Text('Request encoded and validated'),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      isPending
                          ? Icons.timelapse_rounded
                          : Icons.check_circle_rounded,
                      color: isPending
                          ? const Color(0xFF6570A5)
                          : const Color(0xFF3BAE72),
                    ),
                    title: const Text('Barangay processing'),
                    subtitle: Text(
                      isPending
                          ? 'Assigned to records and approval queue'
                          : 'Review completed by assigned officer',
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      isApproved || isCompleted
                          ? Icons.task_alt_rounded
                          : isRejected
                          ? Icons.cancel_rounded
                          : Icons.assignment_turned_in_rounded,
                      color: isApproved || isCompleted
                          ? const Color(0xFF3BAE72)
                          : isRejected
                          ? const Color(0xFFD74637)
                          : const Color(0xFF6B7088),
                    ),
                    title: const Text('Final action'),
                    subtitle: Text(
                      isApproved
                          ? 'Approved and ready for release'
                          : isCompleted
                          ? 'Released and completed'
                          : isRejected
                          ? 'Application rejected due to requirements'
                          : 'Ready for release or additional review',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () =>
                  _showFeature(context, '$actionLabel: ${entry.reference}'),
              style: FilledButton.styleFrom(backgroundColor: accent),
              icon: const Icon(Icons.open_in_new),
              label: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthServiceDetailPage extends StatefulWidget {
  final _HealthServiceItem item;
  final String? preferredDoctor;
  const _HealthServiceDetailPage({required this.item, this.preferredDoctor});

  @override
  State<_HealthServiceDetailPage> createState() =>
      _HealthServiceDetailPageState();
}

class _HealthServiceDetailPageState extends State<_HealthServiceDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _notesController = TextEditingController();
  final _certificatePurposeController = TextEditingController();
  static const _doctorNames = ['Dr. Lea Santos, MD', 'Dr. Carlo Dizon, MD'];
  static const _timeSlots = [
    '9:00 AM - 10:00 AM',
    '10:30 AM - 11:30 AM',
    '1:00 PM - 2:00 PM',
    '2:30 PM - 3:30 PM',
  ];
  String _selectedDoctor = _doctorNames[0];
  String _selectedDay = 'Monday';
  String _selectedTimeSlot = _timeSlots[0];
  bool _submitting = false;
  String? _referenceCode;

  bool get _requiresDoctor =>
      widget.item.id == 'consultation' ||
      widget.item.id == 'diagnostics' ||
      widget.item.id == 'medcert';

  bool get _isMedicalCertificate => widget.item.id == 'medcert';

  @override
  void initState() {
    super.initState();
    _selectedDoctor = widget.preferredDoctor ?? _doctorNames.first;
    if (_isMedicalCertificate) {
      _certificatePurposeController.text = 'Fit-to-work clearance';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _notesController.dispose();
    _certificatePurposeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 650));
    final prefix = _isMedicalCertificate
        ? 'MED'
        : (_requiresDoctor ? 'CHK' : 'HLT');
    final ref = '$prefix-${DateTime.now().millisecondsSinceEpoch % 1000000}';
    setState(() {
      _submitting = false;
      _referenceCode = ref;
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
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
                border: Border.all(color: const Color(0xFFE5E8F4)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
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
                      color: item.bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: item.accent),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2F3248),
                          ),
                        ),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            color: Color(0xFF686C86),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Expected processing: ${item.eta}',
                          style: TextStyle(
                            color: item.accent,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
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
                border: Border.all(color: const Color(0xFFE5E8F4)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2F3248),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
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
                    if (_requiresDoctor) ...[
                      DropdownButtonFormField<String>(
                        initialValue: _selectedDoctor,
                        decoration: const InputDecoration(
                          labelText: 'Preferred Physician',
                        ),
                        items: _doctorNames
                            .map(
                              (doctor) => DropdownMenuItem(
                                value: doctor,
                                child: Text(doctor),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedDoctor = value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select a physician.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedDay,
                              decoration: const InputDecoration(
                                labelText: 'Preferred Day',
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Monday',
                                  child: Text('Monday'),
                                ),
                                DropdownMenuItem(
                                  value: 'Tuesday',
                                  child: Text('Tuesday'),
                                ),
                                DropdownMenuItem(
                                  value: 'Wednesday',
                                  child: Text('Wednesday'),
                                ),
                                DropdownMenuItem(
                                  value: 'Thursday',
                                  child: Text('Thursday'),
                                ),
                                DropdownMenuItem(
                                  value: 'Friday',
                                  child: Text('Friday'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _selectedDay = value);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedTimeSlot,
                              decoration: const InputDecoration(
                                labelText: 'Time Slot',
                              ),
                              items: _timeSlots
                                  .map(
                                    (slot) => DropdownMenuItem(
                                      value: slot,
                                      child: Text(slot),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _selectedTimeSlot = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (_isMedicalCertificate) ...[
                      TextFormField(
                        controller: _certificatePurposeController,
                        decoration: const InputDecoration(
                          labelText: 'Certificate Purpose',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length < 5) {
                            return 'Please enter certificate purpose.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                    TextFormField(
                      controller: _notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: _requiresDoctor
                            ? 'Symptoms / Concern Details'
                            : 'Additional Notes',
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
                          backgroundColor: item.accent,
                        ),
                        icon: const Icon(Icons.send),
                        label: Text(
                          _submitting
                              ? 'Submitting...'
                              : (_isMedicalCertificate
                                    ? 'Submit Certificate Request'
                                    : (_requiresDoctor
                                          ? 'Schedule Health Check-Up'
                                          : 'Submit Health Request')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_referenceCode != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3FAF6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFCEE8D8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request Sent Successfully',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2F4F42),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Reference: $_referenceCode',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2F5E47),
                      ),
                    ),
                    if (_requiresDoctor) ...[
                      const SizedBox(height: 3),
                      Text(
                        'Assigned physician: $_selectedDoctor',
                        style: const TextStyle(
                          color: Color(0xFF365A4A),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Schedule: $_selectedDay - $_selectedTimeSlot',
                        style: const TextStyle(
                          color: Color(0xFF4E6770),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (_isMedicalCertificate) ...[
                      const SizedBox(height: 3),
                      Text(
                        'Certificate purpose: ${_certificatePurposeController.text}',
                        style: const TextStyle(
                          color: Color(0xFF516070),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 3),
                    const Text(
                      'You can use this code to follow up at the barangay help desk.',
                      style: TextStyle(
                        color: Color(0xFF5E6A7D),
                        fontWeight: FontWeight.w600,
                      ),
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

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<_CommunityPost> _posts = [
    _CommunityPost(
      author: 'West Tapinac',
      message:
          'Hello Brgy West Tapinac! Keep our neighborhoods clean and safe.',
      postedAt: DateTime.now().subtract(const Duration(minutes: 13)),
      hasPhoto: true,
      likes: 0,
      likedByMe: false,
      comments: 2,
      isOfficial: true,
    ),
    _CommunityPost(
      author: 'Barangay Disaster Team',
      message:
          'Reminder: Rainy season preparedness seminar starts Friday, 3:00 PM at Barangay Hall.',
      postedAt: DateTime.now().subtract(const Duration(hours: 3)),
      hasPhoto: false,
      likes: 11,
      likedByMe: false,
      comments: 3,
      isOfficial: true,
    ),
    _CommunityPost(
      author: 'Youth Council',
      message:
          'Basketball open tryouts this Saturday. Registration starts 8:00 AM.',
      postedAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      hasPhoto: true,
      likes: 24,
      likedByMe: false,
      comments: 9,
      isOfficial: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<_CommunityPost> get _latestPosts {
    final sorted = [..._posts]
      ..sort((a, b) => b.postedAt.compareTo(a.postedAt));
    return sorted.take(5).toList();
  }

  Future<void> _openCreatePost() async {
    final createdPost = await Navigator.push<_CommunityPost>(
      context,
      MaterialPageRoute(builder: (_) => const CommunityCreatePostPage()),
    );
    if (createdPost == null) return;
    if (!mounted) return;
    setState(() => _posts.insert(0, createdPost));
    _tabController.animateTo(0);
    _showFeature(context, 'Post published to community feed.');
  }

  Future<void> _openPost(_CommunityPost post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _CommunityPostDetailPage(post: post)),
    );
    if (!mounted) return;
    setState(() {});
  }

  Widget _composerCard() {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _openCreatePost,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E4EE)),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Text(
                'What\'s happening in your community?',
                style: TextStyle(
                  color: Color(0xFF62677E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.post_add, color: Color(0xFF3C425E)),
          ],
        ),
      ),
    );
  }

  Widget _postList(List<_CommunityPost> posts, {required String emptyLabel}) {
    if (posts.isEmpty) {
      return Center(
        child: Text(
          emptyLabel,
          style: const TextStyle(
            color: Color(0xFF666E89),
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return _CommunityFeedCard(
          key: ValueKey(post.id),
          post: post,
          onOpen: () => _openPost(post),
          onToggleLike: () => _toggleLike(post),
          onAddComment: () => _addComment(post),
        );
      },
    );
  }

  void _toggleLike(_CommunityPost post) {
    setState(() {
      post.toggleLike();
    });
    _showFeature(context, post.likedByMe ? 'Post liked.' : 'Like removed.');
  }

  Future<void> _addComment(_CommunityPost post) async {
    final comment = await _promptCommunityComment(context);
    if (comment == null || !mounted) return;
    setState(() {
      post.addComment(comment);
    });
    _showFeature(context, 'Comment added.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Posts'),
        backgroundColor: const Color(0xFFCB1010),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFFFFD0D0),
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800),
          tabs: const [
            Tab(text: 'Latest'),
            Tab(text: 'All'),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F8FC), Color(0xFFF4F1F1)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Column(
            children: [
              _composerCard(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _postList(
                      _latestPosts,
                      emptyLabel: 'No recent posts yet. Be the first to post.',
                    ),
                    _postList(
                      _posts,
                      emptyLabel: 'No community posts available.',
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
}

class _CommunityFeedCard extends StatelessWidget {
  final _CommunityPost post;
  final VoidCallback onOpen;
  final VoidCallback onToggleLike;
  final VoidCallback onAddComment;
  const _CommunityFeedCard({
    super.key,
    required this.post,
    required this.onOpen,
    required this.onToggleLike,
    required this.onAddComment,
  });

  @override
  Widget build(BuildContext context) {
    final latestComment = post.latestComment;
    final previewText = post.message.length > 92
        ? '${post.message.substring(0, 92)}...'
        : post.message;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E5EF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFFFEAEA),
                  child: Icon(
                    post.isOfficial ? Icons.campaign_rounded : Icons.person,
                    color: const Color(0xFFCB1010),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(
                          color: Color(0xFF2F3248),
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _relativeTime(post.postedAt),
                        style: const TextStyle(
                          color: Color(0xFFCB1010),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showFeature(context, 'Post options'),
                  icon: const Icon(Icons.close, color: Color(0xFF8A8FA8)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              previewText,
              style: const TextStyle(
                color: Color(0xFF32374E),
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onOpen,
                child: const Text(
                  'See more',
                  style: TextStyle(
                    color: Color(0xFFCB1010),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (post.hasPhoto) ...[
              _CommunityPhotoPreview(height: 168),
              const SizedBox(height: 8),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${post.likes} likes',
                  style: const TextStyle(color: Color(0xFF60657E)),
                ),
                Text(
                  '${post.comments} comments',
                  style: const TextStyle(color: Color(0xFF60657E)),
                ),
              ],
            ),
            if (latestComment != null) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E8F2)),
                ),
                child: Text(
                  latestComment.isMine
                      ? 'You: ${latestComment.message}'
                      : '${latestComment.author}: ${latestComment.message}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF474D66),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            const Divider(height: 18),
            Row(
              children: [
                TextButton.icon(
                  onPressed: onToggleLike,
                  icon: Icon(
                    post.likedByMe
                        ? Icons.thumb_up_alt_rounded
                        : Icons.thumb_up_alt_outlined,
                    size: 18,
                    color: post.likedByMe
                        ? const Color(0xFFCB1010)
                        : const Color(0xFF6E738D),
                  ),
                  label: Text(
                    post.likedByMe ? 'Liked' : 'Like',
                    style: TextStyle(
                      color: post.likedByMe
                          ? const Color(0xFFCB1010)
                          : const Color(0xFF6E738D),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onAddComment,
                  icon: const Icon(Icons.add_comment_outlined, size: 18),
                  label: const Text('Add a comment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityCreatePostPage extends StatefulWidget {
  const CommunityCreatePostPage({super.key});

  @override
  State<CommunityCreatePostPage> createState() =>
      _CommunityCreatePostPageState();
}

class _CommunityCreatePostPageState extends State<CommunityCreatePostPage> {
  final _messageController = TextEditingController();
  bool _hasAttachment = true;
  bool _submitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final message = _messageController.text.trim();
    if (message.length < 5) {
      _showFeature(context, 'Please enter a meaningful post message.');
      return;
    }
    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    Navigator.pop(
      context,
      _CommunityPost(
        author: 'West Tapinac',
        message: message,
        postedAt: DateTime.now(),
        hasPhoto: _hasAttachment,
        likes: 0,
        likedByMe: false,
        comments: 0,
        isOfficial: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Posts'),
        backgroundColor: const Color(0xFFCB1010),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Text(
            'Create a Post',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2C3147),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Share news, updates, or concerns with your barangay.',
            style: TextStyle(
              color: Color(0xFF646A84),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _messageController,
            maxLines: 7,
            decoration: InputDecoration(
              hintText: 'Type your community update...',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E5F0)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Attach a Photo',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF33384F),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => setState(() => _hasAttachment = true),
            child: const Text('CHOOSE FILE'),
          ),
          const SizedBox(height: 8),
          if (_hasAttachment)
            Stack(
              children: [
                _CommunityPhotoPreview(height: 180),
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.black.withValues(alpha: 0.45),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() => _hasAttachment = false),
                      icon: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: FilledButton(
                    onPressed: _submitting ? null : _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFCB1010),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(_submitting ? 'Posting...' : 'Post Now'),
                  ),
                ),
              ],
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: _submitting ? null : _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFCB1010),
                ),
                child: Text(_submitting ? 'Posting...' : 'Post Now'),
              ),
            ),
        ],
      ),
    );
  }
}

class _CommunityPostDetailPage extends StatefulWidget {
  final _CommunityPost post;
  const _CommunityPostDetailPage({required this.post});

  @override
  State<_CommunityPostDetailPage> createState() =>
      _CommunityPostDetailPageState();
}

class _CommunityPostDetailPageState extends State<_CommunityPostDetailPage> {
  void _toggleLike() {
    setState(() {
      widget.post.toggleLike();
    });
    _showFeature(context, widget.post.likedByMe ? 'Post liked.' : 'Like removed.');
  }

  Future<void> _addComment() async {
    final comment = await _promptCommunityComment(context);
    if (comment == null || !mounted) return;
    setState(() {
      widget.post.addComment(comment);
    });
    _showFeature(context, 'Comment added.');
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: const Color(0xFFCB1010),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFFEAEA),
              child: Icon(
                post.isOfficial ? Icons.campaign_rounded : Icons.person,
                color: const Color(0xFFCB1010),
              ),
            ),
            title: Text(
              post.author,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              _relativeTime(post.postedAt),
              style: const TextStyle(color: Color(0xFFCB1010)),
            ),
          ),
          Text(
            post.message,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF32374E),
            ),
          ),
          const SizedBox(height: 10),
          if (post.hasPhoto) _CommunityPhotoPreview(height: 220),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${post.likes} likes'),
              Text('${post.comments} comments'),
            ],
          ),
          const Divider(),
          Row(
            children: [
              TextButton.icon(
                onPressed: _toggleLike,
                icon: Icon(
                  post.likedByMe
                      ? Icons.thumb_up_alt_rounded
                      : Icons.thumb_up_alt_outlined,
                  size: 18,
                  color: post.likedByMe
                      ? const Color(0xFFCB1010)
                      : const Color(0xFF6E738D),
                ),
                label: Text(
                  post.likedByMe ? 'Liked' : 'Like',
                  style: TextStyle(
                    color: post.likedByMe
                        ? const Color(0xFFCB1010)
                        : const Color(0xFF6E738D),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _addComment,
                icon: const Icon(Icons.add_comment_outlined, size: 18),
                label: const Text('Add a comment'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (post.commentEntries.isEmpty)
            const Text(
              'No comments yet.',
              style: TextStyle(
                color: Color(0xFF6A7088),
                fontWeight: FontWeight.w600,
              ),
            )
          else ...[
            const Text(
              'Comments',
              style: TextStyle(
                color: Color(0xFF2E344C),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            ...post.commentEntries.map((entry) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                decoration: BoxDecoration(
                  color: entry.isMine
                      ? const Color(0xFFFFF4F4)
                      : const Color(0xFFF7F8FC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E8F2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.author,
                            style: const TextStyle(
                              color: Color(0xFF2E344C),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          _relativeTime(entry.postedAt),
                          style: const TextStyle(
                            color: Color(0xFF79809A),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      entry.message,
                      style: const TextStyle(
                        color: Color(0xFF3B4058),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _CommunityPhotoPreview extends StatelessWidget {
  final double height;
  const _CommunityPhotoPreview({required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.asset(
          'public/item-laptop.jpg',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          errorBuilder: (_, _, _) => Container(
            color: const Color(0xFFE8ECFA),
            alignment: Alignment.center,
            child: const Icon(
              Icons.image_not_supported_outlined,
              color: Color(0xFF7A809A),
            ),
          ),
        ),
      ),
    );
  }
}

class _CommunityPost {
  static int _nextId = 1;

  final int id;
  final String author;
  final String message;
  final DateTime postedAt;
  final bool hasPhoto;
  int likes;
  bool likedByMe;
  final List<_CommunityComment> commentEntries;
  final bool isOfficial;

  int get comments => commentEntries.length;
  _CommunityComment? get latestComment =>
      commentEntries.isEmpty ? null : commentEntries.first;

  _CommunityPost({
    int? id,
    required this.author,
    required this.message,
    required this.postedAt,
    required this.hasPhoto,
    required this.likes,
    this.likedByMe = false,
    int comments = 0,
    List<_CommunityComment>? commentEntries,
    required this.isOfficial,
  }) : id = id ?? _nextId++,
       commentEntries =
           commentEntries ??
           List<_CommunityComment>.generate(
             comments,
             (index) => _CommunityComment.seed(index, postedAt),
           );

  void toggleLike() {
    if (likedByMe) {
      likedByMe = false;
      if (likes > 0) {
        likes -= 1;
      }
      return;
    }
    likedByMe = true;
    likes += 1;
  }

  void addComment(String message) {
    commentEntries.insert(
      0,
      _CommunityComment(
        author: 'You',
        message: message,
        postedAt: DateTime.now(),
        isMine: true,
      ),
    );
  }
}

class _CommunityComment {
  final String author;
  final String message;
  final DateTime postedAt;
  final bool isMine;

  const _CommunityComment({
    required this.author,
    required this.message,
    required this.postedAt,
    this.isMine = false,
  });

  factory _CommunityComment.seed(int index, DateTime postTime) {
    final seededMessages = [
      'Thanks for the update.',
      'Will share this with our neighbors.',
      'Copy. We will coordinate with the team.',
      'Noted. Keep us posted on next steps.',
    ];
    return _CommunityComment(
      author: 'Resident ${index + 1}',
      message: seededMessages[index % seededMessages.length],
      postedAt: postTime.add(Duration(minutes: (index + 1) * 6)),
    );
  }
}

Future<String?> _promptCommunityComment(BuildContext context) async {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final text = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      final inset = MediaQuery.of(sheetContext).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.fromLTRB(14, 14, 14, 14 + inset),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Comment',
                style: TextStyle(
                  color: Color(0xFF2F344C),
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                minLines: 2,
                maxLines: 4,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Write your comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 2) {
                    return 'Please enter at least 2 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() != true) {
                          return;
                        }
                        Navigator.pop(sheetContext, controller.text.trim());
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFCB1010),
                      ),
                      child: const Text('Post'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
  controller.dispose();
  return text;
}

String _relativeTime(DateTime dateTime) {
  final diff = DateTime.now().difference(dateTime);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
  if (diff.inHours < 24) return '${diff.inHours} hours ago';
  return '${diff.inDays} days ago';
}

Widget _sectionTitle(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
    ),
  );
}

Widget _goTile(BuildContext context, String label, Widget page) {
  return Card(
    child: ListTile(
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
    ),
  );
}

void _showFeature(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class _StepTabs extends StatelessWidget {
  final String active;
  const _StepTabs({required this.active});

  @override
  Widget build(BuildContext context) {
    String mark(String label) => label == active ? '___' : '__';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Address ${mark('Address')}'),
        Text('Details ${mark('Details')}'),
        Text('Photo ${mark('Photo')}'),
      ],
    );
  }
}
