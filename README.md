# docker remote database development

## docker wordpress environment connect to demo3 remote DB

## Getting Started

### Create .env file with APP_NAME and DOMAIN, then in project root create SSL cert for local domain

```
mkdir certs
cd cli
chmod +x create-cert.sh
./create-cert.sh
cd ../

```

### Update Nginx config file with APP_NAME and DOMAIN

```
cd nginx
chomod +x .update-nginx.sh
./update-nginx.sh
cd ../

```

### Add variables to env then

```
docker-compose build
docker-compose up -d
docker-compose down 

```

### In wp-config.php add

```
define('WP_CACHE', true); 
$currenthost = $_SERVER['HTTP_HOST']; 
$mypos = strpos($currenthost, 'localhost'); 
if ($mypos === false) { 
    define('WP_HOME','https://livedomain.com'); 
    define('WP_SITEURL','https://livedomain.com'); } 
else { 
    define('WP_HOME','http://localdomain.localhost'); 
    define('WP_SITEURL','http://localdomain.localhost'); 
}
```

### Change wp-content ownership to www-data

```
sudo chown -R www-data:www-data wp-content/
```