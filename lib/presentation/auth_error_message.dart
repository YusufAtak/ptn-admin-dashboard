String? authErrorText(String? messageKey) {
  return switch (messageKey) {
    null || 'auth.not_logged_in' => null,
    'auth.required_fields' => 'E-posta ve şifre alanlarını doldurun.',
    'auth.invalid_credentials' => 'E-posta veya şifre hatalı.',
    'auth.invalid_email' => 'Geçerli bir e-posta adresi girin.',
    'auth.user_disabled' => 'Bu kullanıcı hesabı devre dışı bırakılmış.',
    'auth.too_many_requests' =>
      'Çok fazla başarısız deneme yapıldı. Lütfen daha sonra tekrar deneyin.',
    'auth.network_error' =>
      'Bağlantı kurulamadı. İnternet bağlantınızı kontrol edin.',
    'auth.user_not_found' => 'Bu hesaba ait kullanıcı kaydı bulunamadı.',
    'auth.not_an_admin' => 'Bu hesabın admin paneline erişim yetkisi yok.',
    'auth.login_failed' ||
    'auth.unknown_error' => 'Giriş yapılamadı. Lütfen tekrar deneyin.',
    _ => 'Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.',
  };
}
