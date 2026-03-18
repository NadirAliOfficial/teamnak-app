import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://web-back-ywoz.onrender.com/api';

class ApiService {
  static Future<List<dynamic>> getProducts() async {
    final res = await http.get(Uri.parse('$baseUrl/products'));
    if (res.statusCode == 200) return jsonDecode(res.body);
    throw Exception('Failed to load products');
  }

  static Future<List<dynamic>> getServices() async {
    final res = await http.get(Uri.parse('$baseUrl/services'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['services'] ?? [];
    }
    throw Exception('Failed to load services');
  }

  static Future<List<dynamic>> getBlogs() async {
    final res = await http.get(Uri.parse('$baseUrl/blogs'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['blogs'] ?? [];
    }
    throw Exception('Failed to load blogs');
  }

  static Future<List<dynamic>> getTestimonials() async {
    final res = await http.get(Uri.parse('$baseUrl/testimonials'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['testimonials'] ?? [];
    }
    throw Exception('Failed to load testimonials');
  }
}
