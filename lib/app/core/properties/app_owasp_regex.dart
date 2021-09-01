//SOURCE: https://owasp.org/www-community/OWASP_Validation_Regex_Repository

const OWASP_SAFE_TEXT = r"^[a-zA-Z0-9 !.-]+$";
const OWASP_SAFE_NUMBER = r"[0-9.]+$";
const OWASP_SAFE_URL =
    "(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
