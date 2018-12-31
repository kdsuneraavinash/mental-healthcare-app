import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/doc_list_bloc.dart';
import 'package:mental_healthcare_app/localization/localization.dart';
import 'package:mental_healthcare_app/logic/doc_list/doctor.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/contact_helper.dart';

/// TODO: Connect with a database to retrieve data.
class DocListPage extends StatelessWidget {
  DocListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizationProvider.of(context)
            .localization
            .consultantsAppBarTitle),
        backgroundColor: theme.UIColors.primaryColor,
      ),
      body: DocListPageContent(DocListBLoC()),
    );
  }
}

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
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.UIColors.accentColor,
                    child: Icon(
                      doctor.sex == Sex.MALE
                          ? FontAwesomeIcons.male
                          : FontAwesomeIcons.female,
                      color: theme.UIColors.avatarIconColor,
                    ),
                  ),
                  title: Text(doctor.name),
                  subtitle: Text(doctor.institute),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                            ),
                          ),
                    );
                  },
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
/*

 */

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
    if (data == null) return Container();

    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (data == null)
              ? null
              : () => ContactHelper.launchAction(data, launchMethod),
          child: Container(
            height: 75.0,
            width: MediaQuery.of(context).size.width,
            child: Icon(icon),
          ),
        ),
      ),
      color: (data == null) ? theme.UIColors.doctorDisabledColor : color,
    );
  }
}
