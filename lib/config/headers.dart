headersWithoutToken() => {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };

headersWithToken(String token) => {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Token $token',
    };
