part of barangaymo_app;

bool _officialActivationCompleted = false;

const _actRed = Color(0xFFD70000);
const _actSurface = Color(0xFFF7F7FA);
const _actBorder = Color(0xFFE2E5EF);
const _actText = Color(0xFF252A3D);
const _actSubtext = Color(0xFF676E84);

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _actSurface,
      body: SafeArea(
        child: Center(
          child: FilledButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ActivationFlow()),
            ),
            style: FilledButton.styleFrom(backgroundColor: _actRed),
            child: const Text('START ACTIVATION'),
          ),
        ),
      ),
    );
  }
}

class ActivationFlow extends StatefulWidget {
  final bool goToHomeOnFinish;
  const ActivationFlow({super.key, this.goToHomeOnFinish = true});
  @override
  State<ActivationFlow> createState() => _ActivationFlowState();
}

class _ActivationFlowState extends State<ActivationFlow> {
  static const Map<String, Map<String, List<String>>> _location = {
    'Zambales': {
      'City of Olongapo': ['Old Cabalan', 'Banicain', 'West Tapinac'],
      'Subic': ['Calapacuan', 'Baraca-Camachile'],
    },
    'Bataan': {
      'Balanga City': ['Bagumbayan', 'Poblacion'],
    },
  };
  static const List<(String, String)> _officials = [
    ('ROLANDO ALBA', 'Punong Barangay'),
    ('JOSE GALANG', 'Sangguniang Barangay Member'),
    ('GERARDO ANDRADE', 'Sangguniang Barangay Member'),
    ('RODERICK GATON', 'Sangguniang Barangay Member'),
    ('GLENDA FLORES', 'Sangguniang Barangay Member'),
  ];

  final _page = PageController();
  int _step = 0;
  String? _province = 'Zambales';
  String? _city = 'City of Olongapo';
  String? _barangay = 'Old Cabalan';

  final _secFirst = TextEditingController(text: 'Brigette');
  final _secMiddle = TextEditingController();
  final _secLast = TextEditingController(text: 'Barrera');
  String _secSuffix = 'None';
  String _idType = 'Digital National ID';
  Uint8List? _idImage;
  String? _idName;
  final _secMobile = TextEditingController(text: '09123456701');
  final _secEmail = TextEditingController(text: 'olongapoasinan@gmail.com');

  final _punongFirst = TextEditingController(text: 'ELANE');
  final _punongMiddle = TextEditingController(text: 'ANGELO GREGG');
  final _punongLast = TextEditingController(text: 'NAZARENO');
  String _punongSuffix = 'None';
  bool _signatureSaved = false;
  final _signature = TextEditingController(text: 'E. NAZARENO');
  bool _acceptCert = false;

  final _population = TextEditingController();
  String _divisionType = 'Urban';
  final _households = TextEditingController();
  final _founded = TextEditingController(text: 'Friday, August 08, 2025');

  List<String> get _cities => _location[_province]?.keys.toList() ?? const [];
  List<String> get _barangays => (_province != null && _city != null)
      ? (_location[_province]?[_city] ?? const [])
      : const [];

  @override
  void dispose() {
    _page.dispose();
    _secFirst.dispose();
    _secMiddle.dispose();
    _secLast.dispose();
    _secMobile.dispose();
    _secEmail.dispose();
    _punongFirst.dispose();
    _punongMiddle.dispose();
    _punongLast.dispose();
    _signature.dispose();
    _population.dispose();
    _households.dispose();
    _founded.dispose();
    super.dispose();
  }

  InputDecoration _field(String label, {String? hint}) => InputDecoration(
    labelText: label,
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _actBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _actBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _actRed, width: 1.2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  );

