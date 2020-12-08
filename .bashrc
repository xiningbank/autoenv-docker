function md(){
	mkdir -p $1;
	cd $1;
}

function dssh(){
	docker exec -it $1 /bin/bash
}
