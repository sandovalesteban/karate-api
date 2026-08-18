function fn() {
  var env = karate.env || 'prod'; // -Dkarate.env=prod (default, no requiere Docker local)
  karate.log('karate.env =', env);

  var config = {
    env: env,
    baseUrl: 'https://quickpizza.grafana.com',
    authToken: 'abcdef0123456789'
  };

  if (env === 'local') {
    // Si en algún momento levantas QuickPizza con Docker localmente:
    // docker run -p 3333:3333 grafana/quickpizza
    config.baseUrl = 'http://localhost:3333';
  }

  if (env == 'qa') {
    config.baseUrl = 'https://quickpizza.grafana.com';
  }

  if (env == 'prod') {
    config.baseUrl = 'https://quickpizza.grafana.com';
  }

  // Timeouts razonables para no colgar el pipeline si la demo pública tarda
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 15000);

  return config;
}
