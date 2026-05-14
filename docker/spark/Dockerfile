FROM bitnami/spark:3.5.1

USER root

# Delta Lake + AWS S3 jars
RUN curl -fsSL https://repo1.maven.org/maven2/io/delta/delta-spark_2.12/3.1.0/delta-spark_2.12-3.1.0.jar \
      -o /opt/bitnami/spark/jars/delta-spark_2.12-3.1.0.jar && \
    curl -fsSL https://repo1.maven.org/maven2/io/delta/delta-storage/3.1.0/delta-storage-3.1.0.jar \
      -o /opt/bitnami/spark/jars/delta-storage-3.1.0.jar && \
    curl -fsSL https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar \
      -o /opt/bitnami/spark/jars/hadoop-aws-3.3.4.jar && \
    curl -fsSL https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar \
      -o /opt/bitnami/spark/jars/aws-java-sdk-bundle-1.12.262.jar

COPY spark-defaults.conf /opt/bitnami/spark/conf/spark-defaults.conf

USER 1001
