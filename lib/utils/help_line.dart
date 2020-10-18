import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpData {
  List<Help> helplines;

  HelpData({this.helplines});

  HelpData.fromJson(Map<String, dynamic> json) {
    if (json['helplines'] != null) {
      helplines = new List<Help>();
      json['helplines'].forEach((v) {
        helplines.add(Help.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.helplines != null) {
      data['helplines'] = this.helplines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Help {
  String name;
  String desc;
  String image;
  String subtitle;
  Icon icon;
  IconButton onPressed;

  Help({
    this.name,
    this.desc,
    this.subtitle,
    this.image,
    this.icon,
    this.onPressed,
  });

  Help.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    subtitle = json['desc'];
    image = json['image'];
    icon = json['icon'];
    onPressed = json['onPressed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['subtitle'] = this.subtitle;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['onPressed'] = this.onPressed;
    return data;
  }
}

List<Help> helplines = [
  Help(
    name: "Corona Cases Hotline",
    desc: "Call the Hotline to inform those who with symptoms similar to Coronavirus and to know the details.",
    subtitle: "Get info on COVID-19",
    image: "https://www.news.lk/media/k2/items/cache/f9367eee27a05cdbb03282948502fa88_XL.jpg",
    onPressed: IconButton(
      color: Colors.green,
      icon: Icon(
        FontAwesomeIcons.phoneAlt,
        size: 50.0,
      ),
      onPressed: () => callNcdc(),
    ),
  ),
  Help(
    name: "Police Emergency Hotline",
    desc: "Special hotline for public complaints and to curtail the spread of COVID-19",
    subtitle: "Get info on COVID-19",
    image: "https://adaderanaenglish.s3.amazonaws.com/1585752970-Sri-Lanka-Police-Emblem-B.jpg",
    onPressed: IconButton(
      color: Colors.green,
      icon: Icon(
        FontAwesomeIcons.phoneAlt,
        size: 50.0,
      ),
      onPressed: () => callNcdc1(),
    ),
  ),
  Help(
    name: "Ambulance and Fire Service",
    desc: "Call us for your emergency via our direct number - 011-2422222",
    subtitle: "Get Emergency Ambulance and Fire services",
    image: "https://scontent-lga3-2.xx.fbcdn.net/v/t1.0-1/p200x200/11390322_785529654899118_3623378449849767857_n.jpg?_nc_cat=109&_nc_sid=dbb9e7&_nc_ohc=Y4AFQ3tkOX4AX9T8FFA&_nc_ht=scontent-lga3-2.xx&tp=6&oh=4f42d050736de1056f61f34f3fc1deea&oe=5F78A10D",
    onPressed: IconButton(
      color: Colors.green,
      icon: Icon(
        FontAwesomeIcons.phoneAlt,
        size: 50.0,
      ),
      onPressed: () => callNcdc2(),
    ),
  ),
  Help(
    name: "Accident Service-General Hospital-Colombo",
    desc: "Call us for your emergency via our direct number - 011-2691111",
    subtitle: "Get Emergency Ambulance services",
    image: "https://thumbs.dreamstime.com/z/hospital-logo-icon-hospital-logo-icon-135146804.jpg",
    onPressed: IconButton(
      color: Colors.green,
      icon: Icon(
        FontAwesomeIcons.phoneAlt,
        size: 50.0,
      ),
      onPressed: () => callNcdc3(),
    ),
  ),
];

Future<void> callNcdc() async {
  const url = 'tel://1390';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> callNcdc1() async {
  const url = 'tel://119';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> callNcdc2() async {
  const url = 'tel://011-2422222';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> callNcdc3() async {
  const url = 'tel://011-2691111';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// NCDC toll free number 080097000010