FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY target/classes /app/classes
COPY target/dependency /app/dependency

CMD ["java","-cp","./classes:./dependency/*","co.edu.escuelaing.reflexionlab.MicroServer"]