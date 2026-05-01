import 'dart:async';
import 'dart:io';

import 'package:backend/src/app/model/dependencies_container.dart';
import 'package:backend/src/core/database/database.dart';
import 'package:backend/src/core/middleware/authentication.dart';
import 'package:backend/src/server/profile/profile.dart';
import 'package:backend/src/server/student/student.dart';
import 'package:drift/drift.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:backend/src/app/logic/composition_root.dart';
import 'package:backend/src/app/model/application_config.dart';
import 'package:backend/src/core/middleware/error.dart';

void main(List<String> args) async {
  final logger = CreateAppLogger().create();

  await runZonedGuarded(
    () async {
      final dependency = await CompositionRoot(logger: logger).compose();

      ProcessSignal.sigint.watch().listen((_) async {
        await dependency.database.close();
        exit(0);
      });

      final ip = InternetAddress.anyIPv4;

      final protectedRoutes = Pipeline()
          .addMiddleware(corsHeaders())
          .addMiddleware(
            AuthenticationMiddleware.call(
              firebaseAdmin: dependency.firebaseAdmin,
            ),
          )
          .addHandler(
            Cascade()
                .add(dependency.wsRouter.handler)
                .add(dependency.profileRouter.handler)
                .add(dependency.studentRouter.handler)
                .add(dependency.masterRouter.handler)
                .add(dependency.userRouter.handler)
                .add(dependency.dormitoryRouter.handler)
                .add(dependency.specializationRouter.handler)
                .add(dependency.roomRouter.handler)
                .add(dependency.repairRequestRouter.handler.call)
                .add(dependency.chatRouter.handler)
                .add(dependency.messageRouter.handler)
                .add(dependency.materialRouter.handler.call)
                .handler,
          );

      final handlers = Pipeline()
          .addMiddleware(logRequests())
          .addMiddleware(ErrorMiddleware.call(logger, dependency.restApi))
          .addHandler(Cascade().add(protectedRoutes).handler);

      final port = int.parse(Config.port);
      await serve(handlers, ip, port);
    },
    (e, stackTrace) {
      logger.e(e.toString(), stackTrace: stackTrace);
    },
  );
}

Future<void> createSpecializations(DependencyContainer dependency) async {
  await Future.wait([
    dependency.database.specializations.insert().insert(
      SpecializationsCompanion(
        title: Value('Электрик'),
        description: Value(
          '''Специализируется на починке электрических сетей, осветительных приборов, розеток, выключателей и другого электрооборудования. Выполняет диагностику неисправностей, замену поврежденных элементов, подключение и настройку электрических устройств.''',
        ),
        photoUrl: Value('instruments.webp'),
      ),
    ),
    dependency.database.specializations.insert().insert(
      SpecializationsCompanion(
        title: Value('Сантехник'),
        description: Value(
          '''Специализируется на установке, ремонте и обслуживании водопроводных и канализационных систем, сантехнического оборудования и трубопроводов. Выполняет диагностику неисправностей, устранение протечек, замену изношенных деталей, монтаж и подключение сантехнических приборов, а также настройку их корректной работы.''',
        ),
        photoUrl: Value('sink.webp'),
      ),
    ),
    dependency.database.specializations.insert().insert(
      SpecializationsCompanion(
        title: Value('Плотник'),
        description: Value(
          '''Специализируется на изготовлении, ремонте и установке деревянных конструкций и изделий: дверей, окон, мебели, лестниц и других элементов из древесины. Выполняет обработку материалов, сборку и монтаж конструкций, подгонку деталей, а также ремонт и восстановление повреждённых деревянных изделий.''',
        ),
        photoUrl: Value('angle_grinder.webp'),
      ),
    ),
    dependency.database.specializations.insert().insert(
      SpecializationsCompanion(
        title: Value('Протравка'),
        description: Value(
          '''Специализируется на проведении дезинсекции в общежитиях и других местах с высокой плотностью проживания. Выполняет обследование помещений, выявление очагов заражения, обработку жилых комнат безопасными и эффективными средствами, а также даёт рекомендации жильцам по подготовке помещений и предотвращению повторного появления насекомых.''',
        ),
        photoUrl: Value('angle_grinder.webp'),
      ),
    ),
  ]);
}

