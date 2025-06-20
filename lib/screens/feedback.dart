import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  Future<void> submitFeedback() async {
    try {
      final request = GraphQLRequest<String>(
        document: '''mutation CreateFeedback(\$input: CreateFeedbackInput!) {
          createFeedback(input: \$input) {
            id
            name
            rollNo
            feedback
          }
        }''',
        variables: {
          "input": {
            "name": nameController.text,
            "rollNo": rollNoController.text,
            "feedback": feedbackController.text,
          },
        },
      );

      final response = await Amplify.API.mutate(request: request).response;

      if (response.errors.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Feedback submitted!")));
        nameController.clear();
        rollNoController.clear();
        feedbackController.clear();
      } else {
        print("GraphQL errors: ${response.errors}");
      }
    } catch (e) {
      print("Submission failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: rollNoController,
                decoration: InputDecoration(labelText: 'Roll No'),
                validator: (val) => val!.isEmpty ? 'Enter roll no' : null,
              ),
              TextFormField(
                controller: feedbackController,
                decoration: InputDecoration(labelText: 'Feedback'),
                maxLines: 3,
                validator: (val) => val!.isEmpty ? 'Enter feedback' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitFeedback();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}