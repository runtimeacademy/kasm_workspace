#!/usr/bin/env bash

#Docker File PreReq:
#sudo apt-get install expect
#copy file https://github.com/runtimeacademy/kasm_workspace.git/update_postgresql_user.sh 
#chmod +x update_postgresql_user.sh

# Start PostgreSQL service
sudo service postgresql start

# Set password for postgres user using expect
echo "Setting password for postgres user..."

# Create the expect script
cat << EOF > change_postgres_password.sh
#!/usr/bin/expect

set new_password "password"

spawn sudo passwd postgres
expect "Enter new UNIX password:"
send "\$new_password\r"
expect "Retype new UNIX password:"
send "\$new_password\r"
expect eof
EOF

# Make the expect script executable
chmod +x change_postgres_password.sh

# Run the expect script
./change_postgres_password.sh

# Remove the expect script after execution
rm change_postgres_password.sh

# Switch to postgres user and change password in PostgreSQL
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'your_new_password';"

# Update pg_hba.conf to change the authentication method from peer to md5
PG_HBA_CONF="/etc/postgresql/15/main/pg_hba.conf"
TEMP_PG_HBA_CONF="/tmp/pg_hba.conf"

# Modify pg_hba.conf
echo "Modifying pg_hba.conf to use md5 authentication..."
sudo cp $PG_HBA_CONF $TEMP_PG_HBA_CONF
sudo sed -i 's/local\s\+all\s\+postgres\s\+peer/local   all             postgres                                md5/' $TEMP_PG_HBA_CONF
sudo sed -i 's/local\s\+all\s\+all\s\+peer/local   all             all                                     md5/' $TEMP_PG_HBA_CONF

# Replace original pg_hba.conf with the modified version
sudo mv $TEMP_PG_HBA_CONF $PG_HBA_CONF

# Restart PostgreSQL service
sudo service postgresql restart

echo "PostgreSQL setup completed successfully."
