# Jupyter dockerfile

Based on Jupyter's `all-spark-notebook`, this docker image provides the following:

### Components

* Jupyter Notebook 4.2.x
* Conda Python 3.x and Python 2.7.x environments
* Conda R 3.3.x environment
* Scala 2.10.x
* pyspark, pandas, matplotlib, scipy, seaborn, scikit-learn pre-installed for Python
* ggplot2, rcurl preinstalled for R
* Spark 1.6.0 for use in local mode or to connect to a cluster of Spark workers
* Mesos client 0.22 binary that can communicate with a Mesos master


### Running instructions

Execute the following in a terminal with `sudo` access:

```
docker run -d -p 8888:8888 -v /srv/jupyter:/home/jovyan/work -e NB_UID=1000 -e GRANT_SUDO=yes --user root jupyter/all-spark-notebook start-notebook.sh

```

This creates a personalised version of `all-spark-notebook` that mounts the `/srv/jupyter` folder of the host into the containers work directory, and grants `sudo` access to the `jovyan` user, useful for installing OS packages such as db connectors. Also specifies  the uid of the `jovyan` user, useful to mount host volumes with specific file ownership so they can be run by the web server.


