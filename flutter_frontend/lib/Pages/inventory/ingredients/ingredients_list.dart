import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ingredients_add.dart';
import 'ingredients_view.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  List<dynamic> ingredients = [];
  List<dynamic> filteredIngredients = [];
  bool isLoading = true;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    String apiUrl = "http://10.0.2.2:8000/api/ingredients/list/";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          ingredients = jsonDecode(response.body);
          filteredIngredients = ingredients;
          isLoading = false;
        });
      } else {
        print("Failed status: ${response.statusCode}");
        print("Body: ${response.body}");
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load ingredients")),
        );
      }
    } catch (error) {
      print("Error fetching ingredients: $error");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error connecting to server")),
      );
    }
  }

  void searchIngredients(String query) {
    setState(() {
      filteredIngredients = ingredients.where((ingredient) {
        final name = ingredient['ingredient_name'].toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  void clearSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      filteredIngredients = ingredients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search ingredients...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: searchIngredients,
              )
            : const Text("Ingredients", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: clearSearch,
                )
              : IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xFFFFE4E1),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : filteredIngredients.isEmpty
                ? Center(
                    child: Text(
                      "No ingredients found",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = filteredIngredients[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewIngredientScreen(
                                  ingredientId: ingredient['id'].toString(),
                                  name: ingredient['ingredient_name'],
                                  quantity: ingredient['stock'].toString(),
                                  unit: ingredient['unit_of_measurement']
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Color(0xFFB71C1C),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ingredient['ingredient_name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.inventory_2,
                                                  size: 16,
                                                  color: Colors.black54),
                                              SizedBox(width: 4),
                                              Text(
                                                "Stock: ${ingredient['stock']} ${ingredient['unit_of_measurement']}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.warning_amber_rounded,
                                                  size: 16,
                                                  color: Colors.orange),
                                              SizedBox(width: 4),
                                              Text(
                                                "Min Stock: ${ingredient['minimum_stock']}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_today,
                                                  size: 16,
                                                  color: Colors.blueGrey),
                                              SizedBox(width: 4),
                                              Text(
                                                "Expiry: ${ingredient['expiration_date'] ?? 'N/A'}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddIngredientScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
