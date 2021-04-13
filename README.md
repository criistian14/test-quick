# Test Quick

Prueba para la empresa Quick hecha en Flutter con [arquitectura limpia](https://www.youtube.com/playlist?list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech).
Es un chat realizado en Firebase, con funcionalidades como:
- Iniciar y cerrar sesion
- Editar perfil
- Chat en tiempo real con emoticones
- Enviar audios (voice notes) e imagenes

---

Escogi el manejador de estados [GetX](https://pub.dev/packages/get) ya que tiene una sintaxis facil, ademas de que separa la logica de la vista.
Tambien tiene algunas utilidades como el manejo de temas, internacionalización, snackbars, que ayudan en el desarrollo de la app.

Y se maneja arquitectura limpia ya facilita futuras actualizacione y mantener mejor la app.


# APK

El apk es completamente funcional y se puede descargar de [aqui](https://github.com/criistian14/test-quick/raw/dev/apk/testquick_christian.apk) (esta en la carpeta apk de este repositorio)

O si se desea se puede generar el apk, despues de descargar el repositorio localmente, con el siguiente comando:

```cmd
flutter build apk
```

# Recursos usados

- El [icono](https://www.flaticon.com/free-icon/speak_1653630) es de Flaticon
- El diseño del auth es del usuario [syedhaqil](https://dribbble.com/shots/12207505-Babble-Sign-in-Sign-up-UI/attachments/)
- El diseño general es del usuario [Abdullah](https://dribbble.com/shots/14582907-Freedom-Chatting-App)

# Librerias usadas

- [GetX](https://pub.dev/packages/get)
- [Firebase](https://firebase.flutter.dev/docs/overview/)
- [Flutter Native Splash](https://pub.dev/packages/flutter_native_splash)
- [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
- [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil)
- [Formz](https://pub.dev/packages/formz)
- [Image Picker](https://pub.dev/packages/image_picker)
- [Flutter Sound Lite](https://pub.dev/packages/flutter_sound_lite)
- [Permission Handler](https://pub.dev/packages/permission_handler)
- [Emoji Picker Flutter](https://pub.dev/packages/emoji_picker_flutter)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
