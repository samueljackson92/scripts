#!/bin/bash

#read the config file
echo "Reading Config..."
source ./wp-theme-sync.cfg

#pull files from the server to the local directory
function pull {
	echo "Pulling from $host..."
	sudo scp -r $username@$host:$wp_remote_dir/$1 $wp_local_dir
}

#push files to the server from the local directory
function push {
	echo "Pushing to $host..."
	sudo scp -r $wp_local_dir/$1 $username@$host:$wp_remote_dir
}

#archive the theme ready from export
function archive {
	cd $wp_local_dir
	echo "Archiving to $archive_dir..."
	zip -r "$1" "$1" 
	echo "Moving archive to directory..."
	mv "$1.zip" "$archive_dir/" 
}


#select between command line args
if [ "$1" == "pull" -a $# -eq 2 ]
then
	pull $2
elif [ "$1" == "push" -a $# -eq 2 ]
then	
	push $2
elif [ "$1" == "archive" -a $# -eq 2 ]
then
	archive $2
else
	echo "Usage: wp-theme-sync [options...]"
	echo
	echo "OPTIONS ------------------------"
	echo "push <theme-folder> - Send files to remote server"
	echo "pull <theme-folder> - Get files from remote server"
	echo "arhive <theme-folder> - Send file to archive"
fi

echo
echo "Done."
exit 0


