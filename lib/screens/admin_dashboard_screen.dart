import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/order.dart';
import 'package:bastah/models/product.dart';
import 'package:bastah/screens/admin_login_screen.dart';
import 'package:bastah/services/auth_service.dart';
import 'package:bastah/services/order_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    hide Order; // Hide Order to resolve ambiguity
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bastah/l10n/app_localizations_utils.dart'; // Import for translateOrderStatus
import 'package:bastah/screens/category_management_screen.dart';
import 'package:bastah/screens/product_management_screen.dart';
import 'package:bastah/screens/order_management_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final OrderService _orderService = OrderService();
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async {
        final bool? shouldSignOut = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(appLocalizations.signOutConfirmationTitle),
            content: Text(appLocalizations.signOutConfirmationMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(appLocalizations.cancelButtonText),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(appLocalizations.signOutButtonText),
              ),
            ],
          ),
        );
        if (shouldSignOut == true) {
          await AuthService().signOut();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizations.adminDashboardTitle)),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: Text(
                  appLocalizations.adminPanelTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: Text(appLocalizations.adminDashboardTitle),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Already on dashboard, no need to navigate
                },
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: Text(appLocalizations.categoryManagementTitle),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CategoryManagementScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.production_quantity_limits),
                title: Text(appLocalizations.productManagementTitle),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProductManagementScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: Text(appLocalizations.orderManagementTitle),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrderManagementScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(appLocalizations.settingsTitle),
                onTap: () {
                  // Navigate to Settings Screen
                  Navigator.pop(context); // Close the drawer
                  // TODO: Implement navigation to Settings Screen
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.dashboardSummaryTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              _buildSummaryCards(appLocalizations),
              const SizedBox(height: 32.0),
              Text(
                appLocalizations.dashboardSalesChartTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              _buildSalesChart(appLocalizations),
              const SizedBox(height: 32.0),
              Text(
                appLocalizations.dashboardRecentOrdersTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              _buildRecentOrders(appLocalizations),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(AppLocalizations appLocalizations) {
    return StreamBuilder<List<Order>>(
      stream: _orderService.getAllOrders(),
      builder: (context, orderSnapshot) {
        if (orderSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final List<Order> orders = orderSnapshot.data ?? [];
        final int totalOrders = orders.length;
        final double totalRevenue = orders.fold(
          0.0,
          (currentSum, order) => currentSum + order.totalAmount,
        );

        return StreamBuilder<List<Product>>(
          stream: _productService.getProducts(),
          builder: (context, productSnapshot) {
            if (productSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<Product> products = productSnapshot.data ?? [];
            final int totalProducts = products.length;

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildSummaryCard(
                  context,
                  appLocalizations.totalOrdersLabel,
                  totalOrders.toString(),
                  Icons.shopping_bag,
                  Colors.blueAccent,
                ),
                _buildSummaryCard(
                  context,
                  appLocalizations.totalRevenueLabel,
                  '\$${totalRevenue.toStringAsFixed(2)}',
                  Icons.attach_money,
                  Colors.green,
                ),
                _buildSummaryCard(
                  context,
                  appLocalizations.totalProductsLabel,
                  totalProducts.toString(),
                  Icons.category,
                  Colors.orange,
                ),
                _buildSummaryCard(
                  context,
                  appLocalizations.totalCustomersLabel,
                  'N/A', // Placeholder for now
                  Icons.people,
                  Colors.purple,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32.0, color: color),
            const SizedBox(height: 8.0),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesChart(AppLocalizations appLocalizations) {
    // Dummy data for sales over the last 7 days
    final List<FlSpot> spots = [
      const FlSpot(0, 3),
      const FlSpot(1, 5),
      const FlSpot(2, 3.5),
      const FlSpot(3, 6),
      const FlSpot(4, 4),
      const FlSpot(5, 7),
      const FlSpot(6, 5),
    ];

    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const style = TextStyle(
                        color: Color(0xff68737d),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      );
                      String text;
                      switch (value.toInt()) {
                        case 0:
                          text = appLocalizations.dayMon;
                          break;
                        case 1:
                          text = appLocalizations.dayTue;
                          break;
                        case 2:
                          text = appLocalizations.dayWed;
                          break;
                        case 3:
                          text = appLocalizations.dayThu;
                          break;
                        case 4:
                          text = appLocalizations.dayFri;
                          break;
                        case 5:
                          text = appLocalizations.daySat;
                          break;
                        case 6:
                          text = appLocalizations.daySun;
                          break;
                        default:
                          text = '';
                          break;
                      }
                      return SideTitleWidget(
                        space: 8.0,
                        meta: meta,
                        child: Text(text, style: style),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              minX: 0,
              maxX: 6,
              minY: 0,
              maxY: 8,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentOrders(AppLocalizations appLocalizations) {
    return StreamBuilder<List<Order>>(
      stream: _orderService.getRecentOrders(), // Use the optimized function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final List<Order> recentOrders = snapshot.data ?? [];
        if (recentOrders.isEmpty) {
          return Center(child: Text(appLocalizations.noOrdersFound));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentOrders.length,
          itemBuilder: (context, index) {
            final order = recentOrders[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                title: Text('${appLocalizations.orderIdLabel}: ${order.id}'),
                subtitle: Text(
                  '${appLocalizations.customerNameLabel}: ${order.customerName} - '
                  '${appLocalizations.totalAmountLabel}: \$${order.totalAmount.toStringAsFixed(2)}',
                ),
                trailing: Chip(
                  label: Text(
                    appLocalizations.translateOrderStatus(order.status),
                  ),
                  backgroundColor: order.status == 'delivered'
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
