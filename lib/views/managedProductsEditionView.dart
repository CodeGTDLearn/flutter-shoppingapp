import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/titlesIconsMessages/views/managedProductsEditionView.dart';

class ManagedProductsEditionView extends StatefulWidget {
  @override
  _ManagedProductsEditionViewState createState() => _ManagedProductsEditionViewState();
}

class _ManagedProductsEditionViewState extends State<ManagedProductsEditionView> {
  final _focusPrice = FocusNode();
  final _focusDescr = FocusNode();

  @override
  void dispose() {
    _focusPrice.dispose();
    _focusDescr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(MAN_ADD_APPBAR_TIT),
          actions: <Widget>[IconButton(icon: MAN_SAVE_FORM_APPBAR, onPressed: () {})]),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
//                  initialValue: ,
                decoration: InputDecoration(labelText: MAN_FLD_TIT),
                textInputAction: TextInputAction.next,
                maxLength: 12,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_focusPrice),
              ),
              TextFormField(
//                initialValue: ,
                decoration: InputDecoration(labelText: MAN_FLD_PRICE),
                textInputAction: TextInputAction.next,
                maxLength: 6,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_focusDescr),
//              onSaved: ,
//              validator: ,
              ),
              TextFormField(
//                initialValue: ,
                decoration: InputDecoration(labelText: MAN_FLD_DESCR),
                textInputAction: TextInputAction.next,
                maxLength: 6,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
//              onFieldSubmitted: ,
//              onSaved: ,
//              validator: ,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
