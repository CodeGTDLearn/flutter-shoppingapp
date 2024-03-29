## ShoppingApp Concept-Proof
### Index
* [About the Project](#about-the-project)
* [Layers Architecture](#layers-architecture)
* [Getting Started](#getting-started)
* [Project Sectors](#project-sectors)
* [Built With](#built-with)
* [Observations](#observations)

### About The Project

Shopping App in Flutter is a concept proof of a Shopping App in Flutter. The focus of this app is to apply fundamental
concepts from Flutter Architecture, such as state management, firebase authentication, firebase Realtime Database,
dependency management, route management , etc...

### Layers Architecture

This project use two arcitectures: MVC and MVP. The reason for have two both architectures in only one project is 
simply for testing/learning purpouses. There are many ways to architecture an app in Flutter. The most known is MVC. 

* **_MVC_** architecture pattern aims to separate ‘the areas of work.’ It’s meant to separate ‘the areas of responsibility’ when developing software. With MVC, this means separating ‘the interface’ from ‘the functionality’ from ‘the data’ that makes up the application. To decouple these three major areas in the software allows for efficient modular coding, code reuse, and parallel development:
  - Model: the source for data. In some implementations, it contains the business logic. The layers that belong to this area, are: Entities + Dao + Service
  - View: concerned with how data (not necessarily that in the Model) is displayed in the user interface.
  - Controller: controls what data is displayed, answers to both system or user events, and, in some implementations, contains the business logic.
  * Sources: 
    * [MVC with MobX and Solid](https://www.youtube.com/watch?v=xXfQZSwOwZk)
    * [Flutter + MVC at Last!](https://medium.com/follow-flutter/flutter-mvc-at-last-275a0dc1e730)

* **_MVP_** architecture pattern is a derivation from the MVC pattern wherein the Controller is replaced by the Presenter. The MVP divides an application into three layers:
  * Model: The layers that belong to this area, are: Entities + Dao 
  * View: Idem above
  * Presenter: It is the conexion between Model and View, meaning ot will handle app logic, get data from repository and update view.
  * Sources:
    - [Flutter - MVP Architecture](https://www.youtube.com/watch?v=I2AgSDAEZSE)
    - [Flutter Step2 #3 | Architectures Standards](https://www.youtube.com/watch?v=4KBqWANDbE4&t=1440s)
    - [Flutter MVP demo](https://flutterappworld.com/flutter-mvp-demo/) | [GitHub Repo](https://github.com/yendangn/Flutter-MVP-Demo)


* **_Diagram_**
  ![Screenshot](\assets\images\mvc-mvp.jfif)


### Getting Started

Flutter framework is a pretty new tool in the development world. Even though it has Google as its provider, this
framework should be explored and tested before to be used in actual projects . Hence, the purpose of this project is
test, study, apply, explore Flutter as a definitive crossplatform and crossdevice development strategy.

### Project Sectors

1. Overview
2. Cart
3. Orders
4. Products
5. Login page
6. Custom Widgets
7. Core App

### Built With

1. [Get](https://pub.dev/packages/get)
    - GetX is an extra-light and powerful solution for Flutter. It combines high performance state management,
      intelligent dependency injection, and route management in a quick and practical way. GetX is "4 in 1" package, in
      other words:
        - State management;
        - Route management;
        - Dependency/instance management;
        - Utilities.

2. [Flutter Integration](https://flutter.dev/docs/cookbook/testing/integration/introduction)
    - The Google Oficial package to create Widget Tests, as well as, Functional/UI Tests.
3. [Firebase Realtime Database](https://firebase.google.com/docs/database/)
    - The Firebase Realtime Database. For technical reasons for this project firestore was not the best choice.
4. [S.O.L.I.D.](https://scotch.io/bar-talk/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)
    - The First 5 Principles of Object-Oriented Design
5. [Flutter Staggered Animations](https://pub.dev/packages/flutter_staggered_animations)
    - Easily add staggered animations to your ListView, GridView, Column and Row children as shown in Material Design
      guidelines
6. [JSON annotation](https://pub.dev/packages/json_annotation)
    - Defines the annotations used by json_serializable to create code for JSON serialization and deserialization.
7. [Mobx](https://pub.dev/packages/mobx)
   - Action approach, meaning no-code-generator is being used
   - State-management library that makes it simple to
     connect the reactive data of your application with the UI.
   - Sources:
     - [MVC and MobX](https://www.youtube.com/watch?v=xXfQZSwOwZk)
     - [MobX without code generator](https://www.youtube.com/watch?v=3-IF98geNOI)


## Observations
<!-- AUTO-GENERATED-CONTENT:START (TOC:collapse=true&collapseText="Click to expand") -->
<details>
<summary>"Click to expand"</summary>
<!-- AUTO-GENERATED-CONTENT:END -->

Packages removed:

~~1. [Get_It](https://pub.dev/packages/get_it) - Dependency injection: A simple Service Locator for Dart and Flutter
projects with some additional goodies highly inspired by Splat. One of the strongest point of this libray is taht it
does not need the **context** to work; hence, it can be used in anywhere in the application.~~

~~2. [Flutter_modular](https://pub.dev/packages/flutter_modular) - Modular gives us a structure that allows us to
manage
dependency injection and routes in just one file per module, so we can organize our files with that in mind.~~

 [3. Multidex bug](https://www.youtube.com/watch?v=afW7dAndEyw)
</details>