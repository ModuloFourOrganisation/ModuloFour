FROM sagemath/sagemath:latest

# Install pip and Voilà
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install voila

# Expose the port for Voilà
EXPOSE 8866

# Run Voilà, pointing to your notebook file
CMD ["voila", "--no-browser", "--port=8866", "--ip=0.0.0.0", "c3voila.ipynb"]
