#Content to write into Virtual Host confing file
config="<VirtualHost *:80>
ServerName $1
ServerAlias $1
ServerAdmin webmaster@localhost
DocumentRoot $2
ErrorLog \${APACHE_LOG_DIR}/error.log
CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
<Directory $2>
Options Indexes FollowSymLinks MultiViews
AllowOverride All
Order allow,deny
allow from all
</Directory>";

#sudo touch /etc/apache2/sites-available/$1.conf
sudo echo "$config" > /etc/apache2/sites-available/$1.conf

#Enable the new virtual host
cd /etc/apache2/sites-available
sudo a2ensite $1.conf

#Create the desired web directory
sudo mkdir -p $2
sudo touch  $2 index.html

chmod 775 -R $2

#Write something into the web folder of the site
echo "Testing - $1" > $2/index.html
 
#Restart apache so virtual host changes take effect
sudo service apache2 restart

#Add domain to hosts file to make the site accessible
sudo sh -c "echo '127.0.0.1   $1' >> /etc/hosts"

echo "Setup Complete"