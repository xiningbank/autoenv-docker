function dssh(){
	docker exec -it $1 /bin/bash
}
function dassh(){
	docker exec -it $1 sh
}