Future<void> createDormitories(DependencyContainer dependency) async {
  await Future.wait([
    dependency.database
        .into(dependency.database.dormitories)
        .insert(
          DormitoriesCompanion(
            number: Value(1),
            name: Value('Общежитие №1'),
            address: Value('Академгородок, д. 8'),
            lat: Value(55.983655),
            long: Value(92.757674),
          ),
        ),
    dependency.database
        .into(dependency.database.dormitories)
        .insert(
          DormitoriesCompanion(
            number: Value(2),
            name: Value('Общежитие №2'),
            address: Value('Свободный проспект, д. 81'),
            lat: Value(56.000704),
            long: Value(92.773421),
          ),
        ),
    dependency.database
        .into(dependency.database.dormitories)
        .insert(
          DormitoriesCompanion(
            number: Value(3),
            name: Value('Общежитие №3'),
            address: Value('Свободный проспект, д. 83'),
            lat: Value(56.000688),
            long: Value(92.772172),
          ),
        ),
    dependency.database
        .into(dependency.database.dormitories)
        .insert(
          DormitoriesCompanion(
            number: Value(4),
            name: Value('Общежитие №4'),
            address: Value('Свободный проспект, д. 81В'),
            lat: Value(56.000824),
            long: Value(92.774508),
          ),
        ),
    dependency.database
        .into(dependency.database.dormitories)
        .insert(
          DormitoriesCompanion(
            number: Value(5),
            name: Value('Общежитие №5'),
            address: Value('Борисова, д. 24'),
            lat: Value(55.994265),
            long: Value(92.796050),
          ),
        ),
    dependency.database
        .into(dependency.database.dormitories)
        .insert(
          DormitoriesCompanion(
            number: Value(6),
            name: Value('Общежитие №6'),
            address: Value('Борисова, д. 14А'),
            lat: Value(55.993152),
            long: Value(92.791729),
          ),
        ),
    dependency.database
        .into(dependency.database.dormitories)
        .insert(
          DormitoriesCompanion(
            number: Value(30),
            name: Value('Общежитие №30'),
            address: Value('Борисова, д. 3'),
            lat: Value(55.995387),
            long: Value(92.793795),
          ),
        ),
  ]);
}

Future<void> createRooms(DependencyContainer dependency) async {
  await Future.wait([
    dependency.database
        .into(dependency.database.rooms)
        .insert(
          RoomsCompanion(
            dormitoryId: Value(7),
            floor: Value(6),
            number: Value('6-42'),
            isOccupied: Value(true),
          ),
        ),
    dependency.database
        .into(dependency.database.rooms)
        .insert(
          RoomsCompanion(
            dormitoryId: Value(7),
            floor: Value(6),
            number: Value('6-41'),
            isOccupied: Value(true),
          ),
        ),
    dependency.database
        .into(dependency.database.rooms)
        .insert(
          RoomsCompanion(
            dormitoryId: Value(7),
            floor: Value(6),
            number: Value('6-40'),
            isOccupied: Value(true),
          ),
        ),
    dependency.database
        .into(dependency.database.rooms)
        .insert(
          RoomsCompanion(
            dormitoryId: Value(7),
            floor: Value(6),
            number: Value('6-39'),
            isOccupied: Value(true),
          ),
        ),
    dependency.database
        .into(dependency.database.rooms)
        .insert(
          RoomsCompanion(
            dormitoryId: Value(7),
            floor: Value(6),
            number: Value('6-38'),
            isOccupied: Value(true),
          ),
        ),
    dependency.database
        .into(dependency.database.rooms)
        .insert(
          RoomsCompanion(
            dormitoryId: Value(7),
            floor: Value(6),
            number: Value('6-37'),
            isOccupied: Value(true),
          ),
        ),
  ]);
}

