import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _acceptedTerms = false;
  bool _acceptedPrivacy = false;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(children: [
                      const Text("Welcome to StudyMe",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.green)),
                      const SizedBox(height: 10),
                      Text(
                          "Have you ever tried something to improve your health or wellbeing but weren't sure if it worked?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: 10),
                      Text(
                          "Or maybe you tried multiple things and didn’t know which worked better?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).primaryColor)),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(
                      children: <Widget>[
                        Text(
                            "With StudyMe, you can run your own experiments to gather real evidence about whether something you do is helping you achieve your health goals.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Text(
                            "There are 3 main steps to create your experiment:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(height: 10),
                        Text("1. Set a goal ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(height: 5),
                        Text("Example: Lose weight",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 23,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(height: 10),
                        Text(
                            "2. Pick something you want to try out to achieve that goal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(height: 5),
                        Text("Example: Run for half an hour every two days",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 23,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(height: 10),
                        Text(
                            "2. Choose the type of data you want to collect, to see if you are achieving your goal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(height: 5),
                        Text("Example: Weight (kg)",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 23,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(
                      children: <Widget>[
                        Text(
                            "Using this information, StudyMe will help you set up an experiment that keeps you on schedule and organizes your data based on scientific methods.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ListView(
                        children: [
                          Text("Ready? Let's get started!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Theme.of(context).primaryColor)),
                          const SizedBox(height: 40),
                          Column(
                            children: [
                              OutlinedButton.icon(
                                icon: const Icon(Icons.assignment_outlined),
                                label: const Text('Terms of Use'),
                                onPressed: () => launchUrl(Uri(
                                  scheme: "https",
                                  host: "www13.hpi.uni-potsdam.de",
                                  path:
                                      "fileadmin/user_upload/fachgebiete/lippert/studyme/Terms_of_Use.pdf",
                                )),
                              ),
                              SwitchListTile(
                                title: const Text(
                                    "I have read and agree to the terms of use"),
                                value: _acceptedTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _acceptedTerms = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              OutlinedButton.icon(
                                icon: const Icon(Icons.privacy_tip_outlined),
                                label: const Text('Privacy Policy'),
                                onPressed: () => launchUrl(Uri(
                                  scheme: "https",
                                  host: "github.com",
                                  path:
                                      "HIAlab/studyme/blob/main/legal/privacy_policy.md",
                                )),
                              ),
                              SwitchListTile(
                                title: const Text(
                                    "I have read and agree to the privacy policy"),
                                value: _acceptedPrivacy,
                                onChanged: (value) {
                                  setState(() {
                                    _acceptedPrivacy = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 70),
                              OutlinedButton.icon(
                                icon: const Icon(Icons.assignment_outlined),
                                label: const Text('Imprint'),
                                onPressed: () => launchUrl(Uri(
                                  scheme: "https",
                                  host: "www13.hpi.uni-potsdam.de",
                                  path:
                                      "fileadmin/user_upload/fachgebiete/lippert/studyme/Imprint.pdf",
                                )),
                              ),
                              const SizedBox(height: 10),
                              OutlinedButton.icon(
                                icon: const Icon(Icons.assignment_outlined),
                                label: const Text('Acknowledgments'),
                                onPressed: () => launchUrl(Uri(
                                  scheme: "https",
                                  host: "www13.hpi.uni-potsdam.de",
                                  path:
                                      "fileadmin/user_upload/fachgebiete/lippert/studyme/Acknowledgments.pdf",
                                )),
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: _currentPage > 0 ? 1 : 0,
                  child: RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        _acceptedTerms = false;
                        _acceptedPrivacy = false;
                      });
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    elevation: 2.0,
                    fillColor: Colors.blueGrey,
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator()),
                Opacity(
                  opacity: _isAtEnd() && !(_acceptedTerms && _acceptedPrivacy)
                      ? 0
                      : 1,
                  child: RawMaterialButton(
                    onPressed: () {
                      if (_isAtEnd()) {
                        if (_acceptedTerms && _acceptedPrivacy) {
                          _navigateToCreator();
                        } else {
                          return;
                        }
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    elevation: 2.0,
                    fillColor: _isAtEnd() ? Colors.green : Colors.blueGrey,
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                    child: Icon(_isAtEnd() ? Icons.check : Icons.arrow_forward,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _isAtEnd() {
    return _currentPage == _numPages - 1;
  }

  _navigateToCreator() {
    Provider.of<AppData>(context, listen: false)
        .addStepLogForSurvey('complete onboarding');
    Provider.of<AppData>(context, listen: false)
        .saveAppState(AppState.CREATING_DETAILS);
    Navigator.pushReplacementNamed(context, Routes.creator);
  }
}
