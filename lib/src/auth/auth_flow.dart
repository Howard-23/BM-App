part of barangaymo_app;

enum UserRole { resident, official }

String? _authToken;
String? _currentOfficialMobile;

String _normalizeMobileForKey(String input) {
  return input.replaceAll(RegExp(r'\D'), '');
}

class _LocalActivationStore {
  static const String _keyPrefix = 'official_activation_completed_';

  static String _keyFor(String mobile) {
    return '$_keyPrefix${_normalizeMobileForKey(mobile)}';
  }

  static Future<void> markCompleted(String mobile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFor(mobile), true);
  }

  static Future<bool> isCompleted(String mobile) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFor(mobile)) ?? false;
  }
}

class _AuthApiResult {
  final bool success;
  final String message;
  final String? token;
  final bool activationCompleted;
  const _AuthApiResult({
    required this.success,
    required this.message,
    this.token,
    this.activationCompleted = false,
  });
}

class _AuthApi {
  _AuthApi._();
  static final _AuthApi instance = _AuthApi._();

  static const String _liveBaseUrl = 'https://api.barangaymo.com/';
  static const String baseUrl = bool.fromEnvironment('dart.vm.product')
      ? _liveBaseUrl
      : String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: _liveBaseUrl,
        );
  static const Duration _requestTimeout = Duration(seconds: 15);

  String _normalizeMobile(String input) {
    return input.replaceAll(RegExp(r'\D'), '');
  }

  Uri _endpoint(String path) {
    final trimmedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return Uri.parse('$trimmedBase/$path');
  }

  List<Uri> _endpointCandidates(String path) {
    final out = <Uri>[];

    void add(String p) {
      final uri = _endpoint(p);
      if (!out.any((u) => u.toString() == uri.toString())) {
        out.add(uri);
      }
    }

    add(path);
    add('api/$path');
    return out;
  }

  Future<_AuthApiResult> register({
    required UserRole role,
    required String name,
    required String mobile,
    required String password,
    required String confirmPassword,
    String? province,
    String? cityMunicipality,
    String? barangay,
    String? middleName,
    String? suffix,
    String? religion,
  }) async {
    final normalizedMobile = _normalizeMobile(mobile);
    if (normalizedMobile.length < 10) {
      return const _AuthApiResult(
        success: false,
        message: 'Please enter a valid mobile number.',
      );
    }
    if (password.length < 6) {
      return const _AuthApiResult(
        success: false,
        message: 'Password must be at least 6 characters.',
      );
    }
    if (password != confirmPassword) {
      return const _AuthApiResult(
        success: false,
        message: 'Passwords do not match.',
      );
    }

    try {
      http.Response? response;
      Map<String, dynamic> body = <String, dynamic>{};
      final endpoints = _endpointCandidates('register');
      for (var i = 0; i < endpoints.length; i++) {
        final current = await http
            .post(
              endpoints[i],
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({
                'name': name.trim(),
                'mobile': normalizedMobile,
                'role': role.name,
                'password': password,
                'password_confirmation': confirmPassword,
                if (province != null && province.isNotEmpty)
                  'province': province,
                if (cityMunicipality != null && cityMunicipality.isNotEmpty)
                  'city_municipality': cityMunicipality,
                if (barangay != null && barangay.isNotEmpty)
                  'barangay': barangay,
                if (middleName != null && middleName.isNotEmpty)
                  'middle_name': middleName,
                if (suffix != null && suffix.isNotEmpty) 'suffix': suffix,
                if (religion != null && religion.isNotEmpty)
                  'religion': religion,
              }),
            )
            .timeout(_requestTimeout);
        final decoded = _decodeResponseBody(current.body);
        final shouldFallback =
            i < endpoints.length - 1 &&
            (current.statusCode == 404 ||
                ((decoded['message'] as String?) ?? '').toLowerCase().contains(
                      'route',
                    ) &&
                    ((decoded['message'] as String?) ?? '')
                        .toLowerCase()
                        .contains('not be found'));
        if (shouldFallback) {
          continue;
        }
        response = current;
        body = decoded;
        break;
      }
      if (response == null) {
        return const _AuthApiResult(
          success: false,
          message:
              'Cannot connect to server. Check backend URL and if Laravel is running.',
        );
      }

      if (response.statusCode == 201) {
        final user = body['user'];
        return _AuthApiResult(
          success: true,
          message:
              (body['message'] as String?) ?? 'Account created successfully.',
          token: body['token'] as String?,
          activationCompleted: _extractActivationCompleted(user),
        );
      }

      return _AuthApiResult(
        success: false,
        message: _extractMessage(body, fallback: 'Registration failed.'),
      );
    } on TimeoutException {
      return const _AuthApiResult(
        success: false,
        message:
            'Server is taking too long to respond. Please check backend and try again.',
      );
    } catch (_) {
      return const _AuthApiResult(
        success: false,
        message:
            'Cannot connect to server. Check backend URL and if Laravel is running.',
      );
    }
  }

  Future<_AuthApiResult> login({
    required UserRole role,
    required String mobile,
    required String password,
  }) async {
    final normalizedMobile = _normalizeMobile(mobile);
    try {
      http.Response? response;
      Map<String, dynamic> body = <String, dynamic>{};
      final endpoints = _endpointCandidates('login');
      for (var i = 0; i < endpoints.length; i++) {
        final current = await http
            .post(
              endpoints[i],
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({
                'mobile': normalizedMobile,
                'role': role.name,
                'password': password,
              }),
            )
            .timeout(_requestTimeout);
        final decoded = _decodeResponseBody(current.body);
        final shouldFallback =
            i < endpoints.length - 1 &&
            (current.statusCode == 404 ||
                ((decoded['message'] as String?) ?? '').toLowerCase().contains(
                      'route',
                    ) &&
                    ((decoded['message'] as String?) ?? '')
                        .toLowerCase()
                        .contains('not be found'));
        if (shouldFallback) {
          continue;
        }
        response = current;
        body = decoded;
        break;
      }
      if (response == null) {
        return const _AuthApiResult(
          success: false,
          message:
              'Cannot connect to server. Check backend URL and if Laravel is running.',
        );
      }

      if (response.statusCode == 200) {
        final user = body['user'];
        return _AuthApiResult(
          success: true,
          message: (body['message'] as String?) ?? 'Login successful.',
          token: body['token'] as String?,
          activationCompleted: _extractActivationCompleted(user),
        );
      }

      return _AuthApiResult(
        success: false,
        message: _extractMessage(body, fallback: 'Invalid credentials.'),
      );
    } on TimeoutException {
      return const _AuthApiResult(
        success: false,
        message:
            'Server is taking too long to respond. Please check backend and try again.',
      );
    } catch (_) {
      return const _AuthApiResult(
        success: false,
        message:
            'Cannot connect to server. Check backend URL and if Laravel is running.',
      );
    }
  }

  Future<_AuthApiResult> completeOfficialActivation({
    required Map<String, dynamic> payload,
  }) async {
    if (_authToken == null || _authToken!.isEmpty) {
      return const _AuthApiResult(
        success: false,
        message: 'Missing login session. Please log in again.',
      );
    }

    try {
      http.Response? response;
      Map<String, dynamic> body = <String, dynamic>{};
      final endpoints = _endpointCandidates('activation/complete');
      for (var i = 0; i < endpoints.length; i++) {
        final current = await http
            .post(
              endpoints[i],
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $_authToken',
              },
              body: jsonEncode(payload),
            )
            .timeout(_requestTimeout);
        final decoded = _decodeResponseBody(current.body);
        final shouldFallback =
            i < endpoints.length - 1 &&
            (current.statusCode == 404 ||
                ((decoded['message'] as String?) ?? '').toLowerCase().contains(
                      'route',
                    ) &&
                    ((decoded['message'] as String?) ?? '')
                        .toLowerCase()
                        .contains('not be found'));
        if (shouldFallback) {
          continue;
        }
        response = current;
        body = decoded;
        break;
      }

      if (response == null) {
        return const _AuthApiResult(
          success: false,
          message:
              'Cannot connect to server. Check backend URL and if Laravel is running.',
        );
      }

      if (response.statusCode == 200) {
        return _AuthApiResult(
          success: true,
          message:
              (body['message'] as String?) ?? 'Activation details saved.',
          activationCompleted: true,
        );
      }

      if (response.statusCode == 404 &&
          ((body['message'] as String?) ?? '')
              .toLowerCase()
              .contains('could not be found')) {
        return const _AuthApiResult(
          success: true,
          message:
              'Server activation endpoint is not available yet. Activation is saved on this device.',
          activationCompleted: true,
        );
      }

      return _AuthApiResult(
        success: false,
        message: _extractMessage(
          body,
          fallback: 'Could not save activation data. Please try again.',
        ),
      );
    } on TimeoutException {
      return const _AuthApiResult(
        success: false,
        message:
            'Server is taking too long to respond. Please check backend and try again.',
      );
    } catch (_) {
      return const _AuthApiResult(
        success: false,
        message:
            'Cannot connect to server. Check backend URL and if Laravel is running.',
      );
    }
  }

  Future<void> logout() async {
    if (_authToken == null || _authToken!.isEmpty) {
      return;
    }
    try {
      final endpoints = _endpointCandidates('logout');
      for (var i = 0; i < endpoints.length; i++) {
        final current = await http
            .post(
              endpoints[i],
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $_authToken',
              },
            )
            .timeout(_requestTimeout);
        if (current.statusCode != 404) {
          break;
        }
      }
    } catch (_) {}
  }

  bool _extractActivationCompleted(dynamic user) {
    if (user is Map<String, dynamic>) {
      return _toBool(user['activation_completed']);
    }
    return false;
  }

  bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      return normalized == '1' || normalized == 'true' || normalized == 'yes';
    }
    return false;
  }

  String _extractMessage(
    Map<String, dynamic> body, {
    required String fallback,
  }) {
    final message = body['message'];
    if (message is String && message.isNotEmpty) {
      return message;
    }
    final errors = body['errors'];
    if (errors is Map<String, dynamic>) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty && value.first is String) {
          return value.first as String;
        }
      }
    }
    return fallback;
  }

  Map<String, dynamic> _decodeResponseBody(String raw) {
    if (raw.isEmpty) {
      return <String, dynamic>{};
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {}
    return <String, dynamic>{};
  }
}

