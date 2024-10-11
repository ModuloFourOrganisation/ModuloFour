# Step 1: Use the SageMath image as the base
FROM sagemath/sagemath:latest

# Step 2: Ensure root permissions to install dependencies
USER root

# Step 3: Update apt and install Python 3 and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Step 4: Install pip for SageMath's Python environment
RUN sage --pip install --upgrade pip

# Step 5: Install Jupyter and Voilà using system pip
RUN pip3 install jupyter voila ipywidgets

# Step 6: Install ipykernel in SageMath's Python environment
RUN sage --pip install ipykernel

# Step 7: Install the SageMath kernel into Jupyter
RUN sage -python -m ipykernel install --user --name sagemath --display-name "SageMath"

# Step 8: Set the working directory inside the container
WORKDIR /app

# Step 9: Copy your local project files into the Docker container
COPY . /app

# Step 10: Trust the cleaned notebook (use test_cleaned.ipynb)
RUN jupyter trust test_cleaned.ipynb

# Step 11: Fix permissions in case of issues with access
RUN chmod -R 755 /app

# Step 12: Expose port 8888 so the app can be accessed
EXPOSE 8888

# Step 13: Command to run Voilà with your cleaned notebook
CMD ["voila", "test_cleaned.ipynb", "--port=8888", "--no-browser", "--Voila.ip=0.0.0.0", "--debug"]
