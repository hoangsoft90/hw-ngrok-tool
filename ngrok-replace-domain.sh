#------development
# arguments
# $1 ngrok ID

multisite_url="http://localhost/wpmultisite"
# we use `wp` command
wp search-replace "http://$1.ngrok.com" "http://localhost" --dry-run --site=localhost/wpmu

read -n1 -r -p "Press any key to continue..." key