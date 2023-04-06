#start from specific Jupyter base notebook tag
FROM jupyter/base-notebook

MAINTAINER Sara Lambert <lambert8@illinois.edu>

RUN conda update -n base conda

RUN mkdir -p $HOME && fix-permissions $HOME

ENV UID ${NB_UID:-1000}
ENV GID 100

#unfortunately chown here cannot interpret env variables
#hence the hardcoded UID, GID
COPY --chown=$UID:$GID . $HOME

USER $NB_UID

WORKDIR $HOME

CMD ["start-notebook.sh","--NotebookApp.token="]
