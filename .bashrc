function dssh(){
	sudo docker exec -it $1 /bin/bash
}
function dassh(){
	sudo docker exec -it $1 sh
}
