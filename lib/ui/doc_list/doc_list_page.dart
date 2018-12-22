import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/doc_list_bloc.dart';
import 'package:mental_healthcare_app/logic/doc_list/doctor.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/contact_helper.dart';

/// * This is the Whole page for psychiatrist list.
/// Contains a list with each psychiatrist's name and a short description.
///
/// TODO: Connect with a database to retrieve data.
class DocListPage extends StatelessWidget {
  DocListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultants/Psychiatrists in Sri Lanka"),
        backgroundColor: theme.UIColors.doctorColor,
      ),
      body: DocListPageContent(DocListBLoC()),
    );
  }
}

/// Contains State of Content.
///
/// At the moment this will also create doctors to hold all doctor info.
///
/// TODO: Remove manually adding to doctors and use Databases instead.
class DocListPageContent extends StatelessWidget {
  final DocListBLoC bloc;

  const DocListPageContent(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Doctor>>(
      stream: this.bloc.doctorStream,
      builder: (_, snapshot) => (snapshot.hasData)
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                Doctor doctor = snapshot.data[index];

                return ExpansionTile(
                  key: Key("Doctor:" + index.toString()),
                  leading: CircleAvatar(
                    backgroundColor: doctor.sex == Sex.MALE
                        ? theme.UIColors.doctorAvatarMaleColor
                        : theme.UIColors.doctorAvatarFemaleColor,
                    child: Icon(
                      doctor.sex == Sex.MALE
                          ? FontAwesomeIcons.male
                          : FontAwesomeIcons.female,
                      color: theme.UIColors.doctorAvatarIconColor,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(doctor.name,
                          style: theme.UITextThemes().doctorNameText),
                      Text(doctor.institute,
                          style: theme.UITextThemes().doctorInstituteText),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ContactButton(
                            icon: FontAwesomeIcons.phone,
                            launchMethod: LaunchMethod.CALL,
                            data: doctor.contactNumber,
                            color: theme.UIColors.doctorCallColor,
                          ),
                          ContactButton(
                            icon: FontAwesomeIcons.comment,
                            launchMethod: LaunchMethod.MESSAGE,
                            data: doctor.contactNumber,
                            color: theme.UIColors.doctorMessageColor,
                          ),
                          ContactButton(
                            icon: FontAwesomeIcons.at,
                            launchMethod: LaunchMethod.MAIL,
                            data: doctor.email,
                            color: theme.UIColors.doctorEmailColor,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class ContactButton extends StatelessWidget {
  final IconData icon;
  final LaunchMethod launchMethod;
  final String data;
  final Color color;

  const ContactButton(
      {@required this.icon,
      @required this.launchMethod,
      this.data,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 40) / 3;
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (data == null)
              ? null
              : () => ContactHelper.launchAction(data, launchMethod),
          child: Container(
            height: 50.0,
            width: width,
            child: Icon(icon),
          ),
        ),
      ),
      color: (data == null) ? theme.UIColors.doctorDisabledColor : color,
    );
  }
}
