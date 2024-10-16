// import 'package:googleapis_auth/auth_io.dart';

// class AccessTokenFirebase {
//   static String firebaseMessagingScope =
//       'https://www.googleapis.com/auth/firebase.messaging';

//   Future<String> getAccessToken() async {
//     final client = await clientViaServiceAccount(
//         ServiceAccountCredentials.fromJson({
//           "type": "service_account",
//           "project_id": "accurate-scale-2024",
//           "private_key_id": "f28c870a6035891efed0ba2c9ac7ba5e044cad76",
//           "private_key":
//               "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDNQaYDVsQf8+nG\nLlIDEUN991N06S5Ogxrz3qlDadL6lnqVGzXn2khhzLcXvkSGnyHyagNBeRF/AxWY\nYigG4UskFiagr9fNKj5E1PNA1EfwAwVoJITVACCi/kUkBWwefqMtHcgE75Egb9Ht\nesK1WOMo7Thp+LtMD2FAr+ASj8yw5Q3OIxZE936+JqIlH7O58fo6wCSiU1mgjCsU\nQvA2+0mdfAHfChT8lwWXwrizS/t6d1yRGGRMsXfw938/87HqIxOeJ+dZG++CLyzi\ng2gislO5U0LHQ3rFbYE8c+JtYzUWenQXEcBiYV1jcvG28i0cwy7P3zMvEExIFAlL\nT4Doq4b3AgMBAAECggEAFRXr5Ibq0e+AMfw7L5Z77PpV5/o2aBle0POsRsEdy+Fe\niWfIs19AtU9O9dD1gDDjz1/lorm5uucJtmRLAV3ulq/x2usFi82NpQuNS7kjBLyC\nty6dOLZxI91kI+2srDtNLwrSq/MiYQcrtS45x2BwwZkRBQ3oy8j+sCMBLVb5a6iF\nBFHRNatwnz+pFuyqzAZZ9MQYeyEzYKm/TMxXOngLgJQXHl0aYr+d1TPnqEZtS0z7\nBF7VkLu2K6T72JCvILrFbWWu3RwrSug/QnZ3AbEOLxXT6WoJqqT+fSi4EPp6XoPZ\ne0FORLqoBBuQpnPErGt4eYtuA40ZmVX+trCULRzHvQKBgQDyw376hBegTW+4IJAx\nDDrycFSR/0DouET8h+E5npbQ+6YFRutl9HYeayzk3areQlZV5hEtbsFImmMhvSIV\ncbOf93wptgGqrK0MGemq86yyf9xyAtk0IkGO98XyAGRQgrxMeTnHc7oH7VwHYfPy\nKK3kCdXLgFFpgiE0edApU8az4wKBgQDYcqAYgLixTEuYmqcO59lKjqmoTWo4aHkS\nRoGdZGvs1JN5bjB9HHi3sDxv6xJsrou/rpbQ+ktB3JJyBfuybtGpwOdQtGvpRKIo\nSROqboBliibUwCiHSofKG8uSGTT9EK7ZmvY9L1YQ7luihaYHFLPldOpCvhWOluPA\nskSoCMGU3QKBgC5iYB6pooIEibYasrJMbe7ou5/xr4tHuhauN8B0pshjbMNRW6Tt\nYqxJOhi4qe8xqaFcBigyI0gmB47ovlxujy2fcd/eYM8lkyLeyKDbUkIA4DQAi1PE\nv9X7TZ0Bqikf8a6C8yFC4WamWZEnjB7W2vLZVjo92FBahtGp/LYIxcyVAoGANDVx\n6HckFaARm/2xziaegx1mTvJdbL3GdmILYauXXMjpyaCKkaMMe0JHUbeh+hUgIFw8\nhKva+0f5CwfmbmPMruWY5h6e6OVlN9Joq/N7hQKN20N+gyO3HUkXEWaDIYekpVh7\njMaeO/dCozEZmxujSPWqi+7NxFchGJnndaCnEQECgYA1A5qzpiiCae/Rr1bV0SY8\nH54VgaVDgkij4TbNH32j0vIgjdGpE2jBMXd8qYLQiEwYbKFqEaZ5r+XJXiZ8nZK+\nPvJilGvBJJfLAk0roAAEzeUYDZvfKvzi2ZaM0/4AQGMUxubBwMquhoDpkcNbuQDK\n2ENc9qiFEQt5oyzYy7fG/w==\n-----END PRIVATE KEY-----\n",
//           "client_email":
//               "firebase-adminsdk-2mfzi@accurate-scale-2024.iam.gserviceaccount.com",
//           "client_id": "108652425126841837403",
//           "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//           "token_uri": "https://oauth2.googleapis.com/token",
//           "auth_provider_x509_cert_url":
//               "https://www.googleapis.com/oauth2/v1/certs",
//           "client_x509_cert_url":
//               "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-2mfzi%40accurate-scale-2024.iam.gserviceaccount.com",
//           "universe_domain": "googleapis.com"
//         }),
//         [firebaseMessagingScope]);
//     final accessToken = client.credentials.accessToken.data;
//     return accessToken;
//   }
// }
