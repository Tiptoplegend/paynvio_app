import 'package:flutter/material.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  static const _primary = Color(0xFF1A2B61);
  static const _background = Color(0xFFF4F1EA);

  // Template colors and copy from design spec
  final List<Map<String, dynamic>> _templates = [
    {
      'id': 'meridian',
      'name': 'Meridian',
      'description': 'Minimal · Universal · Default',
      'popular': true,
      'style': 'minimal',
      'primaryColor': 0xFFC8F23D, // Volt Green
      'backgroundColor': 0xFFFFFEF9, // Paper White
      'labelColor': 0xFF1A1A1A, // dark text on volt green
    },
    {
      'id': 'onyx',
      'name': 'Onyx',
      'description': 'Dark Mode · Premium · Bold',
      'popular': false,
      'style': 'bold',
      'primaryColor': 0xFFC8F23D, // Volt Green on Obsidian
      'backgroundColor': 0xFF0F0F1A, // Deep Black
      'labelColor': 0xFF0F0F1A,
    },
    {
      'id': 'terracotta',
      'name': 'Terracotta',
      'description': 'Warm · Artisanal · Local',
      'popular': false,
      'style': 'creative',
      'primaryColor': 0xFFC65D2A, // Terracotta
      'backgroundColor': 0xFFFBF6F0, // Warm Cream
      'labelColor': 0xFFFFFFFF,
    },
    {
      'id': 'slab',
      'name': 'Slab',
      'description': 'Formal · Corporate · Compliant',
      'popular': false,
      'style': 'professional',
      'primaryColor': 0xFF2B3F6C, // Navy Indigo
      'backgroundColor': 0xFFEEF1F6, // Blue-Grey Tint
      'labelColor': 0xFFFFFFFF,
    },
  ];

  final List<String> _filterOptions = [
    'All',
    'Minimal',
    'Bold',
    'Professional',
    'Creative',
  ];

  int _selectedIndex = 0;
  String _filter = 'All';
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredTemplates {
    if (_filter == 'All') return _templates;
    final style = _filter.toLowerCase();
    return _templates.where((t) => t['style'] == style).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTemplates;
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Templates',
          style: TextStyle(
            color: _primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildFilterChips(),
              const SizedBox(height: 20),
              SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: filtered.length,
                  onPageChanged: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final template = filtered[index];
                    final isSelected = index == _selectedIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: _TemplateCard(
                        template: template,
                        isSelected: isSelected,
                        selectionBorderColor: _primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildSelectedDetails(filtered),
              const SizedBox(height: 24),
              _buildCta(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose a Template',
            style: TextStyle(
              color: _primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '4 styles · Customisable colours',
            style: TextStyle(
              color: _primary.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filterOptions.map((option) {
          final isSelected = _filter == option;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _filter = option;
                  _selectedIndex = 0;
                  if (_filteredTemplates.isNotEmpty) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });
              },
              selectedColor: _primary,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : _primary,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              backgroundColor: Colors.white,
              side: BorderSide(
                color: isSelected ? _primary : Colors.grey.shade300,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSelectedDetails(List<Map<String, dynamic>> filtered) {
    if (filtered.isEmpty) return const SizedBox.shrink();
    final template = filtered[_selectedIndex];
    final name = template['name'] as String? ?? '';
    final description = template['description'] as String? ?? '';
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: _primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: _primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: _primary.withOpacity(0.7),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${_selectedIndex + 1} / ${filtered.length}',
          style: TextStyle(
            color: _primary.withOpacity(0.8),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildCta(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Use This Template — coming soon')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Use This Template'),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  const _TemplateCard({
    required this.template,
    required this.isSelected,
    required this.selectionBorderColor,
  });

  final Map<String, dynamic> template;
  final bool isSelected;
  final Color selectionBorderColor;

  Color get _primaryColor =>
      Color(template['primaryColor'] as int? ?? 0xFF1A2B61);
  Color get _backgroundColor =>
      Color(template['backgroundColor'] as int? ?? 0xFFF4F1EA);
  Color get _labelColor => Color(template['labelColor'] as int? ?? 0xFFFFFFFF);

  bool get _isDarkBg => _backgroundColor.computeLuminance() < 0.2;

  @override
  Widget build(BuildContext context) {
    final name = (template['name'] as String? ?? '').toUpperCase();
    final popular = template['popular'] as bool? ?? false;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isSelected ? selectionBorderColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _buildPreviewPlaceholder(),
                  if (popular)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'POPULAR',
                          style: TextStyle(
                            color: _labelColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: _primaryColor,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: _labelColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewPlaceholder() {
    return Container(
      width: double.infinity,
      color: _backgroundColor,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (_) => _placeholderLine(0.3)),
          const SizedBox(height: 8),
          ...List.generate(2, (_) => _placeholderLine(0.5)),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 24,
              height: 4,
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderLine(double widthFactor) {
    final lineColor = _isDarkBg ? Colors.grey.shade500 : Colors.grey.shade400;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            width: constraints.maxWidth * widthFactor,
            height: 6,
            decoration: BoxDecoration(
              color: lineColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      },
    );
  }
}
