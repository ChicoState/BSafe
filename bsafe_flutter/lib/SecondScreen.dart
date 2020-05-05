// SecondScreen.dart -- Samantha

import 'package:flutter/material.dart';
import 'package:BSafe/main.dart';
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/FourthScreen.dart';
import 'package:BSafe/Settings.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<ContactsPage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Contacts' );

  List<Contact> _contacts;

  _ContactsState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this.getContacts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
      drawer: Drawer(
        child: ListView(  
          children: <Widget>[
            DrawerItem(dLeading:Icon(Icons.map), dTitle:"Map", dOnTap:ThirdScreen()),
            DrawerItem(dLeading:Icon(Icons.message), dTitle:"Messaging", dOnTap:FourthScreen()),
            DrawerItem(dLeading:Icon(Icons.timer), dTitle:"Timers", dOnTap:FirstScreen()),
          ]
        )   
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
      return Row(
        children: <Widget>[
           IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: searchPressed,            
          ),  
            IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Homepage',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },            
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
        ],
      );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
        actions: <Widget> [
          _buildActions(context),
        ],
    );
  }

  Widget _buildList() {
    if (_contacts != null) {
      filteredNames = _contacts;
    }

    if (_searchText.isNotEmpty) {
      List tempList = new List();

      for (int i = 0; i < filteredNames?.length; i++) {
        if (filteredNames.elementAt(i).displayName.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames.elementAt(i));
        }
      }

      filteredNames = tempList;
    }

    return Scaffold (
      body: SafeArea(
        child: _contacts != null ? ListView.builder(  
          itemCount: names == null ? 0 : filteredNames?.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(filteredNames.elementAt(index).displayName),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                    ContactDetailsPage(filteredNames.elementAt(index))));
                  },

                  leading: (filteredNames.elementAt(index).avatar != null && filteredNames.elementAt(index).avatar.length > 0)
                    ? CircleAvatar(backgroundImage: MemoryImage(filteredNames.elementAt(index).avatar))
                    : CircleAvatar(child: Text(filteredNames.elementAt(index).initials())),  
       
                ),
                Divider(thickness: 2,),
              ],
            );
          },        
        ) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  void searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Contacts' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void getContacts() async {
     PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);

    if (permission == PermissionStatus.granted) {
      var contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();

      setState(() {
        _contacts = contacts;
        filteredNames = contacts;
      });
      
    } else {
      debugPrint("Permission to access contacts is disabled.");
    }   
  }
}

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage(this._contact);
  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text("Name"),
                  trailing: Text(_contact.givenName ?? ""),
                ),
                Divider(thickness: 2,),
                ListTile(
                  title: Text("Middle name"),
                  trailing: Text(_contact.middleName ?? ""),
                ),
                Divider(thickness: 2,),
                ListTile(
                  title: Text("Family name"),
                  trailing: Text(_contact.familyName ?? ""),
                ),
                Divider(thickness: 2,),
                Addresses(_contact.postalAddresses ?? ""),
                Divider(thickness: 2,),
                Items("Phones", _contact.phones ?? ""),
                Divider(thickness: 2,),
                Items("Emails", _contact.emails ?? "")
              ],
            );
          },
        ),
      ),
    );
  }
}

class Addresses extends StatelessWidget {
  Addresses(this._addresses);
  final Iterable<PostalAddress> _addresses;

  Widget build(BuildContext context) {
    return Column (
      children: <Widget>[
        ListTile(title: Text("Addresses")),
        Column(
          children: _addresses.map((item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Street"),
                  trailing: Text(item.street ?? ""),
                ),
                ListTile(
                  title: Text("Postcode"),
                  trailing: Text(item.postcode ?? ""),
                ),
                ListTile(
                  title: Text("City"),
                  trailing: Text(item.city ?? ""),
                ),
                ListTile(
                  title: Text("Region"),
                  trailing: Text(item.region ?? ""),
                ),
                ListTile(
                  title: Text("Country"),
                  trailing: Text(item.country ?? ""),
                ),
              ],
            ),
          )).toList(),
        )
      ],
    );
  }
}

class Items extends StatelessWidget {
  Items(this._title, this._items);
  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(title: Text(_title)),
        Column(
          children: _items.toSet().map((item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              title: Text(item.label ?? ""),
              trailing: Text(item.value ?? ""),
            ),),
          ).toList(),
        ),
      ],
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContactsPage(),
    );
  }
}
