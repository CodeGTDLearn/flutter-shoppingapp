//SOURCE: https://owasp.org/www-community/OWASP_Validation_Regex_Repository

const SAFE_TEXT = r"^[a-zA-Z0-9 !.-]+$";

const SAFE_NUMBER = r"[0-9. ]+$";

const SAFE_URL =
    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
