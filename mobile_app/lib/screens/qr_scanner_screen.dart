import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:digital_business_card/screens/card_detail_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String? _scannedResult;
  bool _isScanning = false;

  Future<void> _startScan() async {
    setState(() {
      _isScanning = true;
    });

    try {
      // 使用simple_barcode_scanner包扫描
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ),
      );

      if (result != null && result is String) {
        setState(() {
          _scannedResult = result;
          _isScanning = false;
        });
        _handleScannedData(result);
      } else {
        setState(() {
          _isScanning = false;
        });
      }
    } catch (e) {
      setState(() {
        _isScanning = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('扫描出错: $e')),
      );
    }
  }

  void _handleScannedData(String data) {
    // 處理掃描到的數據
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(cardId: data),
      ),
    );
  }

  void _manualInput() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('手动输入QR Code'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: '请输入QR Code内容',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              setState(() {
                _scannedResult = value;
              });
              Navigator.of(context).pop();
              _handleScannedData(value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              final textField = context.findRenderObject() as RenderBox;
              // 获取输入内容
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('掃描名片'),
        backgroundColor: kIsWeb ? Theme.of(context).colorScheme.inversePrimary : Colors.transparent,
        elevation: kIsWeb ? 1 : 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 扫描选项卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      '选择扫描方式',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isScanning ? null : _startScan,
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('扫描QR Code'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _manualInput,
                            icon: const Icon(Icons.edit),
                            label: const Text('手动输入'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // 扫描状态
            if (_isScanning)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 16),
                      Text('正在扫描...'),
                    ],
                  ),
                ),
              ),
            
            // 扫描结果
            if (_scannedResult != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '扫描结果:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_scannedResult!),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _handleScannedData(_scannedResult!);
                              },
                              child: const Text('处理结果'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _scannedResult = null;
                                });
                              },
                              child: const Text('清除'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
            const Spacer(),
            
            // 说明文字
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  kIsWeb 
                    ? 'Web版本支持多种QR Code扫描方式：\n'
                      '• 扫描QR Code（使用摄像头）\n'
                      '• 手动输入QR Code内容'
                    : '移动版本支持：\n'
                      '• 使用设备摄像头扫描QR Code\n'
                      '• 手动输入QR Code内容',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
