import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'user_preference_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isConfirmObscure = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),

              // Title
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              Text(
                'Start your wellness journey today',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              // Full Name Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 16.h),

              // Email Field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Confirm Password Field
              TextField(
                controller: _confirmPasswordController,
                obscureText: _isConfirmObscure,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmObscure = !_isConfirmObscure;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              // Sign Up Button
              ElevatedButton(
                onPressed: _agreeToTerms ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPreferenceScreen()),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _agreeToTerms ? Colors.white : Colors.grey,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}