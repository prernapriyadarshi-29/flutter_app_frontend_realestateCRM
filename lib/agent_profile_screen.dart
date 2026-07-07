
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'routes/app_routes.dart';
import 'services/storage_service.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() =>
      _AgentProfileScreenState();
}

class _AgentProfileScreenState
    extends State<AgentProfileScreen> {
  String name = 'Prerna Priyadarshi';
  String role = 'Senior Agent';
  String email = 'agent@givni.com';
  String phone = '98765 43210';
  String city = 'Patna';
  String propertyCount = '12';
  String leadCount = '34';

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final Color powderyBlueBg =
      const Color(0xFFD6E4F0);
  final Color lightGoldOutline =
      const Color(0xFFE5C158);
  final Color coralWhitish =
      const Color(0xFFFFF5F2);
  final Color cameraBlue =
      const Color(0xFF007AFF);
  final Color buttonMediumBlue =
      const Color(0xFF4A90E2);
  final Color editLightYellow =
      const Color(0xFFFFFDE7);

Future<void> _loadProfile() async {
 final data =
    await StorageService.getCurrentUserData();
  if (data != null) {
    setState(() {
      name = data['name'] ?? name;
      role = data['role'] ?? role;
      email = data['email'] ?? email;
      phone = data['phone'] ?? phone;
      city = data['city'] ?? city;
      propertyCount = data['propertyCount'] ?? propertyCount;
      leadCount = data['leadCount'] ?? leadCount;
    }
    );
  }
}

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage =
              File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Error selecting image: $e',
          ),
        ),
      );
    }
  }

  void _showEditDialog() {
    final nameController =
        TextEditingController(text: name);
    final roleController =
        TextEditingController(text: role);
    final emailController =
        TextEditingController(text: email);
    final phoneController =
        TextEditingController(text: phone);
    final cityController =
        TextEditingController(text: city);
    final propertyController =
        TextEditingController(
            text: propertyCount);
    final leadController =
        TextEditingController(
            text: leadCount);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              editLightYellow,
          title: Text(
            'Edit Profile Details',
            style: TextStyle(
              color: buttonMediumBlue,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          content:
              SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                _buildEditField(
                    nameController,
                    'Name'),
                _buildEditField(
                    roleController,
                    'Role'),
                _buildEditField(
                    emailController,
                    'Email'),
                _buildEditField(
                    phoneController,
                    'Phone'),
                _buildEditField(
                    cityController,
                    'City'),
                _buildEditField(
                  propertyController,
                  'Properties',
                  isNumeric: true,
                ),
                _buildEditField(
                  leadController,
                  'Leads',
                  isNumeric: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                      context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton
                      .styleFrom(
                backgroundColor:
                    buttonMediumBlue,
              ),
              onPressed: () {
                setState(() {
                  name =
                      nameController
                          .text;
                  role =
                      roleController
                          .text;
                  email =
                      emailController
                          .text;
                  phone =
                      phoneController
                          .text;
                  city =
                      cityController
                          .text;
                  propertyCount =
                      propertyController
                          .text;
                  leadCount =
                      leadController
                          .text;
                });

                Navigator.pop(
                    context);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditField(
    TextEditingController
        controller,
    String label, {
    bool isNumeric = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
              vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric
            ? TextInputType.number
            : TextInputType.text,
        decoration:
            InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: buttonMediumBlue,
          ),
          focusedBorder:
              UnderlineInputBorder(
            borderSide: BorderSide(
              color:
                  buttonMediumBlue,
              width: 2,
            ),
          ),
          enabledBorder:
              UnderlineInputBorder(
            borderSide: BorderSide(
              color:
                  buttonMediumBlue
                      .withOpacity(
                          0.5),
            ),
          ),
        ),
      ),
    );
  }

@override
void initState() {
  super.initState();
  _loadProfile();
}
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          powderyBlueBg,
      appBar: AppBar(
  backgroundColor: powderyBlueBg,
  title: const Text(
    'Agent Profile',
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: true,
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.dashboard,
        (route) => false,
      );
    },
  ),
),
      body: SafeArea(
        child: LayoutBuilder(
          builder:
              (context, constraints) {
            return Center(
              child:
                  SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets
                          .all(24),
                  child: Container(
                    constraints:
                        const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  buttonMediumBlue,
                              backgroundImage:
                                  _profileImage !=
                                          null
                                      ? FileImage(
                                          _profileImage!)
                                      : null,
                              child:
                                  _profileImage ==
                                          null
                                      ? const Icon(
                                          Icons
                                              .person,
                                          size:
                                              60,
                                          color:
                                              Colors
                                                  .white,
                                        )
                                      : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child:
                                  CircleAvatar(
                                radius:
                                    20,
                                backgroundColor:
                                    cameraBlue,
                                child:
                                    IconButton(
                                  icon:
                                      const Icon(
                                    Icons
                                        .camera_alt,
                                    size:
                                        18,
                                    color:
                                        Colors
                                            .white,
                                  ),
                                  onPressed:
                                      _pickImage,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 16),
                        Text(
                          name,
                          style:
                              const TextStyle(
                            fontSize: 26,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color: Colors
                                .black87,
                          ),
                        ),
                        Text(
                          role,
                          style:
                              TextStyle(
                            fontSize: 16,
                            color: Colors
                                .grey[700],
                            fontWeight:
                                FontWeight
                                    .w500,
                          ),
                        ),
                        const SizedBox(
                            height: 24),
                        Divider(
                          color:
                              lightGoldOutline
                                  .withOpacity(
                                      0.4),
                        ),
                        const SizedBox(
                            height: 16),
                        _buildOutlineInfoBox(
                            'Email',
                            email),
                        _buildOutlineInfoBox(
                            'Phone',
                            phone),
                        _buildOutlineInfoBox(
                            'City',
                            city),
                        _buildOutlineInfoBox(
                            'Property',
                            propertyCount),
                        _buildOutlineInfoBox(
                            'Leads',
                            leadCount),
                        const SizedBox(
                            height: 16),
                        Divider(
                          color:
                              lightGoldOutline
                                  .withOpacity(
                                      0.4),
                        ),
                        const SizedBox(
                            height: 24),
                        SizedBox(
                          width:
                              double.infinity,
                          child:
                              ElevatedButton
                                  .icon(
                            onPressed:
                                _showEditDialog,
                            icon:
                                const Icon(
                              Icons.edit,
                              color: Colors
                                  .white,
                            ),
                            label:
                                const Text(
                              'Edit Profile',
                              style:
                                  TextStyle(
                                color: Colors
                                    .white,
                                fontSize:
                                    16,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            style:
                                ElevatedButton
                                    .styleFrom(
                              backgroundColor:
                                  buttonMediumBlue,
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                vertical:
                                    16,
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildOutlineInfoBox(
      String label,
      String value) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
              vertical: 6),
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: coralWhitish,
          border: Border.all(
            color: lightGoldOutline,
            width: 1.5,
          ),
          borderRadius:
              BorderRadius.circular(
                  12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                label,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Colors.black87,
                ),
              ),
            ),
            const Text(
              ' :   ',
              style: TextStyle(
                color:
                    Colors.black87,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                  color:
                      Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}