import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFD3DC27);

    return MaterialApp(
      title: 'Nyaah Lembur',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: accent),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const NyaahLemburPage(),
    );
  }
}

class NyaahLemburPage extends StatefulWidget {
  const NyaahLemburPage({super.key});

  @override
  State<NyaahLemburPage> createState() => _NyaahLemburPageState();
}

class _NyaahLemburPageState extends State<NyaahLemburPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    try {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (_) {
              if (mounted) setState(() => _isLoading = false);
            },
            onWebResourceError: (error) {
              if (error.isForMainFrame ?? true) {
                setState(() {
                  _errorMessage = 'Gagal memuat halaman: ${error.description}';
                  _isLoading = false;
                });
              }
            },
          ),
        );
      
      // Memuat file HTML hasil konversi Figma yang ada di assets
      _controller.loadFlutterAsset('nyaah-lembur.html');
      
    } catch (e) {
      setState(() {
        _errorMessage = 'Inisialisasi WebView gagal: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            if (_errorMessage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              )
            else
              Positioned.fill(
                child: WebViewWidget(controller: _controller),
              ),
            if (_isLoading && _errorMessage == null)
              const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFD3DC27),
                ),
              ),
          ],
        ),
      ),
    );
  }
}