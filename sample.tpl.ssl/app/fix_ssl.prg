
// SSLeay_version() is deprecated in OpenSSL 1.1.0

// SSLeay_version() and SSLeay() are no longer available if OPENSSL_API_COMPAT is set to 0x10100000L. 
// Switched to using OpenSSL_version() instead.

#ifdef __SSL__

Function SSLeay_version()

Return OpenSSL_version()

#endif
