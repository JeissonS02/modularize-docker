# 🚀 Modularized Java Microserver with Docker & AWS

[![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=java)]
[![Maven](https://img.shields.io/badge/Maven-Build-blue?style=for-the-badge&logo=apachemaven)]
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)]
[![Docker Compose](https://img.shields.io/badge/Docker--Compose-Orchestration-384D54?style=for-the-badge&logo=docker&logoColor=white)]
[![AWS](https://img.shields.io/badge/AWS-EC2%20Deployed-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)]
[![License](https://img.shields.io/badge/License-MIT-black?style=for-the-badge)]



## 📌 Project Overview

This project implements a **custom Java Web Server and IoC Microframework** without using external frameworks such as Spring.

The application was designed to understand the internal behavior of modern backend frameworks by building core features from scratch, including request handling, routing, and dependency management.

The server is capable of:

- Handling **HTTP GET requests**
- Serving **HTML and static resources (PNG, etc.)**
- Extracting and injecting **query parameters**
- Mapping routes dynamically using **custom annotations**
- Executing controller methods via **Java Reflection**
- Supporting **concurrent request handling using threads**
- Implementing a **graceful shutdown mechanism**
- Deploying using **Docker containers**
- Orchestrating services with **Docker Compose**
- Running in the cloud using **AWS EC2**

This project demonstrates how a lightweight backend framework can be built from scratch and deployed in a modern cloud-native environment.

------------------------------------------------------------------------

## 🏗 Architecture

The system follows a **layered and modular architecture**, where each component is responsible for a specific task in the request-response lifecycle.

### 🔁 Request Flow

Client Browser  
↓  
HTTP Request  
↓  
MicroServer (Socket Server)  
↓  
RouteTable (Route Registry)  
↓  
ControllerScanner (IoC Loader)  
↓  
Controller Methods (@GetRoute)  
↓  
HTTP Response (HTML / PNG / String)

---

### 🧩 Component Description

#### 🖥 MicroServer
- Core of the application.
- Implements a **Socket-based HTTP server** using `ServerSocket`.
- Handles incoming client connections.
- Supports **concurrent requests** using threads.
- Delegates request processing to the routing system.

---

#### 🗺 RouteTable
- Acts as a **routing registry**.
- Maps URL paths to controller methods.
- Stores route definitions discovered at startup.

---

#### 🔍 ControllerScanner
- Implements a lightweight **IoC container**.
- Uses **Java Reflection** to scan classes in a package.
- Detects classes annotated with `@WebController`.
- Registers methods annotated with `@GetRoute` into the RouteTable.

---

#### ⚙️ Controller Methods
- Business logic layer.
- Methods annotated with `@GetRoute` define endpoints.
- Parameters are injected dynamically using `@QueryParam`.

---

#### 📦 QueryParser
- Extracts query parameters from the URL.
- Converts them into a key-value structure.
- Enables dynamic parameter injection into controller methods.

---

#### 📁 StaticFileHandler
- Handles requests for static resources.
- Serves files such as HTML and images (PNG).
- Determines the correct HTTP Content-Type.

---

### ⚡ Key Architectural Features

- **Modular Design** → Each component has a single responsibility.
- **Reflection-Based IoC** → Dynamic discovery and registration of controllers.
- **Annotation-Based Routing** → Clean and flexible endpoint definitions.
- **Concurrency Support** → Each request is handled in a separate thread.
- **Separation of Concerns** → Clear division between server, routing, and business logic.

------------------------------------------------------------------------


## 🧠 Core Concepts Demonstrated

### 1️⃣ HTTP Server Implementation

A lightweight HTTP server implemented using Java sockets:

```java
ServerSocket server = new ServerSocket(35000);
Socket client = server.accept();
```
The server listens for incoming connections, parses HTTP requests, and delegates processing to the routing system.

### 2️⃣ Reflection-based IoC Container

Controllers are discovered dynamically using Java Reflection::

```java
ControllerScanner.scan("co.edu.escuelaing.reflexionlab.demo");
```
Classes annotated with:
```java
@WebController
```
are automatically instantiated, and their methods are registered as HTTP endpoints.

### 3️⃣ Annotation-based Routing

Routes are defined using custom annotations:

```java
@GetRoute("/hello")
public String hello() {
    return "Hello World";
}
```
At startup, all annotated methods are mapped into the RouteTable, linking URLs to executable methods.

### 4️⃣ Query Parameter Injection

Query parameters are extracted from the URL and injected into controller methods.

Example request:

```bash
/greeting?name=Sebastian
```

```java
@GetRoute("/greeting")
public String greeting(@QueryParam(value="name", defaultValue="World") String name){
    return "Hello " + name;
}
```
The framework parses the query string and binds parameters automatically using annotations.

### 5️⃣ Static File Handling

The server supports static content delivery:

- HTML files

- Images (PNG)

Example:

```bash
http://localhost:35000/index.html
http://localhost:35000/logo.png
```
If no route matches, the server attempts to serve a static resource with the correct HTTP headers.

### 6️⃣ Concurrency Handling

Each client request is processed in an independent thread:

```java
new Thread(() -> {
    // request handling
}).start();
```
This allows the server to handle multiple requests simultaneously.

### 7️⃣ Graceful Shutdown

The server includes a shutdown hook to handle safe termination:

```java
Runtime.getRuntime().addShutdownHook(new Thread(() -> {
    System.out.println("Servidor apagándose correctamente...");
}));
```
This ensures proper resource management when the application stops.

### 8️⃣ Containerization with Docker

The application is packaged and executed inside a Docker container.
- Compiled classes and dependencies are copied into the container
- The application runs using the Java runtime inside the container
- Enables consistent deployment across environments


### 9️⃣ Service Orchestration with Docker Compose

Multiple services are orchestrated using Docker Compose:
- Web server container
- MongoDB container
This enables a multi-container architecture similar to real-world systems.

------------------------------------------------------------------------

## 📁 Project Structure

The project is organized following a modular structure:


    modularize-docker
    ├── .mvn/ # Maven configuration files
    ├── images/ # Screenshots and deployment evidence
    ├── src/
    │ └── main/
    │ ├── java/
    │ │ ├── co/edu/escuelaing/reflexionlab/
    │ │ ├── annotations/ # Custom annotations 
    │ │ ├── demo/ # Example controllers and endpoints
    │ │ ├── framework/ # Core framework logic 
    │ │ └── MicroServer.java # Main server entry point
    │ └── resources/ # Static resources (HTML, images)
    ├── target/ # Compiled classes and dependencies
    ├── Dockerfile # Docker image definition
    ├── docker-compose.yml # Multi-container orchestration
    ├── pom.xml # Maven configuration
    ├── .gitignore # Ignored files (including sensitive keys)
    └── README.md # Project documentation

------------------------------------------------------------------------


## ⚙️ Getting Started

### 📦 Prerequisites

Make sure you have installed:

- Java 17+
- Maven
- Git
- Docker
- Docker Compose
- AWS Account (for deployment)

------------------------------------------------------------------------

## 🔧 Installation

Clone the repository:

```bash
git clone https://github.com/JeissonS02/modularize-docker.git
cd modularize-docker
```

Compile the project:
```bash
mvn clean package
```

## ▶️ Running the Project (Local)
Run the micro server using Java:
```bash
java -cp target/classes co.edu.escuelaing.reflexionlab.MicroServer
```
The server will be available at:
```bash
http://localhost:35000
```

## 🐳 Running with Docker
Build the Docker image:
```bash
docker build -t microserver .
```
Run the container:
```bash
docker run -p 35000:35000 microserver
```
Access the application at:
```bash
http://localhost:35000
```

## 🐙 Running with Docker Compose
Start all services:
```bash
docker-compose up -d
```
Verify running containers:
```bash
docker ps
```
Access the application at:
```bash
http://localhost:35000
```

## ☁️ AWS Deployment

The application was deployed on an **AWS EC2 instance** using Docker containers.

---

### 🖥 EC2 Instance Setup

1. Launch an EC2 instance
2. Connect via SSH:

```bash
ssh -i microserver.pem ec2-user@<your-ec2-public-ip>
```
### ⚙️ Install Docker
Update the system:
```bash
sudo yum update -y
```
Install Docker:
```bash
sudo yum install docker -y
```
Start Docker service:
```bash
sudo service docker start
```
Add user to Docker group:
```bash
sudo usermod -a -G docker ec2-user
```
Log out and reconnect for changes to take effect.

### 🔐 Docker Hub Authentication

Login to Docker Hub:
```bash
docker login
```
### 📥 Pull Docker Image

Pull the deployed image:
```bash
docker pull jeissons02/microserver-final
```
### ▶️ Run Container on EC2

Run the container in detached mode and expose the port:
```bash
docker run -d -p 42000:35000 --name microserveraws jeissons02/microserver-final
```

🔓 Configure Security Group

In AWS EC2:

- Go to Security Groups
- Add an Inbound Rule:

| Type | Port | Source |
| :--- | :--- | :--- |
| Custom TCP | 42000 | 0.0.0.0/0 |

### 🌐 Access the Application

Use your EC2 public DNS:

```bash
http://<your-ec2-public-ip>:42000/hello
```
Example:

```bash
http://ec2-98-92-252-214.compute-1.amazonaws.com:42000/pi
```
This confirms that the application is successfully deployed and accessible over the internet.

## 📸 Deployment Evidence

![Maven Build](/images/maven-build-success.png)

Project compilation using Maven, generating the executable classes and dependencies

![Local Endpoints Test](/images/local-endpoints-test.png)

Testing HTTP endpoints locally using curl, validating query parameters and server responses.

![Docker Images and Endpoints](/images/docker-images-and-endpoints.png)

Verification of application responses and Docker images built for containerization.


![Docker Compose Containers](/images/docker-compose-containers.png)

Running multi-container architecture using Docker Compose (web server and MongoDB).

![Web Endpoints Browser](/images/web-endpoints-browser.png)

Web browser validation of multiple endpoints, confirming correct responses and dynamic parameter handling.

![Docker Desktop Compose](/images/docker-desktop-compose.png)

Docker Desktop view showing running containers managed by Docker Compose (web server and database).

![Docker Push](/images/docker-push-success.png)

Successful push of the Docker image to Docker Hub repository for cloud deployment.

![Docker Hub Repository](/images/dockerhub-repository.png)

Docker Hub repository containing the final application image ready for deployment.

![AWS EC2 Instance](/images/aws-ec2-instance.png)

AWS EC2 instance running the deployed application with public access configuration.

![AWS Security Group](/images/aws-security-group.png)

 AWS Security Group configuration allowing external access to port 42000.

![AWS SSH Connection](/images/aws-ssh-connection.png)

Secure SSH connection to the EC2 instance using the private key.

![AWS Docker Running](/images/aws-docker-running.png)

Docker container running on EC2 instance with exposed port configuration.

![AWS Endpoints Browser](/images/aws-endpoints-browser.png)

Public access to the deployed application on AWS EC2, validating multiple endpoints.


## 🎥 Deployment Video

Watch the full deployment process:

[▶️ Click here to watch the video](./images/deployment.mp4)


------------------------------------------------------------------------

## 📈 Learning Outcomes

Through this project, the following concepts and skills were developed:

- Understanding of how an **HTTP server works internally** using low-level Java sockets.
- Implementation of a **custom IoC container** using Java Reflection.
- Design of a **modular architecture** with clear separation of concerns.
- Creation of **annotation-based routing mechanisms** similar to modern frameworks.
- Handling of **query parameters and dynamic method invocation**.
- Implementation of **concurrent request processing using threads**.
- Development of a **graceful shutdown mechanism** for safe server termination.
- Integration of **static file serving** within a backend server.
- Containerization of applications using **Docker**.
- Orchestration of services using **Docker Compose**.
- Deployment of applications in the cloud using **AWS EC2**.
- Exposure of services through **public IP and port configuration**.
- Understanding of **cloud security concepts** such as Security Groups.

This project provides a strong foundation for understanding how modern backend frameworks and cloud-native applications are built and deployed.

------------------------------------------------------------------------

## 👨‍💻 Author

[![GitHub](https://img.shields.io/badge/GitHub-JeissonS02-181717?style=for-the-badge&logo=github)](https://github.com/JeissonS02)