Future<void> createStudents(DependencyContainer dependency) async {
  final studentRepository = StudentRepositoryImpl(
    database: dependency.database,
    firebaseApp: dependency.firebaseAdmin,
  );
  await studentRepository.createStudent(
    uid: 'qt5rp4zdNhdtX5YAYlpNCsmXDii2',
    student: PartialStudent(
      user: UserEntity(
        uid: 'qt5rp4zdNhdtX5YAYlpNCsmXDii2',
        displayName: 'Павел Лямин',
        email: 'pavel.lyamin2005@gmail.com',
        phoneNumber: '+79144563446',
        photoURL:
            'https://lh3.googleusercontent.com/a/ACg8ocLitU-DssP2_XkxVZD_FkKiK7DRYErs3Fi_pukOltdrN3zlTQ=s96-c',
        role: .student,
      ),
      roomId: 1,
      dormitoryId: 7,
    ),
  );
}

Future<void> createFirebaseMasters(DependencyContainer dependency) async {
  await Future.wait([
    dependency.firebaseAdmin.auth().createUser(
      email: 'master1@test.com',
      displayName: 'Федор Федоров',
      phoneNumber: '+71234567890',
      password: '(Password123)',
      photoUrl: Uri(
        path: "https://101course.ru/assets/images/electricians.jpg",
      ),
    ),
    dependency.firebaseAdmin.auth().createUser(
      email: 'master2@test.com',
      displayName: 'Александр Александров',
      phoneNumber: '+70987654321',
      password: '(Password123)',
      photoUrl: Uri(path: "https://101course.ru/assets/images/can-teh.jpg"),
    ),
    dependency.firebaseAdmin.auth().createUser(
      email: 'master3@test.com',
      displayName: 'Николай Николаев',
      phoneNumber: '+71357924680',
      password: '(Password123)',
      photoUrl: Uri(
        path:
            "https://s0.rbk.ru/v6_top_pics/media/img/1/02/347248591020021.jpeg",
      ),
    ),
  ]);
}

Future<void> createMasters(DependencyContainer dependency) async {
  await Future.wait([
    dependency.database
        .into(dependency.database.users)
        .insert(
          UsersCompanion(
            uid: Value('l2HstRraMJOxYVG9Gx2gWsTW8gO2'),
            email: Value('master1@test.com'),
            displayName: Value('Федор Федоров'),
            phoneNumber: Value('+71234567890'),
            photoURL: Value(
              "https://101course.ru/assets/images/electricians.jpg",
            ),
            role: Value(Role.master.name),
          ),
        ),
    dependency.database
        .into(dependency.database.users)
        .insert(
          UsersCompanion(
            uid: Value('q5BfvBIhgZVvDyKonNxhr7hZaGF2'),
            email: Value('master2@test.com'),
            displayName: Value('Александр Александров'),
            phoneNumber: Value('+70987654321'),
            photoURL: Value("https://101course.ru/assets/images/can-teh.jpg"),
            role: Value(Role.master.name),
          ),
        ),
    dependency.database
        .into(dependency.database.users)
        .insert(
          UsersCompanion(
            uid: Value('cz3WOJku5ph00sQCYDkL5oNwb703'),
            email: Value('master3@test.com'),
            displayName: Value('Николай Николаев'),
            phoneNumber: Value('+71357924680'),
            photoURL: Value(
              "https://s0.rbk.ru/v6_top_pics/media/img/1/02/347248591020021.jpeg",
            ),
            role: Value(Role.master.name),
          ),
        ),
    dependency.database
        .into(dependency.database.masters)
        .insert(
          MastersCompanion(
            uid: Value('l2HstRraMJOxYVG9Gx2gWsTW8gO2'),
            specId: Value(1),
            dormitoryId: Value(1),
          ),
        ),
    dependency.database
        .into(dependency.database.masters)
        .insert(
          MastersCompanion(
            uid: Value('q5BfvBIhgZVvDyKonNxhr7hZaGF2'),
            specId: Value(2),
            dormitoryId: Value(1),
          ),
        ),
    dependency.database
        .into(dependency.database.masters)
        .insert(
          MastersCompanion(
            uid: Value('cz3WOJku5ph00sQCYDkL5oNwb703'),
            specId: Value(3),
            dormitoryId: Value(1),
          ),
        ),
  ]);
}

