import 'package:abdallah_api/modules/news_app/web_view/web_view_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';import 'package:fluttertoast/fluttertoast.dart';


Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:Padding(

        padding: const EdgeInsets.all(15.0),

        child: Row(

          children: [

            Container(

              width: 120.0,

              height: 120.0,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10.0),

                  image: DecorationImage(

                    image: NetworkImage(

                      '${article['urlToImage']}',

                    ),

                    fit: BoxFit.cover,

                  )),

            ),

            SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: Container(

                height: 120.0,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${article['title']}',

                        style: Theme.of(context).textTheme.bodyText1,

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                      ),

                    ),

                    Text(

                      '${article['publishedAt']}',

                      style: TextStyle(

                        color: Colors.grey,

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ],

        ),

      ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      onTap: () {
        onTap!();
      },
      validator: (s) {
        validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list, context) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,),
        fallback: (context) => Container(child: Text('xxxxxxxxx'),),
);

void ShowToast({
  required String text,
  required ToastStates state,
}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastStates{SUCCESS,ERROR,WARING}

Color ChooseToastColor(ToastStates state){
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARING:
      color = Colors.yellow;
      break;
  }
  return color;
}