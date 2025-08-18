import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:digital_business_card/models/business_card.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';
  
  // 獲取用戶的名片
  static Future<BusinessCard?> getUserCard(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cards/$userId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return BusinessCard.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching user card: $e');
      return null;
    }
  }

  // 創建或更新名片
  static Future<BusinessCard?> createOrUpdateCard(BusinessCard card) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cards'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(card.toJson()),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return BusinessCard.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Error creating/updating card: $e');
      return null;
    }
  }

  // 掃描名片（通過ID獲取）
  static Future<BusinessCard?> scanCard(String cardId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cards/scan/$cardId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return BusinessCard.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Error scanning card: $e');
      return null;
    }
  }

  // 獲取名片列表
  static Future<List<BusinessCard>> getCardList() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cards'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> cardsJson = json.decode(response.body);
        return cardsJson.map((json) => BusinessCard.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching card list: $e');
      return [];
    }
  }

  // 刪除名片
  static Future<bool> deleteCard(String cardId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cards/$cardId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting card: $e');
      return false;
    }
  }
}
