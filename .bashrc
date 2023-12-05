# commands for fast accessing docker container
# for regular container
function dssh(){
	sudo docker exec -it $1 /bin/bash
}
# for alpine container
function dassh(){
	sudo docker exec -it $1 sh
}
