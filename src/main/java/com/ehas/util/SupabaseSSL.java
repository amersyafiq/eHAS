package com.ehas.util;

import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import java.io.InputStream;
import java.security.KeyStore;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;

public class SupabaseSSL {

    public static TrustManager[] createTrustManagers() {
        try {
            CertificateFactory cf = CertificateFactory.getInstance("X.509");

            InputStream certStream =
                SupabaseSSL.class
                    .getClassLoader()
                    .getResourceAsStream("storage-supabase-co.pem");

            if (certStream == null) {
                throw new RuntimeException(
                    "storage-supabase-co.pem not found in classpath");
            }

            Certificate caCert = cf.generateCertificate(certStream);

            KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
            ks.load(null, null);
            ks.setCertificateEntry("supabase", caCert);

            TrustManagerFactory tmf =
                TrustManagerFactory.getInstance(
                    TrustManagerFactory.getDefaultAlgorithm());

            tmf.init(ks);

            return tmf.getTrustManagers();

        } catch (Exception e) {
            throw new RuntimeException(
                "Failed to create Supabase TrustManagers", e);
        }
    }
}
