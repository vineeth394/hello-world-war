ls
if [ -d hello-world-war ]
then 
rm -rf *
fi
ls
git clone https://github.com/vineeth394/hello-world-war.git
cd hello-world-war
mvn clean package
