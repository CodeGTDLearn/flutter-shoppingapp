//SOURCE: https://owasp.org/www-community/OWASP_Validation_Regex_Repository

const SAFE_URL =
    r"^((((https?|ftps?|gopher|telnet|nntp)://)|(mailto:|news:))(%[0-9A-Fa-f]{2}|[-()_.!~*';/?:@&=+$,A-Za-z0-9])+)([).!';/?:,][[:blank:|:blank:]])?$";

const SAFE_TEXT = r"^[a-zA-Z0-9 !.-]+$";

const SAFE_NUMBER = r"[0-9.]+$";

//const URL_PATTERN =
//    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