class RoleGatewayScreen extends StatelessWidget {
  const RoleGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: 240,
                height: 116,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFFFFF), Color(0xFFF1F3FF)],
                  ),
                  border: Border.all(color: const Color(0xFFE4E7FF)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Color(0x66FFFFFF),
                      blurRadius: 6,
                      offset: Offset(-2, -2),
                    ),
                  ],
                ),
                child: Image.asset(
                  'public/barangaymo.png',
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(height: 26),
              Expanded(
                child: Column(
                  children: [
                    _roleCard(
                      context,
                      title: 'Residents',
                      subtitle: 'Community services, profile, and RBI card',
                      role: UserRole.resident,
                    ),
                    const SizedBox(height: 14),
                    _roleCard(
                      context,
                      title: 'Barangay Officials',
                      subtitle: 'Activation, administration, and records',
                      role: UserRole.official,
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

  Widget _roleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required UserRole role,
  }) {
    final isResident = role == UserRole.resident;
    final accent = isResident
        ? const Color(0xFF2E35D3)
        : const Color(0xFFD70000);
    final logoAsset = isResident
        ? 'public/bm-residents.png'
        : 'public/bm-officials.png';
    final activeCount = isResident ? '1,284' : '64';

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RoleAuthChoicePage(role: role)),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFF3F3FF),
            border: Border.all(color: accent, width: 1.3),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      border: Border.all(color: accent.withValues(alpha: 0.2)),
                    ),
                    child: Image.asset(logoAsset, fit: BoxFit.contain),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: accent.withValues(alpha: 0.08),
                      border: Border.all(color: accent.withValues(alpha: 0.25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Active Accounts',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: accent.withValues(alpha: 0.95),
                          ),
                        ),
                        Text(
                          activeCount,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Text(subtitle),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('Continue', style: TextStyle(color: accent)),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: accent, size: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleAuthChoicePage extends StatelessWidget {
  final UserRole role;
  const RoleAuthChoicePage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isResident = role == UserRole.resident;
    return Scaffold(
      appBar: AppBar(
        title: Text(isResident ? 'Residents' : 'Barangay Officials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            SizedBox(
              height: 120,
              child: Image.asset(
                isResident
                    ? 'public/bm-residents.png'
                    : 'public/bm-officials.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isResident ? 'Resident Access' : 'Official Access',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 26),
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AuthRegisterPage(role: role)),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: isResident
                    ? const Color(0xFF2E35D3)
                    : const Color(0xFFD70000),
              ),
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AuthLoginPage(role: role)),
              ),
              child: const Text('Log In'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class OfficialLoginPage extends StatelessWidget {
  const OfficialLoginPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const AuthLoginPage(role: UserRole.official);
}

class AuthRegisterPage extends StatefulWidget {
  final UserRole role;
  const AuthRegisterPage({super.key, required this.role});

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _noMiddleName = false;
  bool _noSuffix = true;
  String _suffix = 'None';
  String _religion = 'Select...';
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedBarangay;
  bool _submitting = false;

  static const Map<String, Map<String, List<String>>> _locationDirectory = {
    'Zambales': {
      'City of Olongapo': [
        'Old Cabalan',
        'Banicain',
        'Kalaklan',
        'West Tapinac',
        'East Tapinac',
      ],
      'Subic': ['Calapacuan', 'Baraca-Camachile', 'Wawandue', 'Matain'],
      'Castillejos': ['San Agustin', 'San Juan', 'Looc', 'Nagbayanan'],
      'Iba': ['Bangantalinga', 'Palanginan', 'Sto. Rosario', 'Dirita'],
    },
    'Bataan': {
      'Balanga City': ['Bagumbayan', 'Cupang Proper', 'Poblacion', 'Tuyo'],
      'Dinalupihan': ['Bangal', 'Layac', 'Pag-asa', 'Tucop'],
      'Orani': ['Baluarte', 'Sibul', 'Tala', 'Wawa'],
    },
    'Pampanga': {
      'City of San Fernando': ['Del Pilar', 'Sindalan', 'Calulut', 'Lourdes'],
      'Angeles City': ['Pampang', 'Pulungbulu', 'Malabanias', 'Cutcut'],
      'Mabalacat City': ['Dau', 'Mawaque', 'Mabiga', 'Camachiles'],
    },
  };

  List<String> get _cities {
    if (_selectedProvince == null) return const [];
    final cities = _locationDirectory[_selectedProvince];
    if (cities == null) return const [];
    return cities.keys.toList();
  }

  List<String> get _barangays {
    if (_selectedProvince == null || _selectedCity == null) return const [];
    final cities = _locationDirectory[_selectedProvince];
    if (cities == null) return const [];
    return cities[_selectedCity] ?? const [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _middleNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isResident => widget.role == UserRole.resident;

  Color get _primaryColor =>
      _isResident ? const Color(0xFF2E35D3) : const Color(0xFFD70000);

  String get _title =>
      _isResident ? 'Resident Registration' : 'Official Registration';

  Color get _surfaceStart =>
      _isResident ? const Color(0xFFF4F7FF) : const Color(0xFFFFF6F6);

  Color get _surfaceEnd =>
      _isResident ? const Color(0xFFEFF3FF) : const Color(0xFFFFEFEF);

  Color get _fieldBorderColor =>
      _isResident ? const Color(0xFFC6D1FA) : const Color(0xFFF0C8C8);

  Color get _cardColor =>
      _isResident ? const Color(0xFFFBFCFF) : const Color(0xFFFFFCFC);

  Color get _titleColor =>
      _isResident ? const Color(0xFF26305F) : const Color(0xFF5A2424);

  Color get _labelColor =>
      _isResident ? const Color(0xFF5D6788) : const Color(0xFF775B5B);

  OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: _labelColor, fontWeight: FontWeight.w600),
      floatingLabelStyle: TextStyle(
        color: _primaryColor,
        fontWeight: FontWeight.w700,
      ),
      filled: true,
      fillColor: Colors.white,
      border: _inputBorder(_fieldBorderColor),
      enabledBorder: _inputBorder(_fieldBorderColor),
      focusedBorder: _inputBorder(_primaryColor, width: 1.5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _fieldBorderColor.withValues(alpha: 0.95)),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _titleColor,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _submitting = true);
    final result = await _AuthApi.instance.register(
      role: widget.role,
      name: _nameController.text,
      mobile: _mobileController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      province: _isResident ? _selectedProvince : null,
      cityMunicipality: _isResident ? _selectedCity : null,
      barangay: _isResident ? _selectedBarangay : null,
      middleName: _isResident && !_noMiddleName
          ? _middleNameController.text.trim()
          : null,
      suffix: _isResident && !_noSuffix && _suffix != 'None' ? _suffix : null,
      religion: _isResident && _religion != 'Select...' ? _religion : null,
    );
    if (!mounted) {
      return;
    }
    setState(() => _submitting = false);

    if (!result.success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result.message)));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AuthLoginPage(
          role: widget.role,
          prefilledMobile: _mobileController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_title),
        elevation: 0,
        backgroundColor: _surfaceStart,
        surfaceTintColor: _surfaceStart,
        foregroundColor: _titleColor,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_surfaceStart, _surfaceEnd],
              ),
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                16 + MediaQuery.of(context).viewInsets.bottom,
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Container(
                  height: 112,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: _fieldBorderColor),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withValues(alpha: 0.09),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    _isResident
                        ? 'public/bm-residents.png'
                        : 'public/bm-officials.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                _sectionCard(
                  title: 'Account Basics',
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: _fieldDecoration('Full Name'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name is required.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: _fieldDecoration('Mobile Number'),
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
                  ],
                ),
                const SizedBox(height: 10),
                if (_isResident) ...[
                  _sectionCard(
                    title: 'Address Assignment (Required)',
                    children: [
                      DropdownButtonFormField<String>(
                        initialValue: _selectedProvince,
                        decoration: _fieldDecoration('1. Select Province'),
                        items: _locationDirectory.keys
                            .map(
                              (v) => DropdownMenuItem(value: v, child: Text(v)),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedProvince = value;
                            _selectedCity = null;
                            _selectedBarangay = null;
                          });
                        },
                        validator: (value) {
                          if (!_isResident) return null;
                          if (value == null || value.isEmpty) {
                            return 'Province is required.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCity,
                        decoration: _fieldDecoration(
                          '2. Select City/Municipality',
                        ),
                        items: _cities
                            .map(
                              (v) => DropdownMenuItem(value: v, child: Text(v)),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value;
                            _selectedBarangay = null;
                          });
                        },
                        validator: (value) {
                          if (!_isResident) return null;
                          if (value == null || value.isEmpty) {
                            return 'City/Municipality is required.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedBarangay,
                        decoration: _fieldDecoration('3. Select Barangay'),
                        items: _barangays
                            .map(
                              (v) => DropdownMenuItem(value: v, child: Text(v)),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedBarangay = value),
                        validator: (value) {
                          if (!_isResident) return null;
                          if (value == null || value.isEmpty) {
                            return 'Barangay is required.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _sectionCard(
                    title: 'Personal Details',
                    children: [
                      TextFormField(
                        controller: _middleNameController,
                        enabled: !_noMiddleName,
                        decoration: _fieldDecoration(
                          '4. Middle Name (Optional)',
                        ),
                      ),
                      CheckboxListTile(
                        dense: true,
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        value: _noMiddleName,
                        title: Text(
                          'I have no middle name',
                          style: TextStyle(
                            color: _labelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onChanged: (v) => setState(() {
                          _noMiddleName = v ?? false;
                          if (_noMiddleName) _middleNameController.clear();
                        }),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _suffix,
                        decoration: _fieldDecoration('5. Suffix (Optional)'),
                        items: const [
                          DropdownMenuItem(
                            value: 'None',
                            child: Text('Select...'),
                          ),
                          DropdownMenuItem(value: 'Jr.', child: Text('Jr.')),
                          DropdownMenuItem(value: 'Sr.', child: Text('Sr.')),
                          DropdownMenuItem(value: 'III', child: Text('III')),
                          DropdownMenuItem(value: 'IV', child: Text('IV')),
                        ],
                        onChanged: (value) =>
                            setState(() => _suffix = value ?? 'None'),
                      ),
                      CheckboxListTile(
                        dense: true,
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        value: _noSuffix,
                        title: Text(
                          'I have no suffix',
                          style: TextStyle(
                            color: _labelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onChanged: (v) => setState(() {
                          _noSuffix = v ?? true;
                          if (_noSuffix) _suffix = 'None';
                        }),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _religion,
                        decoration: _fieldDecoration('6. Religion'),
                        items: const [
                          DropdownMenuItem(
                            value: 'Select...',
                            child: Text('Select...'),
                          ),
                          DropdownMenuItem(
                            value: 'Catholic',
                            child: Text('Catholic'),
                          ),
                          DropdownMenuItem(
                            value: 'Christian',
                            child: Text('Christian'),
                          ),
                          DropdownMenuItem(
                            value: 'Islam',
                            child: Text('Islam'),
                          ),
                          DropdownMenuItem(
                            value: 'Iglesia ni Cristo',
                            child: Text('Iglesia ni Cristo'),
                          ),
                          DropdownMenuItem(
                            value: 'Others',
                            child: Text('Others'),
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() => _religion = v ?? 'Select...'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
                _sectionCard(
                  title: 'Security',
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: _fieldDecoration('Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required.';
                        }
                        if (value.length < 6) {
                          return 'Minimum 6 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: _fieldDecoration('Confirm Password'),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _submitting ? null : _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: _primaryColor,
                    ),
                    child: Text(
                      _submitting ? 'Please wait...' : 'Create Account',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _submitting
                      ? null
                      : () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AuthLoginPage(role: widget.role),
                          ),
                        ),
                  child: Text(
                    'Already have an account? Log in',
                    style: TextStyle(
                      color: _isResident
                          ? const Color(0xFF303A8D)
                          : const Color(0xFFB22727),
                    ),
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

class AuthLoginPage extends StatefulWidget {
  final UserRole role;
  final String? prefilledMobile;
  const AuthLoginPage({super.key, required this.role, this.prefilledMobile});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _submitting = false;

  bool get _isResident => widget.role == UserRole.resident;

  Color get _primaryColor =>
      _isResident ? const Color(0xFF2E35D3) : const Color(0xFFD70000);

  String get _title => _isResident ? 'Resident Login' : 'Official Login';

  Widget _homeForRole() {
    if (_isResident) {
      return const ResidentHomeShell();
    }
    return _officialActivationCompleted
        ? const HomeShell()
        : const ActivationFlow();
  }

  @override
  void initState() {
    super.initState();
    _mobileController.text = widget.prefilledMobile ?? '';
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _submitting = true);
    final result = await _AuthApi.instance.login(
      role: widget.role,
      mobile: _mobileController.text,
      password: _passwordController.text,
    );
    if (!mounted) {
      return;
    }
    setState(() => _submitting = false);

    if (!result.success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
      return;
    }

    _authToken = result.token;
    if (!_isResident) {
      final localCompleted = await _LocalActivationStore.isCompleted(
        _mobileController.text,
      );
      if (!mounted) {
        return;
      }
      _officialActivationCompleted = result.activationCompleted || localCompleted;
      _currentOfficialMobile = _normalizeMobileForKey(_mobileController.text);
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => _homeForRole()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(_title)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              16 + MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  _isResident
                      ? 'public/bm-residents.png'
                      : 'public/bm-officials.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submitting ? null : _submit,
                  style: FilledButton.styleFrom(backgroundColor: _primaryColor),
                  child: Text(_submitting ? 'Please wait...' : 'Log In'),
                ),
              ),
              TextButton(
                onPressed: _submitting
                    ? null
                    : () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AuthRegisterPage(role: widget.role),
                        ),
                      ),
                child: const Text('No account yet? Create one'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResidentWelcomePage extends StatelessWidget {
  const ResidentWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Welcome to BarangayMo!',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2E35D3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text('Ang unang sandigan ng mamamayan.'),
              const SizedBox(height: 24),
              SizedBox(
                height: 110,
                child: Image.asset(
                  'public/bm-residents.png',
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResidentRegisterFlow(),
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2E35D3),
                  ),
                  child: const Text('GET STARTED'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResidentRegisterFlow extends StatefulWidget {
  const ResidentRegisterFlow({super.key});

  @override
  State<ResidentRegisterFlow> createState() => _ResidentRegisterFlowState();
}

class _ResidentRegisterFlowState extends State<ResidentRegisterFlow> {
  final page = PageController();
  int i = 0;
  bool noMiddleName = false;
  bool noSuffix = false;
  String religion = 'Select...';
  final steps = const [
    'Register with Mobile',
    'OTP Verification',
    'Set MPIN',
    'Address',
    'Details',
    'Photo',
    'Done',
  ];

  void next() {
    if (i == steps.length - 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ResidentHomeShell()),
        (route) => false,
      );
      return;
    }
    page.nextPage(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resident Registration'),
        backgroundColor: const Color(0xFF2E35D3),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: LinearProgressIndicator(
              value: (i + 1) / steps.length,
              minHeight: 7,
              color: const Color(0xFF2E35D3),
            ),
          ),
          Text('${i + 1}/${steps.length} ${steps[i]}'),
          Expanded(
            child: PageView(
              controller: page,
              onPageChanged: (v) => setState(() => i = v),
              children: [
                _regWrap(
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Mobile Number (+63)',
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('By continuing, you agree to Terms and Policies.'),
                  ],
                  button: 'Get OTP',
                  onNext: next,
                ),
                _regWrap(
                  children: const [
                    Text('Enter the 6-digit code sent to your phone.'),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(labelText: 'OTP Code'),
                    ),
                  ],
                  button: 'Verify',
                  onNext: next,
                ),
                _regWrap(
                  children: const [
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Type 4-digit MPIN',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm 4-digit MPIN',
                      ),
                    ),
                  ],
                  button: 'Submit',
                  onNext: next,
                ),
                _regWrap(
                  children: [
                    const _StepTabs(active: 'Address'),
                    const SizedBox(height: 8),
                    const Text(
                      'Please Complete Your Address Details:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '1. Select Province',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '2. Select City/Municipality',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '3. Select Barangay',
                      ),
                    ),
                  ],
                  button: 'Save Changes',
                  onNext: next,
                ),
                _regWrap(
                  children: [
                    const _StepTabs(active: 'Details'),
                    const SizedBox(height: 8),
                    const Text(
                      'Please Complete Your Personal Details:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    const TextField(
                      decoration: InputDecoration(labelText: '4. First Name'),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '5. Middle Name (Optional)',
                      ),
                    ),
                    CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: noMiddleName,
                      title: const Text('I have no middle name'),
                      onChanged: (v) =>
                          setState(() => noMiddleName = v ?? false),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(labelText: '6. Last Name'),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '7. Suffix (Optional)',
                      ),
                    ),
                    CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: noSuffix,
                      title: const Text('I have no suffix'),
                      onChanged: (v) => setState(() => noSuffix = v ?? false),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '8. Date of Birth',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '9. Place of Birth',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(labelText: '10. Sex'),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(labelText: '11. Nationality'),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: religion,
                      decoration: const InputDecoration(
                        labelText: '12. Religion',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Select...',
                          child: Text('Select...'),
                        ),
                        DropdownMenuItem(
                          value: 'Catholic',
                          child: Text('Catholic'),
                        ),
                        DropdownMenuItem(
                          value: 'Christian',
                          child: Text('Christian'),
                        ),
                        DropdownMenuItem(value: 'Islam', child: Text('Islam')),
                        DropdownMenuItem(
                          value: 'Others',
                          child: Text('Others'),
                        ),
                      ],
                      onChanged: (v) =>
                          setState(() => religion = v ?? 'Select...'),
                    ),
                  ],
                  button: 'Save Details',
                  onNext: next,
                ),
                _regWrap(
                  children: [
                    const _StepTabs(active: 'Photo'),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please Add a Photo for your identity:',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Text('Sample Photo')),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('Choose a photo to upload'),
                      ),
                    ),
                  ],
                  button: 'Save Photo',
                  onNext: next,
                ),
                _regWrap(
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: Color(0xFF2E35D3),
                      size: 90,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Congratulations, Shamira!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text('You\'ve successfully registered in BarangayMo.'),
                  ],
                  button: 'Let\'s Go',
                  onNext: next,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _regWrap({
    required List<Widget> children,
    required String button,
    required VoidCallback onNext,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          ...children,
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onNext,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF2E35D3),
            ),
            child: Text(button),
          ),
        ],
      ),
    );
  }
}

class ResidentLoginPage extends StatelessWidget {
  const ResidentLoginPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const AuthLoginPage(role: UserRole.resident);
}

class ResidentMpinLoginPage extends StatefulWidget {
  const ResidentMpinLoginPage({super.key});
  @override
  State<ResidentMpinLoginPage> createState() => _ResidentMpinLoginPageState();
}

class _ResidentMpinLoginPageState extends State<ResidentMpinLoginPage> {
  String pin = '';

  void tap(String v) {
    if (v == 'C') {
      setState(() => pin = '');
      return;
    }
    if (v == '<') {
      if (pin.isNotEmpty) {
        setState(() => pin = pin.substring(0, pin.length - 1));
      }
      return;
    }
    if (pin.length < 4) {
      setState(() => pin += v);
    }
  }

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'C', '0', '<'];
    return Scaffold(
      appBar: AppBar(title: const Text('MPIN Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Enter your 4-digit MPIN',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              pin.padRight(4, '•'),
              style: const TextStyle(fontSize: 42, letterSpacing: 8),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.4,
                children: keys
                    .map(
                      (k) => Padding(
                        padding: const EdgeInsets.all(6),
                        child: OutlinedButton(
                          onPressed: () => tap(k),
                          child: Text(k, style: const TextStyle(fontSize: 28)),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: pin.length == 4
                    ? () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResidentHomeShell(),
                        ),
                        (route) => false,
                      )
                    : null,
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
