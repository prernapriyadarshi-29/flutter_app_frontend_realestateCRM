import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testapp1/property_for_list.dart';

class ApiService {
  // Base URL of your Laravel API
  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String baseUrl = 'http://192.168.1.20:8000/api';
  //static const String baseUrl = 'http://127.0.0.1:8000/api';


  // Store the token
  static String? _token;

  // Set token (after login)
  static void setToken(String token) {
    _token = token;
  }

  // Get token
  static String? getToken() {
    return _token;
  }

  // Clear token (on logout)
  static void clearToken() {
    _token = null;
  }

  // Check if user is authenticated
  static bool isAuthenticated() {
    return _token != null;
  }

  // ===== AUTHENTICATION ENDPOINTS =====

  // Register
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'role': role,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
        'errors': {'error': ['Network error']}
      };
    }
  }

  // Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
        'errors': {'error': ['Network error']}
      };
    }
  }

  // Get current user (/me)
  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/me'),
        headers: _getHeaders(),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
        'errors': {'error': ['Network error']}
      };
    }
  }

  // Logout
  static Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: _getHeaders(),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
        'errors': {'error': ['Network error']}
      };
    }
  }

  // ===== HELPER METHODS =====

  // Get headers with Authorization token
  static Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }

  // Handle HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else if (response.statusCode == 401) {
        return {
          'status': false,
          'message': 'Unauthenticated',
          'errors': {'error': ['Unauthenticated']}
        };
      } else if (response.statusCode == 422) {
        return data; // Validation errors
      } else {
        return {
          'status': false,
          'message': data['message'] ?? 'Error occurred',
          'errors': data['errors'] ?? {'error': ['Unknown error']}
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Failed to parse response: $e',
        'errors': {'error': ['Parse error']}
      };
    }
  }

  static Future<Map<String, dynamic>> uploadPropertyPhoto(
  int propertyId,
  String imagePath,
  
) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/properties/$propertyId/photo'),
    );

    request.headers['Accept'] = 'application/json';

    if (_token != null) {
      request.headers['Authorization'] = 'Bearer $_token';
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        imagePath,
      ),
    );

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(
      streamedResponse,
    );

    return _handleResponse(response);
  } catch (e) {
    return {
      'status': false,
      'message': 'Upload failed: $e',
    };
  }
}

// ===== PROPERTY ENDPOINTS =====

  // Get all properties
// Get properties with search and pagination
static Future<Map<String, dynamic>> index({
  String search = '',
  int page = 1,
  int perPage = 10,
}) async {
  try {
    String url = '$baseUrl/properties?page=$page&per_page=$perPage';
    
    if (search.isNotEmpty) {
      url += '&search=${Uri.encodeComponent(search)}';
    }

    print('🔍 Search URL: $url');  // Debug

    final response = await http.get(
      Uri.parse(url),
      headers: _getHeaders(),
    );
    return _handleResponse(response);
  } catch (e) {
    return {
      'status': false,
      'message': 'Network error: $e',
    };
  }
}

  // Create property
  static Future<Map<String, dynamic>> store({
    required String title,
    required int price,
    required String city,
    required String address,
    required int bedrooms,
    required String type,
    required String photo,
    required int status,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/properties'),
        headers: _getHeaders(),
        body: jsonEncode({
          'title': title,
          'price': price,
          'city': city,
          'address': address,
          'bedrooms': bedrooms,
          'type': type,
          'photo': photo,
          'status': status,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Update property
  static Future<Map<String, dynamic>> update(
    int id, {
    required String title,
    required int price,
    required String city,
    required String address,
    required int bedrooms,
    required String type,
    required String photo,
    required int status,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/properties/$id'),
        headers: _getHeaders(),
        body: jsonEncode({
          'title': title,
          'price': price,
          'city': city,
          'address': address,
          'bedrooms': bedrooms,
          'type': type,
          'photo': photo,
          'status': status,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Delete property
  static Future<Map<String, dynamic>> destroy(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/properties/$id'),
        headers: _getHeaders(),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
      };
    }
  }
  // Get dashboard summary
static Future<Map<String, dynamic>> getDashboard() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),
      headers: _getHeaders(),
    );
    return _handleResponse(response);
  } catch (e) {
    return {
      'status': false,
      'message': 'Network error: $e',
    };
  }
}
// Get leads with search and filters
  static Future<Map<String, dynamic>> getLeads({
    String search = '',
    String status = '',
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      String url = '$baseUrl/leads?page=$page&per_page=$perPage';
      
      if (search.isNotEmpty) {
        url += '&search=${Uri.encodeComponent(search)}';
      }
      
      if (status.isNotEmpty) {
        url += '&status=$status';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: _getHeaders(),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Create lead
  static Future<Map<String, dynamic>> createLead({
    required int customerId,
    required int propertyId,
    required String status,
    String? note,
    String? followUpDate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/leads'),
        headers: _getHeaders(),
        body: jsonEncode({
          'customer_id': customerId,
          'property_id': propertyId,
          'status': status,
          'note': note,
          'follow_up_date': followUpDate,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Update lead
  static Future<Map<String, dynamic>> updateLead(
    int id, {
    required String status,
    String? note,
    String? followUpDate,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/leads/$id'),
        headers: _getHeaders(),
        body: jsonEncode({
          'status': status,
          'note': note,
          'follow_up_date': followUpDate,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Delete lead
  static Future<Map<String, dynamic>> deleteLead(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/leads/$id'),
        headers: _getHeaders(),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'status': false,
        'message': 'Network error: $e',
      };
    }
  }

  static Future<List<PropertyForList>> getProperties() async {
  try {
    final token = await _getToken(); // Get saved token
    
    final response = await http.get(
      Uri.parse('$baseUrl/properties?page=1&per_page=100'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data']['data'];
      return data.map((item) => PropertyForList.fromMap(item)).toList();
    }
    throw Exception('Failed to load');
  } catch (e) {
    throw Exception('Error: $e');
  }
}

static Future<String> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token') ?? '';
}
}