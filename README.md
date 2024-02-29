## Reflection

Selama proses membuat aplikasi ini, saya mempelajari banyak hal. Hal pertama yang saya pelajari adalah database `Isar`. Pada awalnya saya ingin menggunakan Hive. Namun, ketika membuka dokumentasi Hive, saya menemukan tulisan berikut di halaman paling awal _Before you start: Consider using Isar a Flutter database by the author of Hive that is superior in every way!_. Melihat hal tersebut, saya tertarik untuk mempelajari Isar. Salah satu referensi saya adalah [berikut](https://youtu.be/NuSb0wq9K-I?si=0ArR61cLU8bOGQpz). Penjelasan Isar pada video tersebut sangat mudah dipahami. Saya juga membaca-baca [dokumentasi](https://isar.dev/tutorials/quickstart.html) untuk mempelajari query-query pada Isar.

Saya juga belajar penggunaan `provider` sebagai _state management_. Salah satu sumber belajar yang saya gunakan adalah video [berikut](https://youtu.be/uQuxrZE2dqA?si=4pPoITDxVQsj49kt). Video untuk belajar Isar [sebelumnya](https://youtu.be/NuSb0wq9K-I?si=0ArR61cLU8bOGQpz) juga menggunakan provider sebagai _state management_. Dalam prosesnya, saya menemui beberapa masalah, salah satunya UI yang tidak ter-update walaupun data telah berubah. Hal tersebut akhirnya dapat diselesaikan dengan mengubah

```dart
ChangeNotifierProvider<TodoProvider>(
    create: (_) => TodoProvider(repository: TodoRepository()),
    child: const AddTodoPage(),
),
```

menjadi

```dart
ChangeNotifierProvider.value(
    value: context.read<TodoProvider>(),
    child: const AddTodoPage(),
),
```

Hal berikutnya yang saya pelajari adalah mengambil gambar dari galeri dan kamera. Saya menggunakan package `image_picker` untuk melakukan hal tersebut. Saya mempelajari hal tersebut dari beberapa webpage di google, salah satunya adalah [berikut](https://itchybumr.medium.com/flutter-tutorial-image-picker-picking-photos-from-camera-or-photo-gallery-5243a5eff6b4)

Hal lainnya yang saya pelajari adalah _scheduling task_. Untuk mengimplementasikan hal tersebut, saya sudah mencoba menggunakan [workmanager](https://pub.dev/packages/workmanager) dan [android_alarm_manager_plus](https://pub.dev/packages/android_alarm_manager_plus), tetapi tidak berhasil. Akhirnya, setelah mendapat saran dari kak Wayan Angga, saya mencoba menggunakan [cron](https://pub.dev/packages/cron) dan akhirnya berhasil. Saya mempelajari penggunaan cron melalui sumber [berikut](https://medium.com/flutterworld/flutter-run-function-repeatedly-using-cron-4aa030eda332)

Selain sumber pembelajaran yang saya sebutkan di atas, saya juga menggunakan ChatGPT serta Github Copilot untuk membantu saya semakin memahami materi. 

Proses pengerjaan tugas ini sangat menyenangkan bagi saya. Melalui tugas ini, saya bisa belajar banyak hal dan mencoba hal-hal baru. Meskipun terdapat beberapa permasalahan, saya justru jadi tertantang untuk mencari solusinya. Saya juga merasa bangga bisa menciptakan aplikasi yang bisa saya pakai sendiri.
