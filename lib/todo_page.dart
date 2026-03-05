import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final List<String> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF203D2B);
    const beige = Color(0xFFFAF2D5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: emerald,
        title: Text(
          'To‑Do List',
          style: const TextStyle(fontFamily: 'Poppins', color: beige),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFFAF2D5)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: emerald.withOpacity(0.6),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: beige,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter a task',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: beige.withOpacity(0.6),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: beige.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          setState(() {
                            _tasks.add(_controller.text);
                            _controller.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: beige,
                        foregroundColor: emerald,
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.check_circle_outline, color: beige),
                      title: Text(
                        _tasks[index],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: beige,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            _tasks.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
