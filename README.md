# 🚌 Piton Pass - Admin Dashboard

**Piton Pass Admin Dashboard**, akıllı toplu taşıma sistemi için geliştirilmiş; gerçek zamanlı metrik takibi, yolcu analitiği, bilet/harcama grafikleri ve kullanıcı tipi yönetimi sağlayan kurumsal bir **Flutter Web** yönetim panelidir.

Proje, **Clean Architecture** (Katmanlı Mimari) ve **Feature-First** yaklaşımıyla, **Riverpod** ve **GetIt/Injectable** kullanılarak en yüksek kod kalitesi ve test edilebilirlik standartlarında geliştirilmiştir.

---

## 🚀 Temel Özellikler

- 🔐 **Rol Tabanlı Yetkilendirme (RBAC):** Firebase Auth e-posta/şifre girişi ve Firestore `role: "admin"` yetki doğrulaması. Admin olmayan kullanıcıların panele erişimi engellenir.
- 📊 **Gerçek Zamanlı Özet Kartları (Summary Cards):** 
  - Toplam yolcu sayısı
  - Bugünkü toplam biniş
  - Sistemdeki toplam cüzdan bakiyesi
  - Toplam hasılat (ciro)
- 📈 **Haftalık İnteraktif Grafikler (FL Chart):**
  - **Günlük Biniş Sayıları:** Son 7 günün başarılı biniş trendini gösteren çubuk grafik (Bar Chart).
  - **Günlük Gelir Akışı:** Son 7 günün harcama ve gelir dağılımını gösteren çizgi grafik (Line Chart).
- 👥 **Yolcu Yönetim Tablosu (User Table):**
  - Son kayıt olan yolcuların ID, isim, e-posta, anlık bakiye ve tarife bilgileri.
  - Tablo üzerinden anında kullanıcı tipi güncelleme (Tam, Öğrenci, Yaşlı) ve anlık Firestore senkronizasyonu.
- 🌓 **Tema Desteği:** Koyu (Dark) ve Açık (Light) tema geçişi (`SharedPreferences` yerel kalıcılığı ile).
- 🌐 **Çoklu Dil Desteği (i18n):** Türkçe ve İngilizce dil seçeneği (`LocaleNotifier` + `EasyLocalization` reaktif mimarisi ile beyaz flaşsız pürüzsüz geçiş).
- 📱 **Duyarlı (Responsive) Tasarım:** Masaüstü, tablet ve mobil tarayıcılara uyarlanabilir akıllı flex/grid yerleşimi.

---

## 🏗️ Mimari & Teknoloji Yığını

```
ptn_admin_dashboard/
├── lib/
│   ├── constants/             # UPPER_SNAKE_CASE ve top-level merkezi sabitler (renk, boyut, path vb.)
│   ├── core/                  # Çekirdek modüller (DI, theme, localization, routing, errors)
│   │   ├── di/                # GetIt + Injectable bağımlılık enjeksiyonu & Riverpod provider'ları
│   │   ├── localization/      # Riverpod LocaleNotifier
│   │   ├── router/            # GoRouter yapılandırması ve yönlendirme kontrolleri
│   │   └── theme/             # Light/Dark AppTheme ve ThemeModeNotifier
│   ├── features/              # Feature-First modülleri
│   │   ├── auth/              # Giriş ve kimlik doğrulama (Data, Domain, Presentation)
│   │   └── dashboard/         # Dashboard metrikleri, grafikler ve kullanıcı tablosu
│   ├── services/              # Dış servisler (FirestoreService, FirebaseAuthService)
│   ├── bootstrap.dart         # Uygulama başlangıç yapılandırmaları
│   └── my_app.dart            # Kök MaterialApp.router bileşeni
└── test/                      # Birim, widget, use-case ve mimari konvansiyon testleri
```

### Kullanılan Teknolojiler & Paketler

| Kategori | Teknoloji / Paket |
| :--- | :--- |
| **State Management** | `hooks_riverpod`, `flutter_hooks` |
| **Dependency Injection** | `get_it`, `injectable` |
| **Routing** | `go_router` |
| **Backend & Veritabanı** | `firebase_core`, `firebase_auth`, `cloud_firestore` |
| **Grafikler** | `fl_chart` |
| **Yerelleştirme** | `easy_localization` |
| **Fonksiyonel Programlama** | `fpdart` (`Either`, `TaskEither`) |
| **İmmutability & Serialization** | `freezed`, `json_serializable` |
| **Yerel Depolama** | `shared_preferences` |

---

## ⚙️ Kurulum ve Çalıştırma

### Gereksinimler
- **Flutter SDK:** `^3.10.0` veya üzeri
- **Dart SDK:** `^3.10.0` veya üzeri
- **Tarayıcı:** Google Chrome / Edge

### Adımlar

1. **Bağımlılıkları Yükleyin:**
   ```bash
   flutter pub get
   ```

2. **Kod Üretimini Çalıştırın (Injectable & Freezed):**
   ```bash
   dart run build_runner build -d
   ```

3. **Web Uygulamasını Başlatın:**
   ```bash
   flutter run -d chrome
   ```

---

## 🧪 Test ve Kalite Güvencesi

Projede Domain, Data, Presentation ve Mimari Kuralları kapsayan kapsamlı bir test altyapısı bulunmaktadır.

Tüm testleri çalıştırmak için:
```bash
flutter test
```

Statik kod analizini çalıştırmak için:
```bash
flutter analyze
```

### Test Kapsamı
- ✅ **Use-Case & Repository Testleri:** Auth ve Dashboard akışlarının, hata durumlarının ve veri haritalamalarının doğrulanması.
- ✅ **Widget Testleri:** `DashboardPage` render, dil değişimi, tema geçişi ve responsive boyut tepkileri.
- ✅ **Mimari Konvansiyon Testleri:** Domain katmanının UI/Framework bağımsızlığı ve sunum katmanının servis izolasyonu.
- ✅ **Yerelleştirme Testleri:** Türkçe ve İngilizce dil dosyalarının anahtar tutarlılığı ve hardcoded metin denetimi.

---

## 📐 Sabitler & İsimlendirme Standartları

Projedeki tüm görsel ve iş kuralı sabitleri, mobil uygulama (`ptn-pass-intern`) ile %100 eşzamanlı olacak şekilde **`UPPER_SNAKE_CASE`** ve üst düzey (top-level) sabitler olarak tanımlanmıştır:
- Firestore Yolları & Alanları: `PATH_USERS`, `FIELD_ROLE`, `FIELD_USER_TYPE`, `USER_ROLE_ADMIN`
- Boyutlar & Aralıklar: `pagePadding`, `contentGap`, `iconButton`, `breakpointMobile`
- Renkler & Opaklıklar: `PRIMARY`, `BG_COLOR`, `HALF`, `CHART_AREA`
