# Dask Distributed for Docker
Mostly follows [this tutorial](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/) 
and [this tutorial](https://docs.docker.com/engine/swarm/stack-deploy/#test-the-app-with-compose)
for setting up a Dask distributed compute cluster on AWS using Docker Swarm.

## Local Set Up
1) Clone the repo.
```commandline
git clone https://github.com/ameier38/docker-distributed
cd docker-distributed
```

2) Build the image and tag with your DockerHub username.
```commandline
docker build -t [username]/distributed:latest .
```

3) Push the image to DockerHub.
```commandline
docker push [username]/distributed:latest
```

4) Start the service locally.
```commandline
docker-compose up -d
```

5) Create a Miniconda virtual environment.
```commandline
conda env update -f client-environment.yml
activate py3
```

6) Start a Jupyter notebook.
```commandline
jupyter notebook
```

7) Open `Example.ipynb`.

8) Open the diagnostic page at `localhost:8787` to view the workers in real-time.

## Cluster Set Up
1) Create three EC2 instances on AWS with Python3, Miniconda, and Docker installed.
2) SSH onto one of the instances using the following:
```commandline
ssh -i path/to/key.pem ubuntu@[instance address]
```

3) Create the swarm manager.
```commandline
docker swarm init --advertise-addr [instance address]
```

4) Copy the worker connection command. It should look like the following:
```commandline
docker swarm join --token [TOKEN] [instance address]:2377
```

5) SSH onto each of the worker instances and enter the command from step (4).

6) SSH back onto the manager node from step (2).

6) Clone the repo.
```commandline
git clone https://github.com/ameier38/docker-distributed
cd docker-distributed
```

7) Deploy the service to the swarm. The name of the service can be
anything. I used `distributed` in this case.
```commandline
docker stack deploy --compose-file docker-compose.yml --with-registry-auth distributed
```

8) Get on the client machine and start at step (5) from Local Set Up.

9) The diagnostic page will instead be at the manager IP on port 8787.

## Network Diagnostic Commands
```commandline
apt-get install net-tools
netstat -tulpn
```

```commandline
apt-get install lsof
lsof -i
```

```commandline
apt-get install telnet
telnet scheduler 8786
```
