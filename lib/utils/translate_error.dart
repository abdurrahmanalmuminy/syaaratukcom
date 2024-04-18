String translateError(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'البريد الإلكتروني غير صحيح';
    case 'INVALID_LOGIN_CREDENTIALS':
      return 'البريد الإلكتروني او كلمة المرور غير صحيحة';
    case 'email-already-in-use':
      return 'البريد الإلكتروني مستخدم بالفعل';
    case 'wrong-password':
      return 'كلمة المرور غير صحيحة';
    case 'user-not-found':
      return 'البريد الإلكتروني غير مسجل';
    case 'weak-password':
      return 'كلمة المرور ضعيفة';
    case 'credential-already-in-use':
      return 'هذا الحساب مستخدم بالفعل';
    case 'network-request-failed':
      return 'فشل الإتصال، تأكد من اتصالك بالإنترنت';
    default:
      return 'حدث خطأ غير معروف: $errorCode';
  }
}