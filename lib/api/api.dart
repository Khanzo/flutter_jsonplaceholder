// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

library api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_client.dart';

part 'models/users.dart';

part 'models/posts.dart';

part 'models/albums.dart';

part 'models/comments.dart';

part 'models/photos.dart';

ApiClient defaultApiClient = ApiClient();
