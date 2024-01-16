import 'package:ab_news_app/services/news_api_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  getData() {
    final api = NewsApiService();
    return api.getTopStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: const Text(
          'AB News',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        // Future that needs to be resolved
        // in order to display something on the Canvas
        future: getData(),
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } 

            // if we got our data
            if (snapshot.hasData) {
              // Extracting data from snapshot object
              final items = snapshot.data as List;

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].title),
                  );
                },
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
