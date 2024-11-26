import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../bloc/home_bloc.dart';
import '../datasources/datasource.dart';
import '../models/employee_model.dart';
import '../services/employees_service.dart';
import '../services/search_service.dart';
import '../utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc? homeBloc;

  @override
  void didChangeDependencies() {
    final DataSource datasource = Provider.of<DataSource>(context);
    final employeeService = EmployeesService(datasource);
    homeBloc = HomeBloc(
      employeeService: employeeService,
      searchService: SearchService(),
    )..fetch();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    homeBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: BeTheme.whiteNeutral,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 18,
                  right: 18,
                  bottom: 36,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundColor: BeTheme.grayNeutral,
                      radius: 30,
                      child: Text("CG"),
                    ),
                    Badge(
                      label: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          '02',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      backgroundColor: BeTheme.bluePrimary,
                      textColor: BeTheme.whiteNeutral,
                      child: SvgPicture.asset('assets/bell-notification.svg'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 15),
                      child: const Text(
                        "Funcionários",
                        style: TextStyle(
                          fontSize: 24,
                          color: BeTheme.blackNeutral,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: SearchBar(
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        elevation: WidgetStateProperty.all(0),
                        backgroundColor: WidgetStateProperty.all(
                          BeTheme.gray5Neutral,
                        ),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        leading: SvgPicture.asset("assets/search.svg"),
                        hintText: "Pesquisar",
                        onSubmitted: (value) {
                          log(value);
                          homeBloc?.search(value);
                        },
                      ),
                    ),
                    Container(
                      height: 47,
                      decoration: BoxDecoration(
                        color: BeTheme.blue100,
                        border: Border.all(
                          color: BeTheme.gray10Neutral,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Text(
                              "Foto",
                              style: TextStyle(
                                fontSize: 16,
                                color: BeTheme.blackNeutral,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Text(
                            "Nome",
                            style: TextStyle(
                              fontSize: 16,
                              color: BeTheme.blackNeutral,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Um circulo preto
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.only(right: 38),
                                  decoration: const BoxDecoration(
                                    color: BeTheme.blackNeutral,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: homeBloc?.state,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LinearProgressIndicator(),
                          );
                        }

                        final state = snapshot.data as HomeState;

                        return switch (state) {
                          HomeStateIdle() =>
                            _buildEmployeeList(state.employees),
                          HomeStateError() => const Center(
                              child: Text(
                                "Erro ao carregar os funcionários",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          HomeStateLoading() => const Center(
                              child: LinearProgressIndicator(),
                            ),
                        };
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildEmployeeList(List<EmployeeModel> employees) {
    return Column(
      children: List.generate(
        employees.length,
        (index) {
          return Column(
            children: [
              EmployeeTile(employee: employees[index]),
              const Divider(
                color: BeTheme.gray10Neutral,
                thickness: 1,
                height: 1,
              )
            ],
          );
        },
      ),
    );
  }
}

class EmployeeTile extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeTile({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final isExpanded = ValueNotifier(false);
      final controller = ExpansionTileController();

      return DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: BeTheme.gray10Neutral,
              width: 1,
            ),
          ),
        ),
        child: ExpansionTile(
          controller: controller,
          shape: const Border(),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(employee.image),
          ),
          title: Text(employee.name),
          trailing: ValueListenableBuilder(
            valueListenable: isExpanded,
            builder: (context, value, child) {
              if (value) {
                return const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  size: 40,
                );
              } else {
                return const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 40,
                );
              }
            },
          ),
          onExpansionChanged: (value) {
            isExpanded.value = value;
          },
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Cargo",
                        style: TextStyle(
                          color: BeTheme.blackNeutral,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        employee.job,
                        style: const TextStyle(
                          color: BeTheme.blackNeutral,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: DashedLinePainter(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Data de admissão",
                        style: TextStyle(
                          color: BeTheme.blackNeutral,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(employee.admissionDate),
                        style: const TextStyle(
                          color: BeTheme.blackNeutral,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: DashedLinePainter(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Telefone",
                        style: TextStyle(
                          color: BeTheme.blackNeutral,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        employee.phone,
                        style: const TextStyle(
                          color: BeTheme.blackNeutral,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: DashedLinePainter(),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 4, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = BeTheme.gray10Neutral
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
