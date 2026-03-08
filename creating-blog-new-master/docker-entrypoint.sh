#!/bin/bash
if [ -z "$USER_ID" ]; then
  echo "USER_ID variable is not defined."
  exit 1;
fi
if [ -z "$GROUP_ID" ]; then
  echo "GROUP_ID variable is not defined."
  exit 1;
fi

getent passwd $USER_ID > /dev/null
user_result=$?
getent group $GROUP_ID > /dev/null
group_result=$?

set -e

# Kernel parameters settings
/sbin/sysctl -w fs.inotify.max_user_watches=524288 > /dev/null

# User settings
USER=$USER_ID
unset USER_ID
GROUP=$GROUP_ID
unset GROUP_ID

if [ $user_result -ne 0 ]; then
  echo "docker:x:$USER:$GROUP:docker:/home/docker:/bin/bash" >> /etc/passwd
fi
if [ $group_result -ne 0 ]; then
  echo "docker:x:$GROUP:" >> /etc/group
fi

echo "docker ALL=NOPASSWD: ALL" > /etc/sudoers.d/docker

# Directories settings
chown $USER:$GROUP /home/docker
if [ ! -e /home/docker/.spring ]; then
  mkdir /home/docker/.spring
  chown $USER:$GROUP /home/docker/.spring
fi

# Exec
exec gosu $USER:$GROUP "$@"
