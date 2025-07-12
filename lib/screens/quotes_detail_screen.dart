import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuotesDetailScreen extends StatefulWidget {
  final List<Map<String, String>> quotes;

  const QuotesDetailScreen({Key? key, required this.quotes}) : super(key: key);

  @override
  _QuotesDetailScreenState createState() => _QuotesDetailScreenState();
}

class _QuotesDetailScreenState extends State<QuotesDetailScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print('Quotes received: ${widget.quotes}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Inspiration'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Quote saved to favorites!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quote indicators
          Container(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.quotes.length,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 8.h,
                  width: _currentIndex == index ? 24.w : 8.w,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.white : Colors.grey,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ),

          // Quote PageView
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.quotes.isNotEmpty ? widget.quotes.length : 1,
              itemBuilder: (context, index) {
                if (widget.quotes.isEmpty) {
                  return Center(
                    child: Text(
                      "No quotes available.",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return _buildQuoteCard(widget.quotes[index]);
              },
            ),
          ),

          // Navigation and Action Buttons
          Container(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous Button
                IconButton(
                  onPressed: _currentIndex > 0
                      ? () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                      : null,
                  icon: Icon(
                    Icons.arrow_back,
                    color: _currentIndex > 0 ? Colors.white : Colors.grey,
                    size: 28.w,
                  ),
                ),

                // Share Button
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Color(0xFF262626),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: widget.quotes.isNotEmpty
                        ? () {
                      _shareQuote(widget.quotes[_currentIndex]);
                    }
                        : null,
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 24.w,
                    ),
                  ),
                ),

                // Next Button
                IconButton(
                  onPressed: _currentIndex < widget.quotes.length - 1
                      ? () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                      : null,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: _currentIndex < widget.quotes.length - 1
                        ? Colors.white
                        : Colors.grey,
                    size: 28.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(Map<String, String> quote) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Color(0xFF262626),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Quote Icon
          Icon(
            Icons.format_quote,
            size: 40.w,
            color: Colors.white.withOpacity(0.8),
          ),
          SizedBox(height: 24.h),

          // Quote Text
          Text(
            quote['quote'] ?? '',
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.h),

          // Author
          Text(
            '— ${quote['author'] ?? 'Unknown'}',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 40.h),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.favorite_border,
                label: 'Save',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Quote saved!')),
                  );
                },
              ),
              _buildActionButton(
                icon: Icons.copy,
                label: 'Copy',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Quote copied to clipboard!')),
                  );
                },
              ),
              _buildActionButton(
                icon: Icons.share,
                label: 'Share',
                onPressed: () {
                  _shareQuote(quote);
                },
              ),
            ],
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
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.w,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  void _shareQuote(Map<String, String> quote) {
    final shareText = '${quote['quote'] ?? ''}\n\n— ${quote['author'] ?? 'Unknown'}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quote ready to share!'),
        action: SnackBarAction(
          label: 'Share',
          onPressed: () {
            // Use share_plus in real app
            print('Sharing: $shareText');
          },
        ),
      ),
    );
  }
}