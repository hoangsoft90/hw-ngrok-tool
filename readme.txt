changeurl.php file moved to http://localhost/wpmultisite/hoang/hw-changeurl.php?domain=localhost

don't set home & site url in wp-admin/options.php ->because you still access this site with localhost domain
comment this line: //define('DOMAIN_CURRENT_SITE', '2250aa09.ngrok.com'); allow you access from localhost domain
and change domain field from wp_blogs table