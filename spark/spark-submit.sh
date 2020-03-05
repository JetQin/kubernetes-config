# create service account
kubectl create serviceaccount spark --namespace=dev 
# create role binding
kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=dev:spark --namespace=dev 
 
 bin/spark-submit \
    --master k8s://https://192.168.64.5:8443 \
    --deploy-mode cluster \
    --name spark-pi \
    --class org.apache.spark.examples.SparkPi \
    --conf spark.kubernetes.namespace=dev \
    --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark\
    --conf spark.kubernetes.container.image=spark-py:2.4.5 \
    file:///opt/spark/examples/src/main/python/pagerank.py ../data/mllib/pagerank_data.txt 10
    file:///opt/spark/examples/src/main/python/wordcount.py /opt/spark/examples/src/main/python/wordcount.py
       #  --conf spark.executor.instances=1 \
   #  local:///opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar