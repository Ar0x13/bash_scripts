#!/bin/bash
backup_dir="/home/user_space/Backups"
wp_db_pass="pass_phrase"
wp_database="WP_DB"
wp_root_dir="/var/www/html"
db_backup_name=""$wp_database"_`date +%Y-%M-%d-%H:%M:%S`".sql
wp_backup_files=""/home/user_space/Backups/wp_files"_`date +%Y-%M-%d-%H:%M:%S`"
new_wp_link="https://ru.wordpress.org/wordpress-4.6-ru_RU.tar.gz"
curdate=$(date +"%Y-%M-%d-%H:%M:%S")

#------------=======Functions========------------

#Backup mysql DB
backup_db () {
        echo -e "Creating mysql DB backup"
        mysqldump -u root -p$wp_db_pass "$wp_database"  > "$db_backup_name"
}

backup_wp_files () {
        echo -e "Creating WP files backup"
        tar -cvf "$wp_backup_files".tar /var/www/html
}

wp_new_release () {
        if [[ ! -e wordpress-4.6-ru_RU.tar.gz ]]
        then
                wget "$new_wp_link"
        else
                echo -e "You already have wordpress directory"
        fi
}

wp_extract () {
        tar -xzvf "wordpress-4.6-ru_RU.tar.gz"
}

wp_move2_web_root () {
        rm -rf /var/www/html
        mv "wordpress" "/var/www/html"
}

wp_change_files () {
        cp -frp $wp_backup_files/wp-config.php /var/www/html
        cp -frp $wp_backup_files/wp-content /var/www/html


}

#--------========MAIN CODE=========----------- 
#Script description
echo 
cat << EOF
This script update wordpress in manual mode.

1) It backups MariaDB files
2) Backup wordpress present files in /home/user_space/Backups
3) Download present version of wordpress (you must check link with official documentation)
4) Extract files into /home/user_space/Backups directory
5) Move Wordpress files to /var/www/html
6) Copy your last configuration and content to the new version of wordpress

Before you proceed => check for disabled status of all plugins  

EOF

answer () {
        echo -e "Are you checked for disabled plugins?"
        while read response; do
        echo
        case $response in
        [yY][eE][sS]|[yY])
                return 0
                break
                ;;
        [nN][oO]|[nN])
                exit 1
                ;;
                *)
                printf "Please, enter Y(yes) or N(no)! "
                esac
        done
}

cd "$backup_dir"
answer
backup_db
backup_wp_files
wp_new_release
wp_extract
wp_move2_web_root
wp_change_files

