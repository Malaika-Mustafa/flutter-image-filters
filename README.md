# 📸 FilterSnap - A Flutter Image Filter App

FilterSnap is a simple Flutter application that allows users to:

- 📷 Pick an image from the gallery or take a new one using the camera using `image_picker`package
- 🎨 Apply filters using `photofilters` package
- 💾 Save the filtered image directly to the device gallery using `gallery_saver_plus`package

---

## 🚀 Features

- Pick images from **gallery** or **camera**
- Apply cool **image filters**
- Save edited images to the **device gallery**
- Uses `photo_filters`, `image_picker`, and `gallery_saver_plus`

---

## 🛠️ Packages Used

| Package            | Purpose                        |
| ------------------ | ------------------------------ |
| photofilters       | Filter editing UI              |
| image_picker       | Pick image from gallery/camera |
| image              | Image decoding                 |
| gallery_saver_plus | Save images to gallery         |
| path               | File path operations           |

---

## 🖼️ Screenshots

![Home Screen](screenshots/home_page.png)
![Image Picker Bottom Sheet](screenshots/image_picker.png)
![Apply Filters Screen](screenshots/apply_filters.png)

---

## 📦 How to Run

1. Clone the repository:

   ```bash
   git clone "https://github.com/Malaika-Mustafa/flutter-image-filters.git"
   cd project_folder
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## 📁 File Structure

```
lib/
├── main.dart
└── pick_image_screen.dart  
```

---

## ✅ TODOs

- Add custom filters
- Add cropping and rotation support
- Organize UI into separate widgets

---

## 👨‍💻 Author

Built with ❤️ by Malaika Mustafa

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
