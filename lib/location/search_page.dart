import 'package:flutter/material.dart';
import 'package:parkz/location/component/location_suggestion_widget.dart';
import 'package:parkz/location/component/search_loading_widget.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/constanst.dart';

import '../model/location_response.dart';

class AddressSearch extends SearchDelegate<LocationSuggestion> {
  AddressSearch() : super(
      searchFieldLabel: "Điểm đến của bạn là ...",
      searchFieldStyle: const TextStyle(
        color: AppColor.forText,
        fontSize: 16,
      )
  );
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
      builder: (context, snapshot) => query == '' ? const SizedBox()

          : snapshot.hasData

          ? ListView.builder(
        itemBuilder: (context, index) =>
            LocationSuggestionWidget(
              address: snapshot.data![index].displayName!,
              function: () {close(context, snapshot.data![index]);},
            ),
        itemCount: snapshot.data?.length,
      )

          : const SearchLoadingWidget(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: fetchSuggestions(query),
      builder: (context, snapshot) => query == '' ? const SizedBox()

          : snapshot.hasData

          ? ListView.builder(
        itemBuilder: (context, index) =>
            LocationSuggestionWidget(
              address: snapshot.data![index].displayName!,
              function: () {close(context, snapshot.data![index]);},
            ),
        itemCount: snapshot.data?.length,
      )

          : const SearchLoadingWidget(),
    );
  }
}

