import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/helper/show_snack_bar.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product_service.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_textfield.dart';

class UpdateProductView extends StatefulWidget {
  UpdateProductView({super.key});
  static String id = 'UpdateProductView';

  @override
  State<UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  String? title, description, price, image;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Product'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                CustomTextField(
                  hintText: product.title.substring(0, 6),
                  labelText: 'Product name',
                  onChanged: (p0) {
                    title = p0;
                  },
                ),
                CustomTextField(
                  hintText: product.description,
                  labelText: 'Description',
                  onChanged: (p0) {
                    description = p0;
                  },
                ),
                CustomTextField(
                  hintText: product.price.toString(),
                  labelText: 'Price',
                  onChanged: (p0) {
                    price = p0;
                  },
                  inputType: TextInputType.number,
                ),
                CustomTextField(
                  hintText: product.image,
                  labelText: 'Image',
                  onChanged: (p0) {
                    image = p0;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'Update',
                  onTab: () async {
                    isLoading = true;
                    setState(() {});

                    try {
                      await updateProduct(product);
                      showSnackbar(
                        context,
                        'Success',
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                    isLoading = false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProductService().updateProduct(
      title: title == null ? product.title : title!,
      price: price == null ? product.price.toString() : price!,
      description: description == null ? product.description : description!,
      image: image == null ? product.image : image!,
      category: product.category,
      productId: product.id.toString(),
    );
  }
}
