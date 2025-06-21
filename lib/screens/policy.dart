import 'package:flutter/material.dart';

class ChildPolicy extends StatefulWidget {
  const ChildPolicy({super.key});

  @override
  State<ChildPolicy> createState() => _ChildPolicyState();
}

class _ChildPolicyState extends State<ChildPolicy> {
  bool isChecked=false;
  bool showWarning = false;
  @override

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Child Protection Policy',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      content: SizedBox(
        height: screenHeight * 0.6,
        width: screenWidth * 0.9,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'This ',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Child Protection Policy (CPP)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' is especially created in the context of the ',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: '“ATL Mentorship Program”',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " being implemented in the State of Andhra Pradesh. The interpretation of any alleged incident of violation of a child's right to protection, in so far as it contextually applies to this program and any recommendations of corrective and /or punitive actions, would be based on various relevant definitions provided in the organization’s policy on Redressal (subject to following the redressal process).",
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              SizedBox(height: 10),
              Text("FOR EMPLOYEES / VOLUNTEERS / VISITORS",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              SizedBox(height: 10),
              Text("Why are we asking you to read and sign this?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                "“ATL Mentorship Program” is being implemented in all the secondary government schools of Andhra Pradesh. Ensuring child safety at all times is at the core of the program. We need to make sure that the surroundings are safe and that adult (and the children themselves) does not violate any of the codes of dignity and protection.",
                style: TextStyle(fontSize: 16),),
              SizedBox(height: 10),
              Text(
                "This Child Protection Policy (CPP) is based on the principles of the United Nation's Universal Declaration of the Rights of the Child, - a declaration India signed in November 1999, POCSO, Central and State Government Child Protection Laws. These laws make India answerable to its children in terms of making sure every child is protected from abuse as specified below.",
                style: TextStyle(fontSize: 16),),
              SizedBox(height: 10),
              Text(
                "“States Parties shall protect the child from all forms of physical or mental violence, injury or abuse, neglect, maltreatment or exploitation, including sexual abuse.” [UN Convention on the Rights of the Child (1989), Article 19] We would request you to adhere to the Code of Conduct while participating in the programme / event.",
                style: TextStyle(fontSize: 16),),
              SizedBox(height: 10),
              Text("Code of Conduct:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,),
              Text(
                "The principle behind this code of conduct is that employees / volunteers / visitors should avoid actions or behavior (both online and in person) which may constitute poor practice or potentially abusive behavior.",
                style: TextStyle(fontSize: 16),),
              SizedBox(height: 10),

              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Employees / Volunteers / Visitors must ',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'NEVER:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]
              )),
              SizedBox(height: 10),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '1.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Hi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' or otherwise physically assault or physically abuse children and develop physical / sexual relationships with children and develop relationships with children that could in any way be deemed exploitative or abusive.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '2.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Act',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' in ways that may be abusive or may place a child at risk of abuse and use language, make suggestions or offer advice which is inappropriate, offensive or abusive.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '3.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Behave',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' physically in a manner which is inappropriate or sexually provocative and do things for children that is personal in nature that they can do for themselves.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '4.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Condone',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' (or participate in condoning) behavior of children which is illegal, unsafe or abusive and act in ways intended to shame, humiliate, belittle or degrade children, or otherwise perpetrate any form of emotional abuse.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '5.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Discriminate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' against, show differential treatment, or favour particular children to the exclusion of others and carry any separate snacks or refreshments for yourself during sessions unless advised by the organization.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '6.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Take photographs',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' of the children during the session without prior permission and counsel children on a one-on-one basis unless you are authorized by the organization to do so.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '7.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Conduct',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' any games / sports activities with the children unless your organization authorizes you to do so and make promises you cannot keep.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '8.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Share',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' your phone numbers, email address or postal address to children and take personal numbers, address of the children. Your contact point with the children is your organization.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '9.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Show',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' inappropriate content, use foul language, inappropriate words, tease and ridicule, humiliate, bully, harass, or punish any children. Always report problems and issues to your organization.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '10.',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Participate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' in physical or sexually provocative games, any form of inappropriate touching, use of inappropriate language, sexually suggestive comments even in fun, reducing a child to tears as a form of control, doing things of a personal nature for children that they can do for themselves.',
                  style: TextStyle(fontSize: 16),
                ),
              ]
              )), SizedBox(height: 10),
              Text("Do:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,),
              SizedBox(height: 10),
              Text(
                "1.Be alert and support your organization to protect children from any physical, emotional or sexual injury or harm.",
                style: TextStyle(fontSize: 16),),
              Text(
                "2.Be a good role model – do not smoke, drink alcohol, take drugs, consume paan / ghutka / misri in the presence of children.",
                style: TextStyle(fontSize: 16),),
              Text(
                "3.Respect the surroundings – littering, spitting, defacing plants and the physical environment in any way is against the organization’s ethic.",
                style: TextStyle(fontSize: 16),),
              Text(
                "4.Be warm, friendly and caring towards children and inform your organization in advance if you want to provide children with snacks or refreshments.",
                style: TextStyle(fontSize: 16),),
              Text(
                "5.If you feel the need to conduct an unplanned activity with the group or a child such as administer first-aid or giving children gifts / treats, please keep informed to your organization.",
                style: TextStyle(fontSize: 16),),
              Text(
                "6.Recognize the developmental needs and capacities of children. Avoid excessive training or competition and pushing them against their will.",
                style: TextStyle(fontSize: 16),),
              Text(
                "7.Adhere to the time schedules and wear clothing and shoes that are appropriate for the occasion.",
                style: TextStyle(fontSize: 16),),
              Text(
                "8.Treat all children equally with respect and dignity and be sensitive to the issues of children who are especially vulnerable in given contexts. For instance, girl children, children with disabilities, children from backward socio economic groups etc.",
                style: TextStyle(fontSize: 16),),
              Text(
                "9.Maintain a safe and appropriate distance with children and do not sleep in close proximity to children.",
                style: TextStyle(fontSize: 16),),
              Text(
                "10.Provide appropriate privacy to children when they are using the bathroom / toilets.",
                style: TextStyle(fontSize: 16),),
              Text(
                "11.If you notice anything, activity, context , practice, which is harmful to the overall protection of children, please inform concern authorities available at school level, including, informing or calling Child Helpline 1098 or local police 100.",
                style: TextStyle(fontSize: 16),),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                        if (isChecked) showWarning = false;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                          if (isChecked) showWarning = false;
                        });

                      },
                      child:  Text(
                        'I agree to the Terms & Conditions',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: showWarning ? Colors.red : Colors.transparent,),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (){
                    if(isChecked==true){
                      ScaffoldMessenger.of(Navigator.of(context, rootNavigator: true).context).showSnackBar(
                        const SnackBar(
                          content: Text('Proceeding to next step...'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pop(context);
                      });

                    }
                    else{
                      setState(() {
                        showWarning = true;
                      });
                    }
                  },
                  child: Text('Next',
                    style: TextStyle(
                        color: Colors.white),))
            ],

          ),
        ),
      ),
    );
  }
}