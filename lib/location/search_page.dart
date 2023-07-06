import 'package:flutter/material.dart';
import 'package:parkz/network/api.dart';

class AddressSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

 
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: fetchSuggestions(query),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: const Center(child: Text('Nhâp địa điểm bạn muốn đến')),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          // we will display the data returned from our future here
          title:
          Text(snapshot.data![index]),
          onTap: () {
            close(context, snapshot.data![index]);
          },
        ),
        itemCount: snapshot.data?.length,
      )
          : const Text('Tìm kiếm điểm đến ...'),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Tìm kiếm điểm đến ...');
  }
}