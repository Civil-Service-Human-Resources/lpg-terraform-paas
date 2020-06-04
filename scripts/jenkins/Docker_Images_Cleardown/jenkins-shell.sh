echo "++ CLEARING IDENTITY IMAGES ++" ; echo ">> Searching for images to remove:" ;  docker images -a | grep "identity" | awk '{print $3}' | xargs  docker rmi -f || true ;

echo "++ CLEARING LPG IMAGES ++" ; echo ">> Searching for images to remove:" ;  docker images -a | grep "lpg" | awk '{print $3}' | xargs  docker rmi -f || true ;

echo "++ CLEARING TS IMAGES ++" ; echo ">> Searching for images to remove:" ;  docker images -a | grep "data-tr" | awk '{print $3}' | xargs  docker rmi -f || true ; 

echo "++ PRUNING DANGLING IMAGES ++"  ; docker system prune -f

echo "++ FILESYSTEM ++" ; df -l