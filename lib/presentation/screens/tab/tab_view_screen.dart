import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../domain/tab/tab_template.dart';
import '../../../domain/tab/tab_repository.dart';
import '../../../domain/tab/tab_renderer.dart';
import '../../../domain/video/video_model.dart';

// Add provider definition
final tabRepositoryProvider = Provider((ref) => TabRepository());

class TabViewScreen extends ConsumerStatefulWidget {
  final Video video;
  final bool isStaticTab;

  const TabViewScreen({
    Key? key,
    required this.video,
    this.isStaticTab = false,
  }) : super(key: key);

  @override
  ConsumerState<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends ConsumerState<TabViewScreen> {
  TabTemplate? _tab;
  bool _isLoading = true;
  String? _error;
  double _autoScrollSpeed = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTab();
  }

  Future<void> _loadTab() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final tabRepository = ref.read(tabRepositoryProvider);
      final tab = await tabRepository.getTabForVideo(widget.video);
      
      if (tab == null) {
        setState(() {
          _error = 'No tab found for this video';
          _isLoading = false;
        });
        return;
      }
      
      setState(() {
        _tab = tab;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading tab: $e'); // Debug print
      setState(() {
        _error = 'Failed to load tab: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
                : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_tab == null) return const SizedBox.shrink();

    return Column(
      children: [
        // Header with back button and title
        _buildHeader(),
        
        // Metadata section
        _buildMetadataSection(),
        
        // Action buttons
        _buildActionButtons(),
        
        // Tab content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab content
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    (() {
                      print('\n📝 About to render tab...');
                      final renderedTab = TabRenderer.renderTab(_tab!);
                      print('📝 Rendered tab result:');
                      print(renderedTab);
                      return renderedTab;
                    })(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Courier',
                      height: 1.5,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(bottom: BorderSide(color: Colors.grey[800]!)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _tab!.songInfo.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _tab!.songInfo.artist,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(bottom: BorderSide(color: Colors.grey[800]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetadataItem('Difficulty', _tab!.songInfo.difficulty),
          _buildMetadataItem('Key', _tab!.meta.key),
          _buildMetadataItem(
            'Created',
            DateFormat('MMM d, yyyy').format(DateTime.now()), // Temporary until we add metadata
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(bottom: BorderSide(color: Colors.grey[800]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: FontAwesomeIcons.play,
            label: 'Auto Scroll',
            onPressed: () {
              // TODO: Implement auto scroll
            },
          ),
          _buildActionButton(
            icon: FontAwesomeIcons.music,
            label: 'Listen',
            onPressed: () {
              // TODO: Implement listen feature
            },
          ),
          _buildActionButton(
            icon: FontAwesomeIcons.filePdf,
            label: 'PDF',
            onPressed: () {
              // TODO: Implement PDF download
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  bool _isStandardTuning(List<String> tuning) {
    const standardTuning = ['E', 'A', 'D', 'G', 'B', 'E'];
    if (tuning.length != standardTuning.length) return false;
    for (int i = 0; i < tuning.length; i++) {
      if (tuning[i] != standardTuning[i]) return false;
    }
    return true;
  }
} 