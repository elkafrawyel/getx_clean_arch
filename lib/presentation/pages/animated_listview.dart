import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AnimatedListViewScreen extends StatefulWidget {
  const AnimatedListViewScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedListViewScreen> createState() => _AnimatedListViewScreenState();
}

class _AnimatedListViewScreenState extends State<AnimatedListViewScreen> {
  // Items in the list
  final _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  // Add a new item to the list
  // This is trigger when the floating button is pressed
  void _addItem() {
    _items.add("Item ${_items.length + 1}");
    _key.currentState!.insertItem(_items.length - 1, duration: const Duration(milliseconds: 300));
  }

  // Remove an item
  // This is trigger when an item is tapped
  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            color: Colors.red,
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text("Goodbye", style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );

    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated ListView'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          return Future.value();
        },
        child: AnimatedList(
          key: _key,
          initialItemCount: _items.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (_, index, animation) {
            return SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(10),
                elevation: 10,
                color: Colors.orange,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  title: Text(_items[index], style: const TextStyle(fontSize: 24, color: Colors.white)),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () => _removeItem(index),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