  void _msg(String t) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));

  Future<void> _pickValidId() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    setState(() {
      _idImage = bytes;
      _idName = file.name;
    });
  }

  bool _validate() {
    if (_step == 0 &&
        (_province == null || _city == null || _barangay == null)) {
      _msg('Please complete address details.');
      return false;
    }
    if (_step == 2 &&
        (_secFirst.text.trim().isEmpty || _secLast.text.trim().isEmpty)) {
      _msg('Secretary first and last name are required.');
      return false;
    }
    if (_step == 3) {
      if (_idImage == null) {
        _msg('Please upload valid ID.');
        return false;
      }
      if (_secMobile.text.replaceAll(RegExp(r'\D'), '').length < 10) {
        _msg('Please enter valid mobile number.');
        return false;
      }
      if (!_secEmail.text.contains('@')) {
        _msg('Please enter valid official email.');
        return false;
      }
    }
    if (_step == 4) {
      if (_punongFirst.text.trim().isEmpty || _punongLast.text.trim().isEmpty) {
        _msg('Punong barangay first and last name are required.');
        return false;
      }
      if (!_signatureSaved) {
        _msg('Please save signature before continuing.');
        return false;
      }
    }
    if (_step == 5 && !_acceptCert) {
      _msg('Please accept certification terms.');
      return false;
    }
    if (_step == 7 &&
        (_population.text.trim().isEmpty || _households.text.trim().isEmpty)) {
      _msg('Please complete initial setup details.');
      return false;
    }
    return true;
  }

  int? _parseOptionalInt(String input) {
    final value = input.trim();
    if (value.isEmpty) {
      return null;
    }
    return int.tryParse(value);
  }

  Map<String, dynamic> _activationPayload() {
    final secMiddle = _secMiddle.text.trim();
    final secSuffix = _secSuffix == 'None' ? null : _secSuffix;
    final punongMiddle = _punongMiddle.text.trim();
    final punongSuffix = _punongSuffix == 'None' ? null : _punongSuffix;
    final population = _parseOptionalInt(_population.text);
    final households = _parseOptionalInt(_households.text);

    return {
      'province': _province,
      'city_municipality': _city,
      'barangay': _barangay,
      'secretary_first_name': _secFirst.text.trim(),
      if (secMiddle.isNotEmpty) 'secretary_middle_name': secMiddle,
      'secretary_last_name': _secLast.text.trim(),
      if (secSuffix != null) 'secretary_suffix': secSuffix,
      'id_type': _idType,
      if (_idName != null) 'valid_id_file_name': _idName,
      'secretary_mobile': _secMobile.text.trim(),
      'secretary_email': _secEmail.text.trim(),
      'punong_first_name': _punongFirst.text.trim(),
      if (punongMiddle.isNotEmpty) 'punong_middle_name': punongMiddle,
      'punong_last_name': _punongLast.text.trim(),
      if (punongSuffix != null) 'punong_suffix': punongSuffix,
      'signature': _signature.text.trim(),
      'accepted_certification': _acceptCert,
      if (population != null) 'population': population,
      if (households != null) 'households': households,
      'division_type': _divisionType,
      'founded': _founded.text.trim(),
    };
  }

  Future<void> _finish() async {
    final saveResult = await _AuthApi.instance.completeOfficialActivation(
      payload: _activationPayload(),
    );
    if (!saveResult.success) {
      if (!mounted) return;
      _msg(saveResult.message);
      return;
    }

    await _LocalActivationStore.markCompleted(
      _currentOfficialMobile ?? _secMobile.text,
    );

    _officialActivationCompleted = true;
    if (!mounted) return;
    if (widget.goToHomeOnFinish) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeShell()),
        (route) => false,
      );
    } else {
      Navigator.pop(context, true);
    }
  }

  Future<void> _next() async {
    if (!_validate()) return;
    if (_step >= 8) {
      await _finish();
      return;
    }
    setState(() => _step += 1);
    await _page.animateToPage(
      _step,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  Future<void> _back() async {
    if (_step == 0) {
      Navigator.pop(context);
      return;
    }
    setState(() => _step -= 1);
    await _page.animateToPage(
      _step,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  int get _tab => _step == 0 ? 0 : (_step == 1 ? 1 : (_step <= 5 ? 2 : -1));
  bool get _showTabs => _step <= 5;
  bool get _showFooterButton => _step != 8;
  String get _buttonLabel {
    if (_step == 5) return 'SUBMIT';
    if (_step == 6) return 'CONTINUE';
    if (_step == 7) return 'I-SAVE AT MAGPATULOY';
    return 'NEXT';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _actSurface,
      appBar: AppBar(
        title: const Text('Account Activation'),
        elevation: 0,
        backgroundColor: _actSurface,
        surfaceTintColor: _actSurface,
        foregroundColor: _actText,
        leading: IconButton(
          onPressed: _back,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          if (_showTabs)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: _ActivationTabs(active: _tab),
            ),
          Expanded(
            child: PageView(
              controller: _page,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _ActivationAddressStep(
                  field: _field,
                  province: _province,
                  city: _city,
                  barangay: _barangay,
                  cities: _cities,
                  barangays: _barangays,
                  location: _location,
                  onProvince: (v) => setState(() {
                    _province = v;
                    final cities =
                        _location[v]?.keys.toList() ?? const <String>[];
                    _city = cities.isEmpty ? null : cities.first;
                    _barangay = null;
                  }),
                  onCity: (v) => setState(() {
                    _city = v;
                    final barangays =
                        _location[_province]?[v] ?? const <String>[];
                    _barangay = barangays.isEmpty ? null : barangays.first;
                  }),
                  onBarangay: (v) => setState(() => _barangay = v),
                ),
                _ActivationOfficialsStep(
                  barangay: _barangay ?? 'Old Cabalan',
                  officials: _officials,
                ),
                _ActivationSecretaryProfileStep(
                  field: _field,
                  secFirst: _secFirst,
                  secMiddle: _secMiddle,
                  secLast: _secLast,
                  secSuffix: _secSuffix,
                  onSuffix: (v) => setState(() => _secSuffix = v ?? 'None'),
                ),
                _ActivationSecretaryIdStep(
                  field: _field,
                  idType: _idType,
                  onIdType: (v) =>
                      setState(() => _idType = v ?? 'Digital National ID'),
                  idImage: _idImage,
                  idName: _idName,
                  onPick: _pickValidId,
                  secMobile: _secMobile,
                  secEmail: _secEmail,
                ),
                _ActivationPunongStep(
                  field: _field,
                  first: _punongFirst,
                  middle: _punongMiddle,
                  last: _punongLast,
                  suffix: _punongSuffix,
                  onSuffix: (v) => setState(() => _punongSuffix = v ?? 'None'),
                  signature: _signature,
                  signatureSaved: _signatureSaved,
                  onClear: () => setState(() {
                    _signature.clear();
                    _signatureSaved = false;
                  }),
                  onSave: () {
                    if (_signature.text.trim().isEmpty) {
                      _msg('Type signature name first.');
                      return;
                    }
                    setState(() => _signatureSaved = true);
                  },
                ),
                _ActivationCertificationStep(
                  accept: _acceptCert,
                  onAccept: (v) => setState(() => _acceptCert = v ?? false),
                  barangay: _barangay ?? 'Old Cabalan',
                  city: _city ?? 'City of Olongapo',
                  province: _province ?? 'Zambales',
                  punongName:
                      '${_punongFirst.text} ${_punongMiddle.text} ${_punongLast.text}'
                          .trim(),
                  secName:
                      '${_secFirst.text} ${_secMiddle.text} ${_secLast.text}'
                          .trim(),
                ),
                _ActivationMabuhayStep(barangay: _barangay ?? 'Old Cabalan'),
                _ActivationSetupStep(
                  field: _field,
                  population: _population,
                  households: _households,
                  divisionType: _divisionType,
                  onDivision: (v) =>
                      setState(() => _divisionType = v ?? 'Urban'),
                  founded: _founded,
                ),
                _ActivationCouncilStep(onUpdate: _finish, onLater: _finish),
              ],
            ),
          ),
          if (_showFooterButton)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _next,
                    style: FilledButton.styleFrom(
                      backgroundColor: _actRed,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(_buttonLabel),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActivationTabs extends StatelessWidget {
  final int active;
  const _ActivationTabs({required this.active});
  @override
  Widget build(BuildContext context) {
    const titles = ['Address', 'Officials', 'Profile'];
    return Row(
      children: List.generate(titles.length, (i) {
        final on = i == active;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: on ? _actRed : const Color(0xFFCACDD5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  titles[i],
                  style: TextStyle(
                    color: on ? _actRed : _actText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _ActivationAddressStep extends StatelessWidget {
  final InputDecoration Function(String, {String? hint}) field;
  final String? province;
  final String? city;
  final String? barangay;
  final List<String> cities;
  final List<String> barangays;
  final Map<String, Map<String, List<String>>> location;
  final ValueChanged<String?> onProvince;
  final ValueChanged<String?> onCity;
  final ValueChanged<String?> onBarangay;
  const _ActivationAddressStep({
    required this.field,
    required this.province,
    required this.city,
    required this.barangay,
    required this.cities,
    required this.barangays,
    required this.location,
    required this.onProvince,
    required this.onCity,
    required this.onBarangay,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Address Details',
              style: TextStyle(
                color: _actText,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: province,
            decoration: field('1. Select Province'),
            items: location.keys
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onProvince,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: city,
            decoration: field('2. Select City/Municipality'),
            items: cities
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onCity,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: barangay,
            decoration: field('3. Select Barangay'),
            items: barangays
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onBarangay,
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _actBorder),
            ),
            child: Column(
              children: [
                Text(
                  barangay ?? 'Select Barangay',
                  style: const TextStyle(
                    color: _actText,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                const Text(
                  'Unregistered Barangay',
                  style: TextStyle(
                    color: _actSubtext,
                    fontWeight: FontWeight.w700,
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

class _ActivationOfficialsStep extends StatelessWidget {
  final String barangay;
  final List<(String, String)> officials;
  const _ActivationOfficialsStep({
    required this.barangay,
    required this.officials,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      children: [
        Text(
          'Barangay $barangay',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _actText,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'List of Barangay Officials',
          style: TextStyle(
            color: _actText,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'The following information is obtained from official DILG records.',
          style: TextStyle(color: _actSubtext, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        ...officials.map(
          (v) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _actBorder),
              ),
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    v.$1,
                    style: const TextStyle(
                      color: _actText,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    v.$2,
                    style: const TextStyle(
                      color: _actSubtext,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivationSecretaryProfileStep extends StatelessWidget {
  final InputDecoration Function(String, {String? hint}) field;
  final TextEditingController secFirst;
  final TextEditingController secMiddle;
  final TextEditingController secLast;
  final String secSuffix;
  final ValueChanged<String?> onSuffix;
  const _ActivationSecretaryProfileStep({
    required this.field,
    required this.secFirst,
    required this.secMiddle,
    required this.secLast,
    required this.secSuffix,
    required this.onSuffix,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Barangay Secretary Profile',
              style: TextStyle(
                color: _actText,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please fill in the identification details of the Barangay Secretary.',
            style: TextStyle(color: _actSubtext, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextField(controller: secFirst, decoration: field('4. First Name')),
          const SizedBox(height: 10),
          TextField(
            controller: secMiddle,
            decoration: field('5. Middle Name', hint: 'Type middle name...'),
          ),
          const SizedBox(height: 10),
          TextField(controller: secLast, decoration: field('6. Last Name')),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: secSuffix,
            decoration: field('7. Suffix'),
            items: const [
              DropdownMenuItem(value: 'None', child: Text('Select suffix...')),
              DropdownMenuItem(value: 'Jr.', child: Text('Jr.')),
              DropdownMenuItem(value: 'Sr.', child: Text('Sr.')),
              DropdownMenuItem(value: 'III', child: Text('III')),
            ],
            onChanged: onSuffix,
          ),
        ],
      ),
    );
  }
}

class _ActivationSecretaryIdStep extends StatelessWidget {
  final InputDecoration Function(String, {String? hint}) field;
  final String idType;
  final ValueChanged<String?> onIdType;
  final Uint8List? idImage;
  final String? idName;
  final VoidCallback onPick;
  final TextEditingController secMobile;
  final TextEditingController secEmail;
  const _ActivationSecretaryIdStep({
    required this.field,
    required this.idType,
    required this.onIdType,
    required this.idImage,
    required this.idName,
    required this.onPick,
    required this.secMobile,
    required this.secEmail,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            initialValue: idType,
            decoration: field('8. Valid ID Type'),
            items: const [
              DropdownMenuItem(
                value: 'Digital National ID',
                child: Text('Digital National ID'),
              ),
              DropdownMenuItem(
                value: 'PhilHealth ID',
                child: Text('PhilHealth ID'),
              ),
              DropdownMenuItem(value: 'Passport', child: Text('Passport')),
            ],
            onChanged: onIdType,
          ),
          const SizedBox(height: 10),
          const Text(
            '9. Upload Valid ID',
            style: TextStyle(color: _actText, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 3),
          const Text(
            'JPG, PNG or PDF (max 5MB)',
            style: TextStyle(color: _actSubtext, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 7),
          InkWell(
            onTap: onPick,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _actBorder),
              ),
              child: idImage == null
                  ? const Center(child: Text('Tap to upload ID'))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.memory(idImage!, fit: BoxFit.cover),
                    ),
            ),
          ),
          if (idName != null) ...[
            const SizedBox(height: 5),
            Text(
              idName!,
              style: const TextStyle(
                color: _actSubtext,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 10),
          TextField(
            controller: secMobile,
            keyboardType: TextInputType.phone,
            decoration: field('10. Mobile Number'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: secEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: field('11. Official Barangay Email Address'),
          ),
        ],
      ),
    );
  }
}

class _ActivationPunongStep extends StatelessWidget {
  final InputDecoration Function(String, {String? hint}) field;
  final TextEditingController first;
  final TextEditingController middle;
  final TextEditingController last;
  final String suffix;
  final ValueChanged<String?> onSuffix;
  final TextEditingController signature;
  final bool signatureSaved;
  final VoidCallback onClear;
  final VoidCallback onSave;
  const _ActivationPunongStep({
    required this.field,
    required this.first,
    required this.middle,
    required this.last,
    required this.suffix,
    required this.onSuffix,
    required this.signature,
    required this.signatureSaved,
    required this.onClear,
    required this.onSave,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Punong Barangay Certification',
              style: TextStyle(
                color: _actText,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          TextField(controller: first, decoration: field('12. First Name')),
          const SizedBox(height: 10),
          TextField(controller: middle, decoration: field('13. Middle Name')),
          const SizedBox(height: 10),
          TextField(controller: last, decoration: field('14. Last Name')),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: suffix,
            decoration: field('15. Suffix'),
            items: const [
              DropdownMenuItem(value: 'None', child: Text('Select suffix...')),
              DropdownMenuItem(value: 'Jr.', child: Text('Jr.')),
              DropdownMenuItem(value: 'Sr.', child: Text('Sr.')),
              DropdownMenuItem(value: 'III', child: Text('III')),
            ],
            onChanged: onSuffix,
          ),
          const SizedBox(height: 10),
          TextField(controller: signature, decoration: field('16. Signature')),
          const SizedBox(height: 8),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _actBorder),
            ),
            alignment: Alignment.center,
            child: Text(
              signatureSaved
                  ? 'Signature saved.'
                  : 'Type signature and tap SAVE',
              style: const TextStyle(
                color: _actSubtext,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onClear,
                  child: const Text('CLEAR'),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: FilledButton(
                  onPressed: onSave,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF25D315),
                  ),
                  child: const Text('SAVE'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivationCertificationStep extends StatelessWidget {
  final bool accept;
  final ValueChanged<bool?> onAccept;
  final String barangay;
  final String city;
  final String province;
  final String punongName;
  final String secName;
  const _ActivationCertificationStep({
    required this.accept,
    required this.onAccept,
    required this.barangay,
    required this.city,
    required this.province,
    required this.punongName,
    required this.secName,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Barangay Certification',
              style: TextStyle(
                color: _actText,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'By virtue of authority vested in me, I, $punongName, Punong Barangay of $barangay, $city, $province, hereby authorize our Barangay Secretary, $secName, to activate the BarangayMo App for official operations.',
            style: const TextStyle(
              color: _actText,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: accept,
            activeColor: _actRed,
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'I confirm the information is correct and accept the terms.',
              style: TextStyle(color: _actText, fontWeight: FontWeight.w600),
            ),
            onChanged: onAccept,
          ),
        ],
      ),
    );
  }
}

class _ActivationMabuhayStep extends StatelessWidget {
  final String barangay;
  const _ActivationMabuhayStep({required this.barangay});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      children: [
        Container(
          width: 110,
          height: 90,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEEEE),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.apartment, size: 48, color: _actRed),
        ),
        const Center(
          child: Text(
            'Mabuhay!',
            style: TextStyle(
              color: _actRed,
              fontSize: 35,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          'Barangay $barangay',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _actText,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Ang inyong barangay ay opisyal nang naging Smart Barangay!',
          textAlign: TextAlign.center,
          style: TextStyle(color: _actSubtext, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: const [
            _MiniFeature(
              icon: Icons.description_outlined,
              title: 'Digital na Serbisyo',
              subtitle: 'Digital para sa komunidad',
            ),
            _MiniFeature(
              icon: Icons.speed,
              title: 'Madaling Proseso',
              subtitle: 'Mabilis na pagproseso',
            ),
            _MiniFeature(
              icon: Icons.campaign_outlined,
              title: 'Diretsong Anunsyo',
              subtitle: 'Real-time updates',
            ),
            _MiniFeature(
              icon: Icons.folder_copy_outlined,
              title: 'Maayos na Record',
              subtitle: 'Secured records',
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _MiniFeature({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 41) / 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _actBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: _actRed),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                color: _actText,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: _actSubtext,
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

class _ActivationSetupStep extends StatelessWidget {
  final InputDecoration Function(String, {String? hint}) field;
  final TextEditingController population;
  final TextEditingController households;
  final String divisionType;
  final ValueChanged<String?> onDivision;
  final TextEditingController founded;
  const _ActivationSetupStep({
    required this.field,
    required this.population,
    required this.households,
    required this.divisionType,
    required this.onDivision,
    required this.founded,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Initial Setup ng Barangay',
            style: TextStyle(
              color: _actText,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Mangyaring punan ang impormasyon para makapagpatuloy sa dashboard.',
            style: TextStyle(color: _actSubtext, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: population,
            keyboardType: TextInputType.number,
            decoration: field(
              'Populasyon',
              hint: 'Ilagay ang kabuuang populasyon',
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: divisionType,
            decoration: field('Uri ng Dibisyon'),
            items: const [
              DropdownMenuItem(value: 'Urban', child: Text('Urban')),
              DropdownMenuItem(value: 'Rural', child: Text('Rural')),
              DropdownMenuItem(value: 'Coastal', child: Text('Coastal')),
            ],
            onChanged: onDivision,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: households,
            keyboardType: TextInputType.number,
            decoration: field(
              'Kabuuang Bilang o Titik ng Dibisyon',
              hint: 'Ilagay ang numero o titik',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: founded,
            readOnly: true,
            decoration: field('Petsa ng Pagkakatatag'),
          ),
        ],
      ),
    );
  }
}

class _ActivationCouncilStep extends StatelessWidget {
  final Future<void> Function() onUpdate;
  final Future<void> Function() onLater;
  const _ActivationCouncilStep({required this.onUpdate, required this.onLater});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _actBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.groups_2_outlined,
                size: 76,
                color: Color(0xFFA9A9B0),
              ),
              const SizedBox(height: 8),
              const Text(
                'Confirm Council Members',
                style: TextStyle(
                  color: _actText,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'In order for the app to be efficient you need to update the members.',
                style: TextStyle(
                  color: _actSubtext,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onUpdate,
                  style: FilledButton.styleFrom(
                    backgroundColor: _actRed,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('UPDATE NOW'),
                ),
              ),
              TextButton(
                onPressed: onLater,
                child: const Text(
                  "I'LL DO IT LATER",
                  style: TextStyle(
                    color: _actSubtext,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarangayMoLogo extends StatelessWidget {
  final double width;
  const _BarangayMoLogo({required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFD70000),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: const Text(
              'm',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 6),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              children: [
                TextSpan(
                  text: 'BARANGAY',
                  style: TextStyle(color: Color(0xFFD70000)),
                ),
                TextSpan(
                  text: 'mo',
                  style: TextStyle(color: Color(0xFF2E35D3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
