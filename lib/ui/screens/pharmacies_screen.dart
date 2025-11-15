import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pharmacy_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/pharmacy_card.dart';

class PharmaciesScreen extends StatelessWidget {
  const PharmaciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pharmacies', showLogo: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<PharmacyProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.pharmacies.length,
                    itemBuilder: (context, index) {
                      return PharmacyCard(pharmacy: provider.pharmacies[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
