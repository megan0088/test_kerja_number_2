import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
    } else {
      handleInvalidPermissions(permissionStatus);
    }
  }

  handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      print("Access to the contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      print("Contact permission permanently denied");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
      filteredContacts = contacts; // Load all contacts initially
    });
  }

  void filterContacts(String query) {
    List<Contact> filteredList = contacts.where((contact) {
      String displayName = contact.displayName!.toLowerCase();
      return displayName.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredContacts = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? result = await showSearch(
                context: context,
                delegate: _ContactSearchDelegate(),
              );
              if (result != null && result.isNotEmpty) {
                filterContacts(result);
              }
            },
          ),
        ],
      ),
      body: filteredContacts.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                Contact contact = filteredContacts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(contact.initials()),
                    ),
                    title: Text(contact.displayName ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (contact.phones!.isNotEmpty)
                          Text("Phone: ${contact.phones?.first.value}"),
                        if (contact.emails!.isNotEmpty)
                          Text("Email: ${contact.emails?.first.value}"),
                      ],
                    ),
                    onTap: () {
                      // Add functionality when item is tapped here
                    },
                  ),
                );
              },
            ),
    );
  }
}

class _ContactSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show direct search results (not needed to be implemented here)
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show search suggestions as the user types
    return Container();
  }
}
