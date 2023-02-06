MKDIR		= mkdir -p ~/data/wp/ ~/data/db/
DOCKER		= docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env
PRUNE		= docker system prune
RM		= rm -rf
VOLUMES		= ~/data/wp/* ~/data/db/*

all:		up

up:
		$(MKDIR)
		$(DOCKER) up --build

down:
		$(DOCKER) down

clean:		down
		$(PRUNE)
		$(RM) $(VOLUMES)

fclean:
		$(DOCKER) down --volumes
		$(PRUNE) --all --force
		$(RM) $(VOLUMES)

re:		down up

.PHONY:		all up down clean fclean re
