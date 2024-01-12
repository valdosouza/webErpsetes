import 'package:appweb/app/core/shared/theme.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Documents",
    numOfFiles: 1328,
    svgSrc: "images/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: kPrimaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Google Drive",
    numOfFiles: 1328,
    svgSrc: "images/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: const Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "One Drive",
    numOfFiles: 1328,
    svgSrc: "images/icons/one_drive.svg",
    totalStorage: "1GB",
    color: const Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Documents",
    numOfFiles: 5328,
    svgSrc: "images/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: const Color(0xFF007EE5),
    percentage: 78,
  ),
];
