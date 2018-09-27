# clean history for
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html

ipython history clear

shred -u ~/.*history

# warning: won't be able to log in anymore. Must launch from new AMI
sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub