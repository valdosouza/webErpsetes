import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard/data/model/analytic_info_model.dart';
import 'package:appweb/app/modules/dashboard/data/model/discussions_info_model.dart';
import 'package:appweb/app/modules/dashboard/data/model/referal_info_model.dart';

List analyticData = [
  AnalyticInfo(
    title: "Quantidade",
    value: "150",
    svgSrc: "images/icons/Post.svg",
    color: kSecondaryColor,
  ),
  AnalyticInfo(
    title: "Valor Total",
    value: "R\$ 20.356,00",
    svgSrc: "images/icons/Post.svg",
    color: kSecondaryColor,
  ),
  AnalyticInfo(
    title: "Ticket Médio",
    value: "R\$ 150,78",
    svgSrc: "images/icons/Post.svg",
    color: kSecondaryColor,
  ),
  AnalyticInfo(
    title: "Total do Custo",
    value: "R\$ 14.249,20",
    svgSrc: "images/icons/Post.svg",
    color: kSecondaryColor,
  ),
  AnalyticInfo(
    title: "Lucro",
    value: "30%",
    svgSrc: "images/icons/Post.svg",
    color: kSecondaryColor,
  ),
];

List discussionData = [
  DiscussionInfoModel(
    imageSrc: "images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "images/images/photo2.jpg",
    name: "Devi Carlos",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "images/images/photo3.jpg",
    name: "Danar Comel",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "images/images/photo4.jpg",
    name: "Karin Lumina",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "images/images/photo5.jpg",
    name: "Fandid Deadan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "images/images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
];

List referalData = [
  ReferalInfoModel(
    title: "Facebook",
    count: 234,
    svgSrc: "images/icons/Facebook.svg",
    color: kPrimaryColor,
  ),
  ReferalInfoModel(
    title: "Twitter",
    count: 234,
    svgSrc: "images/icons/Twitter.svg",
    color: kPrimaryColor,
  ),
  ReferalInfoModel(
    title: "Linkedin",
    count: 234,
    svgSrc: "images/icons/Linkedin.svg",
    color: kPrimaryColor,
  ),
  ReferalInfoModel(
    title: "Dribble",
    count: 234,
    svgSrc: "images/icons/Dribbble.svg",
    color: kPrimaryColor,
  ),
];
