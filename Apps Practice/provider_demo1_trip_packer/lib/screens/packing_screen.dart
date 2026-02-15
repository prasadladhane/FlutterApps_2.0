import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:provider_demo1_trip_packer/providers/packing_provider.dart";
import "package:provider_demo1_trip_packer/providers/theme_provider.dart";

class PackingScreen extends StatefulWidget{
  const PackingScreen({super.key});

  @override
  State createState()=>_PackingScreenState();
}
class _PackingScreenState extends State<PackingScreen>{

  final TextEditingController _itemController=TextEditingController();

  @override
  Widget build(BuildContext context){

    final packingProvider=Provider.of<PackingProvider>(context);
    final themeProvider=Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text("Trip Packer App"),
        backgroundColor: Colors.teal,
        actions: [
          Row(
            children: [
              const Icon(Icons.light_mode),
              Switch(
                value:themeProvider.isDark,
                onChanged: (_)=>themeProvider.toggleTheme(),
              ),
              const Icon(Icons.dark_mode),
            ],
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:_itemController,
              decoration: InputDecoration(
                labelText: "Enter item",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    packingProvider.addItem(_itemController.text);
                    _itemController.clear();
                  },
                ),
              ),
            ),
            const SizedBox(height:20),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: packingProvider.items.length,
                itemBuilder: (_,index){
                  final item=packingProvider.items[index];
                  return ListTile(
                    title:Text(
                      item.name,
                      style:TextStyle(
                        decoration: item.isPacked ? TextDecoration.lineThrough : TextDecoration.none,
                      )
                    ),
                    leading:Checkbox(
                      value: item.isPacked, 
                      onChanged: (_)=> packingProvider.togglePackedStatus(index),
                    ),
                    trailing: IconButton(
                      onPressed: ()=>packingProvider.removeItem(index),
                      icon: const Icon(Icons.delete)
                    ),
                  );
                }
              ),
            )
          ],
        ),
      )
    );
  }
}