Future<void> createFirebaseClaims(DependencyContainer dependency) async {
  await Future.wait([
    dependency.firebaseAdmin.auth().setCustomUserClaims(
      'l2HstRraMJOxYVG9Gx2gWsTW8gO2',
      {'role': Role.master.name},
    ),
    dependency.firebaseAdmin.auth().setCustomUserClaims(
      'q5BfvBIhgZVvDyKonNxhr7hZaGF2',
      {'role': Role.master.name},
    ),
    dependency.firebaseAdmin.auth().setCustomUserClaims(
      'cz3WOJku5ph00sQCYDkL5oNwb703',
      {'role': Role.master.name},
    ),
  ]);
}

Future<void> createMaterials(DependencyContainer dependency) async {
  await Future.wait([
    dependency.database
        .into(dependency.database.materialTypes)
        .insert(MaterialTypesCompanion.insert(name: 'Электрика')),
    dependency.database
        .into(dependency.database.materialTypes)
        .insert(MaterialTypesCompanion.insert(name: 'Фурнитура')),
    dependency.database
        .into(dependency.database.materialTypes)
        .insert(MaterialTypesCompanion.insert(name: 'Сантехника')),
  ]);
  await Future.wait([
    dependency.database
        .into(dependency.database.materials)
        .insert(
          MaterialsCompanion.insert(
            typeId: 1,
            name: 'Лампа светодиодная LED',
            description:
                'Тип колбы — A60; цоколь — E27; мощность — 10 Вт; цветовая температура — 4000 K; световой поток — 850–900 лм; напряжение — 175–250 В; габариты — около 60×60×117 мм.',
            photoPath: 'lamp.webp',
            quantity: 48,
          ),
        ),
    dependency.database
        .into(dependency.database.materials)
        .insert(
          MaterialsCompanion.insert(
            typeId: 2,
            name: 'Ручка дверная на планке 85 мм, хром',
            description:
                'Тип — на планке (розеточная); межцентровое расстояние — 85 мм; материал — сплав цинка (Zamak); покрытие — хром (глянцевый); ширина планки (розетки) — стандарт 18–20 мм; глубина установки — под стандартный квадрат 8 мм; комплектация — винты, ключ-шестигранник, ответная планка (защёлка в комплект не входит); габариты (общая длина ручки) — около 130×60×60 мм.',
            photoPath: 'door_handle.webp',
            quantity: 48,
          ),
        ),
    dependency.database
        .into(dependency.database.materials)
        .insert(
          MaterialsCompanion.insert(
            typeId: 3,
            name: 'Смеситель для раковины',
            description:
                'Тип — шаровой; материал корпуса — латунь ЦАМ (ЦАМ 4-1); длина излива — 125 мм; высота общая — 230 мм; высота до излива — 120 мм; вращение излива — 360°; аэратор — есть, перлатор (экономия до 30% воды); покрытие — хром (электрохимическое); диаметр стакана — 35 мм; гибкая подводка — 2 шт. (длина 500 мм); давление — от 0,5 до 12 бар; температура — до +95 °C; габариты — около 230×190×60 мм.',
            photoPath: 'sink_mixer.webp',
            quantity: 48,
          ),
        ),
  ]);
}

      // await createSpecializations(dependency);
      // await createDormitories(dependency);
      // await createRooms(dependency);
      // await createStudents(dependency);
      // await createMasters(dependency);
      // print('end');