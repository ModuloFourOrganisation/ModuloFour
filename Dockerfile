FROM sagemath/sagemath:latest

# Switch to root to install packages
USER root

# Update the system and install pip
RUN apt-get update && apt-get install -y python3-pip

# Install Voilà
RUN pip3 install voila

# Switch back to the default user
USER sage

# Expose the port for Voilà
EXPOSE 8866

# Run Voilà, pointing to your notebook file
CMD ["voila", "--no-browser", "--port=8866", "--ip=0.0.0.0", "c3voila.ipynb"]
